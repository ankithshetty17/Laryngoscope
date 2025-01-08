import 'package:flutter/material.dart';
import 'package:laryngoscope/core/app_pallette.dart';
import 'package:laryngoscope/features/Homescreen/presentation/pages/home_screen.dart';
import 'package:laryngoscope/features/videocall/presentation/pages/call.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/elevated_button.dart';
import 'package:laryngoscope/features/videocall/presentation/widgets/text_feild.dart';

class VideocallScreen extends StatelessWidget {
  final _controller = TextEditingController();
  static  route(_) => MaterialPageRoute(builder: (context)=> VideocallScreen());
   VideocallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, HomeScreen.route(context));
          }, 
          icon:Icon(Icons.arrow_back_ios,color: AppPallette.iconBg,size: 20,)),
      ),
      body:Center(
        child: SingleChildScrollView(
          child:
            Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                       Image.asset('assets/call.png'),
                        SizedBox(height: 10,),
                       Text('CONNECT TO THE WORLD.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: AppPallette.iconBg),),
                    SizedBox(height: 20,),
                           textFeild(hintText: 'Enter Call Id', controller:_controller ),
                           SizedBox(height: 20,),
                           GradientButton(buttonTxt: 'JoinCall', onpressed:(){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CallPage(callID: _controller.text,)));
                           })
                  ],
                ),
            ),
      ),
          );
  }
}