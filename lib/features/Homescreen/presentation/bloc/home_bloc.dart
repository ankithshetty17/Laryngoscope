import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool _showAppBar = true;
  late CameraController cameraController;
   final ImagePicker _imagePicker = ImagePicker();
  int selectedCameraIndex = 0;
  late Battery _battery; 
  Timer? _timer;
  List<CameraDescription> cameras = [];
  HomeBloc() : super(HomeInitial()) {
//bodyclicked
    on<BodyClicked>((event, emit) {
      _showAppBar = !_showAppBar;
      emit(AppBarToggleSuccess(showAppBar: _showAppBar));
    });
//screenrotation
    on<OnScreenOrientation>((event, emit) {
      emit(ScreenOrientationChanged());
    });

//cameratoggle
    // on<CameraToggleEvent>((event, emit) async {
    //   try {
    //     // Get available cameras if not already fetched
    //     if (cameras.isEmpty) cameras = await availableCameras();

    //     // Switch to the next camera
    //     selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

    //     // Dispose the current controller
    //     await cameraController.dispose();

    //     // Initialize the new camera
    //     cameraController = CameraController(
    //       cameras[selectedCameraIndex],
    //       ResolutionPreset.high,
    //     );
    //     await cameraController.initialize();

    //     // Emit the updated camera controller state
    //     emit(CameraToggleSuccess(cameraController));
    //   } catch (e) {
    //     emit(CameraToggleFailure('Camera toggle failed: ${e.toString()}'));
    //   }
    // }
    // );

    on<CheckBatteryLevel>((event, emit) async {
      try {
        final batteryLevel = await _battery.batteryLevel;

        if (batteryLevel < 80) {
          emit(BatteryLow(batteryLevel));
        } else {
          emit(BatteryNormal());
        }
      } catch (e) {
        emit(BatteryNormal());
      }
    });
      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
            add(CheckBatteryLevel());
        });


      on<VideoCallIconClicked>((event, emit) {
        emit(LoadVideoCallPage());
      });


       on<CameraIconClickedEvent>((event, emit) async {
      // Request permissions
      // PermissionStatus cameraPermission = await Permission.camera.request();
      // PermissionStatus storagePermission = await Permission.storage.request();

      // if (cameraPermission.isGranted && storagePermission.isGranted) {
      //   emit(CameraCaptureInProgress());

      // } else {
      //   emit(CameraCaptureFailure('Permissions not granted'));
      // }

       try {
        // Open the system camera
        await _imagePicker.pickImage(source: ImageSource.camera);
      } catch (e) {
        emit(OpenCameraFailure('Failed to launch camera: $e'));
      }
    }
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
  
}
