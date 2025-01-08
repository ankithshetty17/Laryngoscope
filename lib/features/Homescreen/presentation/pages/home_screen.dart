import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/widgets/icon_widgets.dart';
import 'package:laryngoscope/features/camerapreview/presentation/pages/camera_preview.dart';

class HomeScreen extends StatelessWidget {
  static route(_) => MaterialPageRoute(builder: (context) => HomeScreen());
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ScreenOrientationChanged) {
          SystemChrome.setPreferredOrientations(
            MediaQuery.of(context).orientation == Orientation.portrait
                ? [DeviceOrientation.landscapeLeft]
                : [DeviceOrientation.portraitUp],
          );
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
                      buildCameraIcon(context),
                      selectImageIcon(context),
                      selectVideoIcon(context),
                      videoCallIcon(context),
                      screenRotationIcon(context),
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
