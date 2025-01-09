part of 'camera_bloc.dart';

@immutable
sealed class CameraState {}

final class CameraInitial extends CameraState {}

class CameraCaptureInProgress extends CameraState {}

class OpenCameraSuccess extends CameraState{
  final String imagePath;
  OpenCameraSuccess(this.imagePath);
}


class OpenCameraFailure extends CameraState{
  final String error;
  OpenCameraFailure(this.error);
}
