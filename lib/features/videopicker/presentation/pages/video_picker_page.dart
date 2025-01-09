import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/pages/home_screen.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/elevated_button.dart';
import 'package:laryngoscope/features/videopicker/presentation/bloc/video_picker_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPickerPage extends StatelessWidget {
  final String videoPath;

  const VideoPickerPage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    // Initialize the video player controller
    VideoPlayerController _controller =
        VideoPlayerController.file(File(videoPath));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, HomeScreen.route(context));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppPallette.iconBg,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Wrapping Zoom widget with a container to ensure a defined size
            Expanded(
              child: FutureBuilder(
                future: _controller.initialize(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _controller.play();
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GradientButton(
                buttonTxt: 'Delete Video',
                onpressed: () {
                  context.read<VideoPickerBloc>().add(DeleteVideoEvent());
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
