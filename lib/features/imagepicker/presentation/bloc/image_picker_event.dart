part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}

class PickImageEvent extends ImagePickerEvent {}

class PickVideoEvent extends ImagePickerEvent {}

class DeleteImageEvent extends ImagePickerEvent {}

class DeleteVideoEvent extends ImagePickerEvent {}
