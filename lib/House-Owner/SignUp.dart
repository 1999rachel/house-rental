import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
final fullnameController = TextEditingController();
final phonenumberController = TextEditingController();


// initializing firebase database
  final referenceDatabase = FirebaseDatabase.instance;
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.refFromURL("https://console.firebase.google.com/u/0/project/house-rental-87db0/database/house-rental-87db0-default-rtdb/data/~2F");

    return Scaffold(

      body:SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Color(0xffEEEEEE)),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(left: 20, right: 20, top: 40),
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
                        child: Form(
                          key:  _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),

                              TextFormField(
                                controller: fullnameController,
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
                                      "Full names",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15),
                                    ),
                                    hintText: "Enter your full name",
                                    fillColor: Colors.white,
                                    hintStyle:
                                    TextStyle(color: Colors.black38, fontSize: 15),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.black54,
                                    )),
                              ),
                              SizedBox(
                                height: 15,
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
                                controller: phonenumberController,
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.number,
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
                                      "phone number",
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 15),
                                    ),
                                    hintText: "Enter your phone number",
                                    fillColor: Colors.white,
                                    hintStyle:
                                    TextStyle(color: Colors.black38, fontSize: 15),
                                    prefixIcon: Icon(
                                      Icons.call,
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
                                      "Password",
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
                                      "Confirm password",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    hintText: "Confirm password",
                                    fillColor: Colors.white,
                                    hintStyle:
                                    TextStyle(color: Colors.black38, fontSize: 15),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black54,
                                    )),
                              ),
                              SizedBox(height: 20),

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
                                    onPressed: (){

                                      ref.child("users").push().child("fullname").set(fullnameController.text).asStream();

                                    },
                                    child: (Text(
                                      "Sign Up",
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
                                          Navigator.of(context).pop();
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
                              SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
