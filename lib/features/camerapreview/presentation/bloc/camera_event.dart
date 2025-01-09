part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent {}


class OpenCameraEvent extends CameraEvent {}

// class CaptureImageEvent extends CameraEvent {}
