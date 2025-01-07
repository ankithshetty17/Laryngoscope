part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState{}

final class AppBarToggleSuccess extends HomeState{
  final bool showAppBar;
  AppBarToggleSuccess({required this.showAppBar}) ;
}

//screenorientation
final class ScreenOrientationChanged extends HomeState{}

//camrea toggle on succcess
final class CameraToggleSuccess extends HomeState{
  final CameraController cameraController;
  CameraToggleSuccess( this.cameraController);
}

//cameratoggle failure
final class CameraToggleFailure extends HomeState{
  final String error;
  CameraToggleFailure(this.error);
}