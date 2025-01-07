import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/bloc/home_bloc.dart';
import 'package:laryngoscope/features/Homescreen/presentation/widgets/camera_preview.dart';


class HomeScreen extends StatelessWidget {
 
  const HomeScreen({super.key});

   Future<void> _screenOrientation(BuildContext context) async {
      if(MediaQuery.of(context).orientation == Orientation.portrait) 
                        { 
                            SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]); 
                        }else { 
                            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); 
                        } 
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
     listener: (context,state){
          if(state is ScreenOrientationChanged){
          _screenOrientation(context);
        }
     },

      builder: (context, state) {
        bool showAppBar = true;
          if(state is AppBarToggleSuccess){
          showAppBar = state.showAppBar;
        }
       
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: showAppBar
              ? AppBar(
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
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.photo_size_select_actual_rounded,
                              color: AppPallette.iconBg, size: 25)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.video_camera_back_sharp,
                              color: AppPallette.iconBg, size: 25)),
                      IconButton(
                          onPressed: () {},
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
                              color: AppPallette.iconBg, size: 25))
                    ],
                  ),
                )
              : null,
          body: GestureDetector(
            onTap: () {
              context.read<HomeBloc>().add(BodyClicked());
            },
            child: CameraPreviewWidget(),
          ),
          // floatingActionButton: showAppBar?  FloatingActionButton(onPressed: (){
          // },
          // backgroundColor: AppPallette.buttonBg ,
          // elevation: 0,
          // child: Icon(Icons.cameraswitch,color: AppPallette.iconBg,),):null,
        );
      },
    );
  }
}
