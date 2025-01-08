import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/camerapreview/presentation/pages/camera_preview.dart';
import 'package:laryngoscope/features/imagepicker/presentation/bloc/image_picker_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/pages/image_picker_page.dart';
import 'package:laryngoscope/features/imagepicker/presentation/pages/video_picker_page.dart';
import 'package:laryngoscope/features/videocall/presentation/pages/videocall_screen.dart';

class HomeScreen extends StatelessWidget {
  static route(_) => MaterialPageRoute(builder: (context) => HomeScreen());
  const HomeScreen({super.key});

  Future<void> _screenOrientation(BuildContext context) async {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ScreenOrientationChanged) {
          _screenOrientation(context);
        }
      },
      builder: (context, state) {
        bool showAppBar = true;
        if (state is AppBarToggleSuccess) {
          showAppBar = state.showAppBar;
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt,
                            color: AppPallette.iconBg,
                            size: 25,
                          )),
                      BlocListener<ImagePickerBloc, ImagePickerState>(
                        listener: (context, state) {
                          if (state is ImagePickedSuccess) {
                            // Navigate to ImagePickerPage when image is picked successfully
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ImagePickerPage(imagePath: state.imagePath),
                              ),
                            );
                          }
                           if (state is VideoPickedSuccess) {
                            // Navigate to ImagePickerPage when image is picked successfully
                           MaterialPageRoute(
                                builder: (_) =>
                                    VideoPickerPage(videoPath: state.videoPath),
                              );
                          }
                        },
                        child: IconButton(
                          onPressed: () {
                            context.read<ImagePickerBloc>().add(PickImageEvent());
                          },
                          icon: Icon(Icons.photo_size_select_actual_rounded,
                              color: AppPallette.iconBg, size: 25),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                              context.read<ImagePickerBloc>().add(PickVideoEvent());
                          },
                          icon: Icon(Icons.video_camera_back_sharp,
                              color: AppPallette.iconBg, size: 25)),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context, VideocallScreen.route(context));
                          },
                          icon: Icon(Icons.video_call,
                              color: AppPallette.iconBg, size: 25)),
                      IconButton(
                          onPressed: () {
                            context.read<HomeBloc>().add(OnScreenOrientation());
                          },
                          icon: Icon(Icons.screen_rotation_alt_outlined,
                              color: AppPallette.iconBg, size: 25)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert,
                              color: AppPallette.iconBg, size: 25)),
                    ],
                  ),
                )
              : null,
          body: GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(BodyClicked());
            },
            child: CameraPreviewPage(),
          ),
          floatingActionButton: showAppBar
              ? FloatingActionButton(
                  elevation: 0,
                  backgroundColor: AppPallette.buttonBg,
                  onPressed: () {},
                  child: Icon(
                    Icons.flip_camera_ios,
                    color: AppPallette.iconBg,
                  ),
                )
              : null,
        );
      },
    );
  }
}
