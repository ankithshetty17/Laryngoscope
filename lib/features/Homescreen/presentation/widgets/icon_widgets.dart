import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/camerapreview/presentation/bloc/camera_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/bloc/image_picker_bloc.dart';
import 'package:laryngoscope/features/imagepicker/presentation/pages/image_picker_page.dart';
import 'package:laryngoscope/features/videopicker/presentation/bloc/video_picker_bloc.dart';
import 'package:laryngoscope/features/videopicker/presentation/pages/video_picker_page.dart';
import 'package:laryngoscope/features/videocall/presentation/pages/videocall_screen.dart';

import '../../../../core/app_pallette.dart';



Widget buildCameraIcon(BuildContext context) {
  return BlocListener<CameraBloc, CameraState>(
    listener: (context, state) {
      if (state is OpenCameraSuccess) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text('Image saved at ${state.imagePath}')),
                    // );
                  } else if (state is OpenCameraFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
    },
    child: IconButton(
      onPressed: () {
         context.read<CameraBloc>().add(OpenCameraEvent());
        //  context.read<CameraBloc>().add(CaptureImageEvent());
      },
      icon: Icon(Icons.camera_alt, color: AppPallette.iconBg, size: 25),
    ),
  );
}



Widget selectImageIcon(BuildContext context) {
  return BlocListener<ImagePickerBloc, ImagePickerState>(
    listener: (context, state) {
      if (state is ImagePickedSuccess) {
        // Navigate to ImagePickerPage when image is picked successfully
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImagePickerPage(imagePath: state.imagePath),
          ),
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
  );
}

Widget selectVideoIcon(BuildContext context) {
  return BlocListener<VideoPickerBloc, VideoPickerState>(
    listener: (context, state) {
      if (state is VideoPickedSuccess) {
        // Navigate to ImagePickerPage when image is picked successfully
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPickerPage(videoPath: state.videoPath),
          ),
        );
      }
    },
    child: IconButton(
        onPressed: () {
          context.read<VideoPickerBloc>().add(PickVideoEvent());
        },
        icon: Icon(Icons.video_camera_back_sharp,
            color: AppPallette.iconBg, size: 25)),
  );
}

Widget videoCallIcon(BuildContext context) {
  return IconButton(
      onPressed: () {
        Navigator.push(context, VideocallScreen.route(context));
      },
      icon: Icon(Icons.video_call, color: AppPallette.iconBg, size: 25));
}

Widget screenRotationIcon(BuildContext context) {
  return IconButton(
      onPressed: () {
        context.read<HomeBloc>().add(OnScreenOrientation());
      },
      icon: Icon(Icons.screen_rotation_alt_outlined,
          color: AppPallette.iconBg, size: 25));
}

 