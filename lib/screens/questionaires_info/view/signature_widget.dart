import 'dart:typed_data';
import 'dart:io';
import 'dart:ui';
import 'package:clean_arch_base/repository/model/attachment.output_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_module/app_services/attachment.app_service.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/model/from_model.dart';

class SignatureWidget extends StatefulWidget {
  final Question question;
  final GlobalKey<FormState> formKey; // Accept _formKey

  const SignatureWidget({Key? key, required this.question, required this.formKey}) : super(key: key);

  @override
  _SignatureWidgetState createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  String? _signaturePath;
  bool _isDrawing = false; // Tracks if the user is drawing
  List<AttachmentDetailOutputModel> _attachments = [];

  @override
  void initState() {
    super.initState();
    _attachments=[];
    _signaturePath = widget.question.answer as String?;
    _attachments=parseAttachmentsFromString(_signaturePath);

  }
  AttachmentAppService attachmentAppService = AttachmentAppService();


  String getCommaSeparatedValues(List<AttachmentDetailOutputModel> attachments) {
    return attachments
        .map((attachment) =>
    '${attachment.link ?? ''},${attachment.extension ?? ''},${attachment.attachmentId ?? ''}')
        .join(',');
  }

  List<AttachmentDetailOutputModel> parseAttachmentsFromString(String? input) {
    if ( input == null || input.isEmpty ) return [];

    List<String> items = input.split(','); // Split by commas
    List<AttachmentDetailOutputModel> attachments = [];

    // Ensure we process in sets of 3 (link, extension, attachmentId)
    for (int i = 0; i < items.length; i += 3) {
      attachments.add(AttachmentDetailOutputModel(
        link: items[i].trim().isNotEmpty ? items[i].trim() : null,
        extension: (i + 1) < items.length ? items[i + 1].trim() : null,
        attachmentId: (i + 2) < items.length ? items[i + 2].trim() : null,
      ));
    }

    return attachments;
  }
  Future<void> _saveSignature(FormFieldState<String> fieldState) async {
    final data = await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
    if (data == null) return;

    final ByteData? byteData = await data.toByteData(format: ImageByteFormat.png);
    if (byteData == null) return;

    final Uint8List buffer = byteData.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/signature_${widget.question.id}${Uuid().v1()}.png';
    final File file = File(filePath);
     await file.writeAsBytes(buffer);

    List<AttachmentDetailOutputModel> res = await attachmentAppService.uploadAttachmentFiles(const Uuid().v1(), [file]);
    _attachments=res;
    widget.question.answer =getCommaSeparatedValues(res);
    _signaturePath = filePath;
    _isDrawing = false; // Reset drawing flag
    setState(() {

    });


    fieldState.didChange(filePath);



    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(SharedLocalization.getLocalization!().saveclientSignature)));
  }

  void _clearSignature(FormFieldState<String> fieldState) {
    _signaturePadKey.currentState?.clear();
    setState(() {
      _signaturePath = null;
      widget.question.answer = null;
      _isDrawing = false;
    });

    fieldState.didChange(null);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        if (widget.question.isRequired && (value == null || value.isEmpty)) {
          return SharedLocalization.getLocalization!().clientSignatureError; // Error message
        }
        return null;
      },
      builder: (FormFieldState<String> fieldState) {
        return Column(
          children: [

            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: fieldState.hasError ? Colors.red : Colors.grey),
                  ),
                  child:
                  _signaturePath != null
                      ? Stack(
                    children: [
                      _attachments.length>0?
                      Image.network(
                        _attachments[0].link ?? '',
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child; // Image is fully loaded
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null, // Show progress if available
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, color: Colors.red),
                      ):SizedBox(), // Load saved signature
                      Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            setState(() => _signaturePath = null);
                            fieldState.didChange(null);
                          },
                        ),
                      ),
                    ],
                  )
                      : SfSignaturePad(
                    key: _signaturePadKey,
                    minimumStrokeWidth: 1,
                    maximumStrokeWidth: 3,
                    strokeColor: Colors.black,
                    backgroundColor: Colors.white,
                    onDraw: (x,y) {
                      setState(() {
                        _isDrawing = true;
                      });
                    },
                  ),
                ),

                // Floating Save Button
                if (_isDrawing)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.green,
                      onPressed: () => _saveSignature(fieldState),
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  ),

                // Floating Clear Button
                if (_signaturePath != null || _isDrawing)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: Colors.red,
                      onPressed: () => _clearSignature(fieldState),
                      child: Icon(Icons.clear, color: Colors.white),
                    ),
                  ),
              ],
            ),

            if (fieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  fieldState.errorText ?? '',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }
}
