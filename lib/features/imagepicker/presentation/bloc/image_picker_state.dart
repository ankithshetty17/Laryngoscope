part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerState {}

final class ImagePickerInitial extends ImagePickerState {}

final class VideoPickerInitial extends ImagePickerState{}


class ImagePickedSuccess extends ImagePickerState{
  final String imagePath;
   
  ImagePickedSuccess(this.imagePath);
}

class VideoPickedSuccess extends ImagePickerState{
   final String videoPath;
  VideoPickedSuccess(this.videoPath);
}


class ImageDeleteSuccess extends ImagePickerState{}


class VideoDeleteSuccess extends ImagePickerState{}

class ImageFailure extends ImagePickerState{
  final String error;

  ImageFailure(this.error);
}

class VideoFailure extends ImagePickerState{
  final String error;

  VideoFailure(this.error);
}