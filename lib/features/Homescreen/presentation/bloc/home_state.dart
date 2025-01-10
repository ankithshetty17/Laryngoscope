part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class AppBarToggleSuccess extends HomeState {
  final bool showAppBar;
  AppBarToggleSuccess({required this.showAppBar});
}

//screenorientation
class ScreenOrientationChanged extends HomeState {}

//camrea toggle on succcess
class CameraToggleSuccess extends HomeState {
  final CameraController cameraController;
  CameraToggleSuccess(this.cameraController);
}

//cameratoggle failure
class CameraToggleFailure extends HomeState {
  final String error;
  CameraToggleFailure(this.error);
}

//battery low
class BatteryLow extends HomeState {
  final int batteryLevel;

  BatteryLow(this.batteryLevel);
}

//battery normal
class BatteryNormal extends HomeState {}

class LoadVideoCallPage extends HomeState{}


class OpenCameraSuccess extends HomeState{
  final String imagePath;
  OpenCameraSuccess(this.imagePath);
}


class OpenCameraFailure extends HomeState{
  final String error;
  OpenCameraFailure(this.error);
}
