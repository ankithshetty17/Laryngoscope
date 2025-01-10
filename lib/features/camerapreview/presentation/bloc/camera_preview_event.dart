part of 'camera_preview_bloc.dart';

@immutable
sealed class CameraPreviewEvent {}


class InitializeCameraPreview extends CameraPreviewEvent{}

class DisposeCameraPreview extends CameraPreviewEvent{}


class SwitchCamera extends CameraPreviewEvent{}