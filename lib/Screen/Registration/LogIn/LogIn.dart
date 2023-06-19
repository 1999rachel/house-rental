import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/dashboard.dart';
import 'package:house_rental/Utils/PreferenceUtil.dart';

import '../../services/auth_services.dart';
import '../Forgotpassword/phone_number_verification.dart';
import '../SignUp/SignUp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {



  bool isLoading = false;

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  void initState() {

      FirebaseAuth.instance
          .authStateChanges()
          .listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          LogIn();
        }
      });


    super.initState();
  }
  showSnackBar(String text, Duration d) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  // Future<void> SignInUser(String email, String password) async {
  //   try{
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {
  //
  //       Navigator.of(context).push(
  //
  //           MaterialPageRoute(
  //               builder: (context) =>
  //               const dashboard()));
  //
  //     });
  //
  //   } catch (user_credentials) {
  //     if (user_credentials is FirebaseException){
  //       if (user_credentials.code== 'invalid-email' ||
  //           user_credentials.code == 'user-not-found' ||
  //           user_credentials.code == 'wrong-password'{
  //       showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //       return AlertDialog(
  //       title: Text('Error'),
  //       content: Text('Invalid email or password.'),
  //       actions: <Widget>[
  //       TextButton(
  //       child: Text('OK'),
  //       onPressed: () {
  //       Navigator.of(context).pop();
  //       },
  //       ),
  //       ],
  //       );
  //       },
  //       );
  //       }
  //       else {
  //       // Show a generic error AlertDialog
  //       showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //       return AlertDialog(
  //       title: Text('Error'),
  //       content: Text('An error occurred.'),
  //       actions: <Widget>[
  //       TextButton(
  //       child: Text('OK'),
  //       onPressed: () {
  //       Navigator.of(context).pop();
  //       },
  //       ),
  //       ],
  //       );
  //       },
  //       );
  //
  //       }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: BackgroundColor),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 40,
                  bottom: 40,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        child: TextFormField(
                          controller: emailcontroller,
                          cursorColor: Colors.black,
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
                              contentPadding: EdgeInsets.only(left: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.5, color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff0748A6),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0xff0748A6))),
                              label: Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              hintText: "eg.abc@gmail.com",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Colors.black54,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value!.length < 8) {
                              return 'Enter Password with not less than 8 chars long';
                            }return null;
                          },
                          obscureText: true,
                          controller: passwordcontroller,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(left: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 0.5, color: Colors.black38)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xff0748A6),
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Color(0xff0748A6))),
                              label: Text(
                                "Password",
                                style: TextStyle(color: Colors.black),
                              ),
                              hintText: "******",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black54,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        height: 45,
                        child: TextButton(
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    phone_number_verification()));
                          },
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color(0xffC30000),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff0748A6),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {

                                setState(() {
                                  isLoading = true;

                                });


                                try{
                                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordcontroller.text).then((value) {

                                    Navigator.of(context).push(

                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const dashboard()));

                                  });

                                }
                                catch ( user_credential){
                                  if (user_credential is FirebaseException && (user_credential.code == 'invalid- email'||
                                        user_credential.code == 'user-not-found'||
                                    user_credential.code== ' wrong-password')) {
                                    showDialog(context: context, builder: (context){
                                      return Center(
                                        child: Container(
                                          height: 150,
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Text("ajsdcadchkhad")
                                            ],
                                          ),
                                        ),
                                      );

                                    });

                                  }
                                  // else{
                                  //   setState(() {
                                  //
                                  //      isLoading = false;
                                  //
                                  //   });
                                  //   showDialog(context: context, builder: (context){
                                  //     return
                                  //      Center
                                  //        (
                                  //        child: Dialog(
                                  //           child: Container(
                                  //             padding: EdgeInsets.only(top: 25),
                                  //             height:150,
                                  //
                                  //               width:double.infinity,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.all(Radius.circular(20)),
                                  //               color: Colors.white,
                                  //
                                  //             ),
                                  //             child: Column(
                                  //               crossAxisAlignment: CrossAxisAlignment.center,
                                  //               children: [
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 ),
                                  //
                                  //                 Container(
                                  //                   child: Center(
                                  //                     child: Text("Invalid Email or Password!",),
                                  //                   ),
                                  //                 ),
                                  //                 SizedBox(
                                  //                   height: 20,
                                  //                 ),
                                  //                 Container(
                                  //                     height:45,
                                  //                     width: 100,
                                  //                     decoration: BoxDecoration(
                                  //                         color: ButtonColor,
                                  //                         borderRadius: BorderRadius.all(Radius.circular(10))
                                  //
                                  //                     ),
                                  //                     child: Center(child: TextButton(
                                  //                       onPressed: (){
                                  //                         setState(() {
                                  //                           isLoading = false;
                                  //                         });
                                  //                         Navigator.of(context).pop();
                                  //                       },
                                  //                       child: Text('OK',style: TextStyle(
                                  //                         color: Colors.white,
                                  //                       ),),
                                  //                     ))),
                                  //                 SizedBox(
                                  //                   height: 10,
                                  //                 )
                                  //               ],
                                  //             ),
                                  //           )
                                  //
                                  //
                                  //
                                  //
                                  //     ),
                                  //      );
                                  //
                                  //   });
                                  //
                                  //
                                  //
                                  // }

                            }
    // catch (user_credentials) {
    // if (user_credentials is FirebaseException){
    // if (user_credentials.code== 'invalid-email' ||
    // user_credentials.code == 'user-not-found' ||
    // user_credentials.code == 'wrong-password'{
    // showDialog(
    // context: context,
    // builder: (BuildContext context) {
    // return AlertDialog(
    // title: Text('Error'),
    // content: Text('Invalid email or password.'),
    // actions: <Widget>[
    // TextButton(
    // child: Text('OK'),
    // onPressed: () {
    // Navigator.of(context).pop();
    // },
    // ),
    // ],
    // );
    // },
    //
                                // try{
                                //   FirebaseAuth.instance
                                //       .signInWithEmailAndPassword(
                                //       email: emailcontroller.text,
                                //       password: passwordcontroller.text
                                //
                                //   )
                                //       .then((value) => Navigator.of(context).push(
                                //
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //           const dashboard())));
                                //
                                //
                                // }
                                //    on FirebaseAuthException  catch(e){
                                //      setState(() {
                                //        isLoading = false;
                                //        emailcontroller.clear();
                                //        passwordcontroller.clear();
                                //      });
                                //      if (e.code == 'user-not-found') {
                                //        showDialog(context: context, builder: (context){
                                //          return AlertDialog(
                                //            title: Center(
                                //              child:Text("Invalid Email")
                                //            ),
                                //
                                //          );
                                //        });
                                //        // print('No user found for that email.');
                                //      } else if (e.code == 'wrong-password') {
                                //        // print('Wrong password provided for that user.');/
                                //        showDialog(context: context, builder: (context){
                                //          return AlertDialog(
                                //            title: Center(child: Text("Invalid Password")),
                                //
                                //          );
                                //        });
                                //      }
                                //
                                //
                                //     }
                                                 }

                            },
                            child: (Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ))),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style:
                              TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Color(0xffC30000),
                                      fontWeight: FontWeight.bold),
                                )),

                          ],
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      ),
                      isLoading ? Center(child: SpinKitCircle(color: ButtonColor)) : Container(),
                      SizedBox(
                        height: 150,
                      ),

                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ))
            ],
          )),
    )));
  }



  // Future SignIn() async {
  //
  //   showDialog(context: context,
  //       barrierDismissible: false,
  //       builder: (context){
  //     return Center (child:CircularProgressIndicator(
  //       color: ButtonColor,
  //     ) );
  //
  //   });
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailcontroller.text.trim(),
  //         password: passwordcontroller.text.trim());
  //     print("signed in");
  //   } on FirebaseException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       const Text('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       Text('Wrong password provided for that user.');
  //     }return CircularProgressIndicator(
  //       color: ButtonColor,
  //     );
  //   }
  //
  //   // / navigatorKey.currentState!.popUntil((route) => route.isFirst);
  // }
}
