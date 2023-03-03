import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/House-Owner/SignUp.dart';

import '../Forgotpassword/phone_number_verification.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Color(0xffEEEEEE)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 20, right: 20, top: 80),
            child: Image.asset("assets/logo.png"),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 20),
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
                                  color: Colors.black54, fontSize: 15),
                            ),
                            hintText: "Enter your email",
                            fillColor: Colors.white,
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: Colors.black54,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: passwordController,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(top: 5, bottom: 5, left: 20),
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
                              "******",
                              style: TextStyle(color: Colors.black54),
                            ),
                            hintText: "Enter your password",
                            fillColor: Colors.white,
                            hintStyle:
                                TextStyle(color: Colors.black38, fontSize: 15),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black54,
                            )),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>phone_number_verification()));
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
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color(0xff0748A6),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: (){},
                            // onPressed: signIn,
                            child: (Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ))),
                      ),
                      Expanded(child: Container()),
                      Expanded(
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
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
                    ],
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    )));
  }
  //
  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim());
  // }
}
