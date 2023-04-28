import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';

class resit_view extends StatefulWidget {
  const resit_view({Key? key}) : super(key: key);

  @override
  State<resit_view> createState() => _resit_viewState();
}

class _resit_viewState extends State<resit_view> {

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
body: Container(
  width: double.infinity,
  height: double.infinity,
  color:BackgroundColor,
  child:FullScreenWidget(

    child:Image.asset("assets/profile1.jpeg",fit: BoxFit.cover,)
  ),
),



    ));
  }
}
