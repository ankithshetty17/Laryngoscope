import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:laryngoscope/core/app_pallette.dart';

class CameraPreviewWidget extends StatefulWidget {
  const CameraPreviewWidget({super.key});

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController cameraController;
  late List<CameraDescription> cameras; 

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Get available cameras
    cameras = await availableCameras();

    // Initialize the first camera
    cameraController = CameraController(
      cameras[0], // Use the first camera (front or back depending on index)
      ResolutionPreset.high,
    );

    // Initialize the controller and set state when done
    await cameraController.initialize();
    if (!mounted) return; // Make sure the widget is still mounted before calling setState
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose the camera controller to free up resources
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Return a widget showing camera preview if initialized
    return Stack(
      children: [
    SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child:
    cameraController.value.isInitialized
        ? AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: CameraPreview(cameraController),
          ): Center(child: CircularProgressIndicator()),
    ),
    Positioned(
      bottom: MediaQuery.of(context).size.height*0.02,
      right:  MediaQuery.of(context).size.width*0.05,
      child: FloatingActionButton(onPressed: (){},
      backgroundColor: AppPallette.buttonBg,
      elevation: 0,
    child: Icon(Icons.cameraswitch,color: AppPallette.iconBg,),))
       ],
     ); // Show progress while initializing
  }
}
