import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_module/constants/app.consts.dart';
import 'package:shared_module/localization/shared.localization.dart';
import '../../../domain/model/make_form_template/form_item_model.dart';







class AttachmentWidget extends StatefulWidget {
  final FormItem formItem;

  AttachmentWidget({required this.formItem});

  @override
  _AttachmentWidgetState createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  List<String> _attachments = [];
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
              final galleryImages = await picker.pickMultiImage();
              Navigator.pop(context, galleryImages);
            },
          ),
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text("Choose PDF(s)"),
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
                allowMultiple: true,
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

    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      setState(() {
        _attachments.addAll(selectedFiles.map((file) => file!.path).toList());
      });
    }
  }

  void _deleteAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
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
            height: 150,
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
                      size: 50, color: Colors.grey),
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
                Icon(Icons.attach_file, size: 50, color: Colors.grey),
                Text(
                  "${_attachments.length} attachments selected",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        if (formItem.isRequired && _attachments.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'This field is required',
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
              leading: file.endsWith(".pdf")
                  ? Icon(Icons.picture_as_pdf, color: Colors.red)
                  : Image.file(File(file), width: 50, height: 50, fit: BoxFit.cover),
              title: Text(
                file.split('/').last,
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