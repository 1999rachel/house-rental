import 'package:flutter/material.dart';

class phone_number_verification extends StatefulWidget {
  const phone_number_verification({Key? key}) : super(key: key);

  @override
  State<phone_number_verification> createState() =>
      _phone_number_verificationState();
}

class _phone_number_verificationState extends State<phone_number_verification> {
  @override
  Widget build(BuildContext context) {
  return
        Scaffold(

          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Color(0xffD9D9D9),
            leading: Icon(Icons.arrow_back_ios,color: Colors.black,),

            title: Text("Phone verification", style: TextStyle(color: Colors.black,fontSize: 18),),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffEEEEEE)
            ),
            child: Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Align(git
                           alignment: Alignment.topLeft,
                            child: Text("Please enter your phone number for", style: TextStyle(color: Colors.black,fontSize: 16),)),

                     Align(alignment: Alignment.topLeft,
                     child: Text("Verification",style: TextStyle(color: Colors.black,fontSize: 16),),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

        );
  }
}
