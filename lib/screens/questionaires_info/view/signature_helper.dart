import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
ValueNotifier<String?> signatureNotifier = ValueNotifier<String?>(null);

Future<String?> saveSignature() async {
  final data = await _signaturePadKey.currentState?.toImage(pixelRatio: 3.0);
  if (data == null) return null;

  final ByteData? byteData = await data.toByteData(format: ImageByteFormat.png);
  if (byteData == null) return null;

  final Uint8List buffer = byteData.buffer.asUint8List();

  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/signature.png';
  final File file = File(filePath);
  await file.writeAsBytes(buffer);

  signatureNotifier.value = filePath;
  return filePath; // Return the saved file path
}
