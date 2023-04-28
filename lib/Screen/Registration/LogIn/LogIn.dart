import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool _isLoading = false;

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final _formKey = GlobalKey<FormState>();
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
    // TODO: implement initState
    PreferenceUtil pref = PreferenceUtil();
    pref.getItem("email", 'string').then((user_email) => {
      if (user_email != null) {
        Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const dashboard()))
      }
    });
    super.initState();
  }

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

                            if(value!.isEmpty){

                              return 'Please enter your password';
                            }else if (value!.length<8){

                              return 'Enter Password with not less than 8 chars long';
                            }

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
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  phone_number_verification()));
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,

                        decoration: BoxDecoration(
                            color: Color(0xff0748A6),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                DocumentSnapshot<Map<String, dynamic>> user =
                                    await FirebaseFirestore.instance
                                        .collection("house_owners")
                                        .doc(emailcontroller.text)
                                        .get();
                                if (user.exists) {
                                  if (passwordcontroller.text ==
                                      user.get("password")) {
                                    PreferenceUtil prefs = PreferenceUtil();
                                    prefs.setItem("email", emailcontroller.text, "string");
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => const dashboard()));
                                  }
                                }
                              }
                            },
                            child: (Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ))),
                      ),
                      SizedBox(
                        height: 150,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Color(0xffC30000),
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
