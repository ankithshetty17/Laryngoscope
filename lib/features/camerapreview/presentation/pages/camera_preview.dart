import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewPage extends StatefulWidget {
  const CameraPreviewPage({super.key});

  @override
  State<CameraPreviewPage> createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false; // To track initialization status

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Get available cameras
      cameras = await availableCameras();

      // If no cameras are available, throw an error
      if (cameras.isEmpty) {
        throw Exception('No cameras available');
      }

      // Initialize the first camera
      cameraController = CameraController(
        cameras[0], // Use the first camera (front or back depending on index)
        ResolutionPreset.high,
      );

      // Initialize the controller and wait for it to finish
      await cameraController.initialize();

      if (!mounted) return; // Check if widget is still mounted

      setState(() {
        isCameraInitialized = true; // Update initialization status
      });
    } catch (e) {
      // Handle any errors during initialization
      debugPrint("Error initializing camera: $e");
      setState(() {
        isCameraInitialized = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the camera controller to free up resources
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator until the camera is initialized
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: isCameraInitialized
          ? AspectRatio(
              aspectRatio: cameraController.value.aspectRatio,
              child: CameraPreview(cameraController),
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Show progress until camera is ready
    );
  }
}
