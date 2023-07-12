import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Utils/UpperCaseTextFormat.dart';
import '../LogIn/LogIn.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ListOfGender = ['Gender','Female', 'Male'];
  String _selectGender = 'Gender';



  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController primary_phone_number = TextEditingController();
  TextEditingController secondary_phone_number = TextEditingController();
  TextEditingController gender_controller = TextEditingController();
  TextEditingController full_name_controller = TextEditingController();
  TextEditingController confirm_controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  bool isLoading = false;



  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
    primary_phone_number.dispose();
    secondary_phone_number.dispose();
    gender_controller.dispose();
    full_name_controller.dispose();
    confirm_controller.dispose();
  }

  final BackgroundColor = Color(0xffEEEEEE);

  final ButtonColor = const Color(0xff0748A6);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final now = DateTime.now();
  // final createdAt = '${now.day}. ${now.month}. ${now.year}';
  // isLoading ? Center(child: SpinKitCircle(color: ButtonColor)) : Container(),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: BackgroundColor,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        height: 150,
                        width: double.infinity,
                        child: Center(
                          child: Image.asset("assets/logo.png"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 30,
                              ),
                              Container(
                                // height: 45,
                                child: TextFormField(
                                  inputFormatters: <TextInputFormatter>[
                                    UpperCaseTextFormat()
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your full name';
                                    }
                                    return null;
                                  },
                                  controller: full_name_controller,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.black38)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff0748A6),
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff0748A6))),
                                      label: Text(
                                        "Full name",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      hintText: "Enter your full name",
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          color: Colors.black38, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: ButtonColor,
                                  ),
                                  elevation: 0,
                                  dropdownColor: Colors.white,
                                  decoration: InputDecoration(
                                      // prefixIcon: Icon(Icons.transgender),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      contentPadding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 8,
                                          bottom: 8),
                                      labelStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            width: 0.3,
                                            color: Colors.black54,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            width: 0.3,
                                            color: ButtonColor,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            width: 0.3,
                                            color: Colors.black54,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            width: 0.3,
                                            color: Colors.black54,
                                          ))),
                                  value: _selectGender,
                                  items: ListOfGender.map((e) {
                                    return DropdownMenuItem(
                                        child: Text(
                                          e,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                        value: e);
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectGender = val as String;
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  // height: 45,
                                  child: TextFormField(
                                validator: (value) {
                                  if (!EmailValidator.validate(value!)) {
                                    return 'Please enter a valid email address';
                                  } else if (value.isEmpty) {
                                    return "PLease enter your email address";
                                  }
                                  return null;
                                },
                                controller: email_controller,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Color(0xff0748A6))),
                                    label: Text(
                                      "Email",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    hintText: "eg. abc@hmail.com",
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        color: Colors.black38, fontSize: 15),
                                    prefixIcon: Icon(
                                      Icons.email_rounded,
                                      color: Colors.black54,
                                    )),
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // height: 45,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter your phone number";
                                    } else if (value.length < 10) {
                                      return 'Enter phone number with 10 digits';
                                    }
                                    return null;
                                  },
                                  controller: primary_phone_number,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 5, bottom: 5, left: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.black38)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff0748A6),
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff0748A6))),
                                      label: Text(
                                        "Phone Number",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      hintText: "Enter phone number",
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          color: Colors.black38, fontSize: 15),
                                      prefixIcon: Icon(
                                        Icons.call,
                                        color: Colors.black54,
                                      )),
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // Container(
                              //   // height: 45,
                              //   child: TextFormField(
                              //     validator: (value) {
                              //       if (value!.length < 10) {
                              //         return 'Please enter ten digits of phone number';
                              //       } else if (value ==
                              //           primary_phone_number.text) {
                              //         return 'Phone number already exist';
                              //       }
                              //     },
                              //     controller: secondary_phone_number,
                              //     cursorColor: Colors.black,
                              //     keyboardType: TextInputType.number,
                              //     decoration: InputDecoration(
                              //         contentPadding: EdgeInsets.only(
                              //             top: 5, bottom: 5, left: 20),
                              //         enabledBorder: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             borderSide: BorderSide(
                              //                 width: 0.5,
                              //                 color: Colors.black38)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //               color: Color(0xff0748A6),
                              //               width: 0.5,
                              //             ),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         border: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             borderSide: BorderSide(
                              //                 color: Color(0xff0748A6))),
                              //         label: Text(
                              //           "phone 2",
                              //           style: TextStyle(
                              //               color: Colors.black, fontSize: 15),
                              //         ),
                              //         hintText: "Enter your phone number",
                              //         fillColor: Colors.white,
                              //         hintStyle: TextStyle(
                              //             color: Colors.black38, fontSize: 15),
                              //         prefixIcon: Icon(
                              //           Icons.call,
                              //           color: Colors.black54,
                              //         )),
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                // height: 45,
                                child: TextFormField(
                                  controller: password_controller,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 8) {
                                      return 'your password should have min of 8 char ';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  // controller: password,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.black38)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff0748A6),
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff0748A6))),
                                      label: Text(
                                        "Password",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      hintText: "Enter password",
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
                                height: 15,
                              ),
                              Container(
                                // height: 45,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length < 8) {
                                      return 'your password should have min of 8 char ';
                                    } else if (value !=
                                        password_controller.text) {
                                      return 'Enter correct email';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  controller: confirm_controller,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              width: 0.5,
                                              color: Colors.black38)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff0748A6),
                                            width: 0.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color(0xff0748A6))),
                                      label: Text(
                                        "Confirm password",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      hintText: "Confirm password",
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
                                height: 30,
                              ),
                           Container(
                                width: double.infinity,
                                // height: 45,
                                decoration: BoxDecoration(
                                    color: Color(0xff0748A6),
                                    borderRadius: BorderRadius.circular(10)),
                                child:  TextButton(
                                    onPressed: () async {

                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                            email: email_controller.text,
                                            password:
                                            password_controller.text)
                                            .then((value) async => {
                                          await FirebaseFirestore
                                              .instance
                                              .collection(
                                              "house_owner_db")
                                              .doc(_auth
                                              .currentUser?.uid)
                                              .set({
                                            "email":
                                            email_controller.text,
                                            "full_name":
                                            full_name_controller
                                                .text,
                                            "gender":
                                            gender_controller.text,
                                            "password":
                                            password_controller
                                                .text,
                                            "primary_phone_number":
                                            primary_phone_number
                                                .text,
                                            // "secondary_phone_number":
                                            // primary_phone_number
                                            //     .text,
                                            "gender": _selectGender,
                                            "createdAt":now,
                                          
                                          }).then((value) {
                                            setState(() {
                                              isLoading=true;
                                            });
                                            Navigator
                                                .of(context)
                                                .push(MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    LogIn()));
                                          }


                                          )
                                        })
                                            .catchError((onError) =>
                                        {"something went wrong"});
                                      }
                                      // if (_formKey.currentState!.validate()) {
                                      //
                                      //   FirebaseAuth.instance
                                      //       .createUserWithEmailAndPassword(
                                      //           email: email_controller.text,
                                      //           password:
                                      //               password_controller.text)
                                      //       .then((value) async => {
                                      //             await FirebaseFirestore
                                      //                 .instance
                                      //                 .collection(
                                      //                     "house_owner_db")
                                      //                 .doc(_auth
                                      //                     .currentUser?.uid)
                                      //                 .set({
                                      //               "email":
                                      //                   email_controller.text,
                                      //               "full_name":
                                      //                   full_name_controller
                                      //                       .text,
                                      //               "gender":
                                      //                   gender_controller.text,
                                      //               "password":
                                      //                   password_controller
                                      //                       .text,
                                      //               "primary_phone_number":
                                      //                   primary_phone_number
                                      //                       .text,
                                      //               "secondary_phone_number":
                                      //                   primary_phone_number
                                      //                       .text,
                                      //               "gender": _selectGender
                                      //             }).then((value) => Navigator
                                      //                         .of(context)
                                      //                     .push(MaterialPageRoute(
                                      //                         builder:
                                      //                             (context) =>
                                      //                                 LogIn())))
                                      //           })
                                      //       .catchError((onError) =>
                                      //           {"something went wrong"});
                                      // }
                                    },
                                    child: (Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ))),
                              ),
                              isLoading ? Container(
                                child: Center(child: SpinKitCircle(
                                  color: ButtonColor,
                                ),),
                              ):
                              SizedBox(
                                height: 20,
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
                                                  builder: (context) =>
                                                      LogIn()));
                                        },
                                        child: Text(
                                          "Sign In",
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
                  ))))
    );
  }
}
