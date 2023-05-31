import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/Registration/Forgotpassword/verification_code.dart';
//
class phone_number_verification extends StatefulWidget {
  const phone_number_verification({Key? key}) : super(key: key);

  @override
  State<phone_number_verification> createState() =>
      _phone_number_verificationState();
}

class _phone_number_verificationState extends State<phone_number_verification> {
  final ButtonColor = const Color(0xff0748A6);
  TextEditingController email_controller = TextEditingController();
  void dispose(){
    email_controller.dispose();
    super.dispose();
  }
Future resertpassword() async {
  await FirebaseAuth.instance.sendPasswordResetEmail(email: email_controller.text).then((value) {

    showDialog(context: context, builder: (context){
      return Dialog(
        child: Container(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(

                  margin: EdgeInsets.only(left: 10,right:10,top: 15),
                  child: Text("Resert link is sent to your email account.",
                    textAlign: TextAlign.center,
                    softWrap: true,style: TextStyle(
                        color: Colors.black,
                      fontSize: 16
                    ),),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                    color: ButtonColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("OK",style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              )
            ],
          ),

          decoration: BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)
          )),
        ),
      );

    }).then((value) =>
    Navigator.of(context).pop()
    );

  });
    // try{
    //
    //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email_controller.text).then((value) {
    //
    //     // setState(() {
    //     //   showDialog(
    //     //       context: context,
    //     //       builder: (context){
    //     //         return AlertDialog(
    //     //           // content: Text(error.toString()),
    //     //           content: Text("Password resert link sent to your email",textAlign: TextAlign.center,),
    //     //         );
    //     //       });
    //     //
    //     // });
    //     Navigator.of(context).pop();
    //
    //
    //   });
    //
    //
    //
    // } on FirebaseException catch (error){
    //   showDialog(context: context, builder: (context){
    //     return Container();
    //     // return AlertDialog(
    //     //   // content: Text(error.toString()),
    //     //   content: Text("Email entered not valid",textAlign: TextAlign.center,),
    //     // );
    //   });
    //
    // }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        // backgroundColor: Color(0xffD9D9D9),
        backgroundColor: ButtonColor,

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          "Phone verification",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Color(0xffEEEEEE)),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       "Please enter your Email to send you a link to resert your password",
                    //       textAlign: TextAlign.center,
                    //       softWrap: true,
                    //
                    //       style: TextStyle(color: Colors.black,fontSize: 17 ),
                    //     )),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     "Verification",
                    //     style: TextStyle(color: Colors.black, fontSize: 16),
                    //   ),
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                // controller: phonenumberController,
                // cursorColor: Colors.black,
                controller: email_controller,

                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (!EmailValidator.validate(value!)) {
                    return 'Please enter a valid email address';
                  } else if (value.isEmpty) {
                    return "PLease enter your email address";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 0.5, color: Colors.black38)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff0748A6),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xff0748A6))),
                    label: Text(
                      "Email",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    hintText: "Enter your email",
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black54,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff0748A6),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                    onPressed: () {
                      resertpassword();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => verification_code()));
                    },
                    child: Text(
                      "Resert Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void verifyRecaptcha() async {
  //   recaptchaKey.currentState!.show();
  //   final result = await showDialog<bool>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('reCAPTCHA Verification'),
  //       content: Recaptcha(
  //         apiKey: 'YOUR_RECAPTCHA_SITE_KEY',
  //         controller: recaptchaKey,
  //         onVerified: (token) {
  //           recaptchaToken = token;
  //           Navigator.of(context).pop(true);
  //         },
  //       ),
  //     ),
  //   );
  //
  //   if (result == true) {
  //     // reCAPTCHA verified, continue with password reset request
  //     resetPassword();
  //   } else {
  //     // reCAPTCHA verification failed, handle error
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text('reCAPTCHA Verification Failed'),
  //         content: Text('Please try again.'),flutter
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

}
