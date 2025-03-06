import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arch_base/repository/model/attachment.output_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_module/app_services/attachment.app_service.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/model/from_model.dart';
import '../../../domain/model/make_form_template/questionaires_item.dart';

import 'package:shared_module/localization/shared.localization.dart';

import '../../../presentation/resources/color_manager.dart';






class AttachmentWidget extends StatefulWidget {
  final Question formItem;

  const AttachmentWidget({super.key, required this.formItem});

  @override
  _AttachmentWidgetState createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  List<AttachmentDetailOutputModel> _attachments = [];
  AttachmentAppService attachmentAppService = AttachmentAppService();


  @override
  void initState() {
    // TODO: implement initState
    _attachments=parseAttachmentsFromString(widget.formItem.answer);
    super.initState();
  }
  void _showAttachmentPicker() async {
    final picker = ImagePicker();

    // Show options to pick images or PDFs
    final List<XFile?>? selectedFiles = await showModalBottomSheet<List<XFile?>>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(SharedLocalization.getLocalization!().from_camera),
            onTap: () async {
              final cameraImage = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, cameraImage != null ? [cameraImage] : []);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(SharedLocalization.getLocalization!().from_gallery),
            onTap: () async {
              final galleryImages = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, galleryImages != null ? [galleryImages] : []);

            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text("Choose PDF(s)"),
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
                allowMultiple: false,
              );

              Navigator.pop(
                  context,
                  result != null
                      ? result.paths.map((path) => XFile(path!)).toList()
                      : []);
            },
          ),
        ],
      ),
    );

    print("selectedFiles.... ${selectedFiles?.length}");
    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      List<AttachmentDetailOutputModel> res = await attachmentAppService.uploadAttachmentFiles(const Uuid().v1(), [File(selectedFiles[0]?.path??'')]);

      setState(() {
        _attachments.addAll(
            //selectedFiles.map((file) => file!.path).toList()
            res
        );
        widget.formItem.answer =getCommaSeparatedValues(_attachments);
      });
    }
  }

  void _deleteAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
       widget.formItem.answer =getCommaSeparatedValues(_attachments);
    });
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
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
  @override
  Widget build(BuildContext context) {
    final formItem = widget.formItem;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:_showAttachmentPicker,

    //           (){
    //         selectFirstBranchLocation(LatLng(30.044420,31.235712),false);
    // },
          //,
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 0.7),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: _attachments.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 24 , color: Colors.grey),
                  Text(
                    "${SharedLocalization.getLocalization!().tap_upload_image}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.attach_file, size: 24, color: Colors.grey),
                Text(
                  "${_attachments.length} ${SharedLocalization.getLocalization!().attachments_selected}",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        if (formItem.isRequired && _attachments.isEmpty)
           Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              SharedLocalization.getLocalization!().filedRequired,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _attachments.length,
          itemBuilder: (context, index) {
            final file = _attachments[index];
            return ListTile(
              onTap: (){
                openUrl(file.link ?? '');
              },
              leading: file.extension?.contains("pdf") ?? false
                  ?  Container(
                width: 50,
                    height: 50,
                    child: Icon(Icons.picture_as_pdf,
                    size: 32,
                    color: Colors.red),
                  )
                  : CachedNetworkImage(
                imageUrl: file.link ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: ColorManager.primary,
                        )),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.info)),
              ),
             // Image.network(file,width: 50, height: 50, fit: BoxFit.cover),
              //Image.file(File(file), width: 50, height: 50, fit: BoxFit.cover),
              title: Text(
                file.link!.split('/').last,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => _deleteAttachment(index),
              ),
            );
          },
        ),
      ],
    );
  }
}