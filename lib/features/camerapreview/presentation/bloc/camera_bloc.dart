import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
   final ImagePicker _picker = ImagePicker();
  CameraBloc() : super(CameraInitial()) {
     on<OpenCameraEvent>((event, emit) async {
      // Request permissions
      PermissionStatus cameraPermission = await Permission.camera.request();
      PermissionStatus storagePermission = await Permission.storage.request();

      if (cameraPermission.isGranted && storagePermission.isGranted) {
        emit(CameraCaptureInProgress());
      } else {
        emit(CameraCaptureFailure('Permissions not granted'));
      }
    }
    );

    on<CaptureImageEvent>((event, emit) async {
      try {
        // Launch the camera to capture a photo
        final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

        if (photo != null) {
          // Save the image to the device gallery
          await GallerySaver.saveImage(photo.path);

          emit(CameraCaptureSuccess(photo.path));
        } else {
          emit(CameraCaptureFailure('No image captured.'));
        }
      } catch (e) {
        emit(CameraCaptureFailure('Failed to capture image: $e'));
      }
    });
    
  }
}
