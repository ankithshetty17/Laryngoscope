import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'camerapreview_event.dart';
part 'camerapreview_state.dart';

class CamerapreviewBloc extends Bloc<CamerapreviewEvent, CamerapreviewState> {
  CamerapreviewBloc() : super(CamerapreviewInitial()) {
    on<CamerapreviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
