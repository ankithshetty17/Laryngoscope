part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

 class HomeInitial extends HomeState {}

 class HomeLoading extends HomeState{}

 class AppBarToggleSuccess extends HomeState{
  final bool showAppBar;
  AppBarToggleSuccess({required this.showAppBar}) ;
}

//screenorientation
 class ScreenOrientationChanged extends HomeState{}

//camrea toggle on succcess
 class CameraToggleSuccess extends HomeState{
  final CameraController cameraController;
  CameraToggleSuccess( this.cameraController);
}

//cameratoggle failure
 class CameraToggleFailure extends HomeState{
  final String error;
  CameraToggleFailure(this.error);
}