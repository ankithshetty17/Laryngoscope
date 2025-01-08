part of 'camera_bloc.dart';

@immutable
sealed class CameraState {}

final class CameraInitial extends CameraState {}

class CameraCaptureInProgress extends CameraState {}

class CameraCaptureSuccess extends CameraState{
  final String imagePath;
  CameraCaptureSuccess(this.imagePath);
}


class CameraCaptureFailure extends CameraState{
  final String error;
  CameraCaptureFailure(this.error);
}
