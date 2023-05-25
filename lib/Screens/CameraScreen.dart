import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatssap/Screens/ViewImage.dart';

List<CameraDescription> cameras = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late Future<void> cameraValue;
  CameraController? _controllerCamera;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerCamera!.dispose();
  }

  takePhoto(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}");
    await _controllerCamera?.takePicture();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return ImageReadPage(path: path);
      },
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCamera = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _controllerCamera!.initialize();
    print(cameras[
        0]); // return this CameraDescription(0, CameraLensDirection.back, 90)
    // print(cameras[1]) // CameraDescription(1, CameraLensDirection.front, 270)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            FutureBuilder(
              future: cameraValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(
                      _controllerCamera!,
                    ),
                  );
                } else
                  return CircularProgressIndicator();
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.flash_off),
                      IconButton(
                        onPressed: () async {
                          await takePhoto(context);
                        },
                        icon: Icon(
                          Icons.panorama_fish_eye,
                          size: 70,
                        ),
                      ),
                      Icon(Icons.flip_camera_ios)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
