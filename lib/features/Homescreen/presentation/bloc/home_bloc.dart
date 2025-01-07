import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
   bool _showAppBar = true;
   late CameraController cameraController;
   int selectedCameraIndex = 0;
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
   on<CameraToggleEvent>((event, emit) async{
       try {
        // Get available cameras if not already fetched
        if (cameras.isEmpty) cameras = await availableCameras();

        // Switch to the next camera
        selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

        // Dispose the current controller
        await cameraController.dispose();

        // Initialize the new camera
        cameraController = CameraController(
          cameras[selectedCameraIndex],
          ResolutionPreset.high,
        );
        await cameraController.initialize();

        // Emit the updated camera controller state
        emit(CameraToggleSuccess(cameraController));
      } catch (e) {
        emit(CameraToggleFailure('Camera toggle failed: ${e.toString()}'));
      } 
   });
   }  

  @override
  Future<void> close() {
    cameraController.dispose();
    return super.close();
  }
   
  }
    
    

