import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageReadPage extends StatefulWidget {
  const ImageReadPage({super.key, required this.path});
  final String? path;

  @override
  State<ImageReadPage> createState() => _ImageReadPageState();
}

class _ImageReadPageState extends State<ImageReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.file(
        File(widget.path!),
        fit: BoxFit.cover,
      )),
    );
  }
}
