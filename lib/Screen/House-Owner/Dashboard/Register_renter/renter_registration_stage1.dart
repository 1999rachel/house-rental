import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/Register_renter/renter_registration_stage2.dart';
import 'package:house_rental/Utils/PreferenceUtil.dart';
import '../../../../Utils/UpperCaseTextFormat.dart';
import '../dashboard.dart';
import 'package:image_picker/image_picker.dart';

class renter_registration_stage1 extends StatefulWidget {
  const renter_registration_stage1({Key? key}) : super(key: key);

  @override
  State<renter_registration_stage1> createState() =>
      _renter_registration_stage1State();
}

class _renter_registration_stage1State
    extends State<renter_registration_stage1> {
  _register_houseState() {
    _selectGender = ListOfGender[0];
  }

  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);

  final ListOfGender = ['Gender', 'Female', 'Male'];
  String _selectGender = 'Gender';
  late bool success;

  final _formKey = GlobalKey<FormState>();
  TextEditingController full_name_controller = TextEditingController();
  TextEditingController gender_controller = TextEditingController();
  TextEditingController nida_no_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController primary_number_controller = TextEditingController();
  TextEditingController secondary_number_controller = TextEditingController();
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  File? _image;
  final imagePicker = ImagePicker();
  late String downloadUrl;

  Future ImagePickerMethod() async {
    // picke image form gallary
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        // Create a snack bar that show the error text
        showSnackBar("No image selected", Duration(milliseconds: 600));
      }
    });
  }

  // Creating a future that upload the image to firestorage
  // download the image and save in firestore
  Future uploadImage() async {
    // final postId = DateTime.now().microsecondsSinceEpoch.toString();
    // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // Reference ref = FirebaseStorage.instance
    //     .ref()
    //     .child("/renter_images")
    //     .child("post_$postId");
    // await ref.putFile(_image!);
    // downloadUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection("renters_db")
        .doc(email_controller.text)
        .set({
      "full_name": full_name_controller.text,
      "renterId": email_controller.text,
      "gender": _selectGender,
      "nida_no": nida_no_controller.text,
      "email": email_controller.text,
      "primary_phone_number": primary_number_controller.text,
      // "secondary_phone_number": secondary_number_controller.text,
      "house_owner_id": _auth.currentUser?.uid,
      // 'downloadedUrl': downloadUrl
    }).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => renter_registration_stage2(
                email: email_controller.text,
              )));

      // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_controller.text, password: primary_number_controller.text);
    });
  }

  showSnackBar(String text, Duration d) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    full_name_controller.dispose();
    gender_controller.dispose();
    nida_no_controller.dispose();
    email_controller.dispose();
    primary_number_controller.dispose();
    secondary_number_controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ButtonColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => dashboard()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            )),
        title: Text(
          "Register renter",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: BackgroundColor,
          width: double.infinity,
          height: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      UpperCaseTextFormat()
                    ],
                    controller: full_name_controller,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter renter full names";
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
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
                      hintText: "Enter renter full name",
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: ButtonColor,
                      ),
                      elevation: 0,
                      dropdownColor: Colors.white,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: TextStyle(color: Colors.black54),
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 20, top: 8, bottom: 8),
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 0.3,
                                color: Colors.black54,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 0.3,
                                color: ButtonColor,
                              )),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 0.3,
                                color: Colors.black54,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                    height: 20,
                  ),
                  TextFormField(
                    controller: nida_no_controller,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,

                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 8),
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
                      hintText: "Enter renter NIDA number",
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                      // prefixIcon: Icon(
                      //   Icons.number,
                      //   color: Colors.black54,
                      // )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 8),
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
                      hintText: "Enter renter address",
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: primary_number_controller,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter phone number";
                      } else if (value!.length < 10) {
                        return "Enter phone number with ten digits";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,

                      contentPadding: EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 8),
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
                      hintText: "Enter renter first phone number",
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                      // prefixIcon: Icon(
                      //   Icons.number,
                      //   color: Colors.black54,
                      // )
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Please enter phone number";
                  //     } else if (value!.length < 10) {
                  //       return "Enter phone number with ten digits";
                  //     } else if (value == primary_number_controller.text) {
                  //       return 'Phone number already exist';
                  //     }
                  //   },
                  //   controller: secondary_number_controller,
                  //   cursorColor: Colors.black,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     contentPadding: EdgeInsets.only(
                  //         left: 20, right: 20, top: 8, bottom: 8),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide:
                  //             BorderSide(width: 0.5, color: Colors.black38)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //           color: Color(0xff0748A6),
                  //           width: 0.5,
                  //         ),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //         borderSide: BorderSide(color: Color(0xff0748A6))),
                  //     hintText: "Enter renter second phone number",
                  //     fillColor: Colors.white,
                  //     hintStyle: TextStyle(color: Colors.black54, fontSize: 15),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   height: 100,
                  //   child: Stack(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Align(
                  //             alignment: Alignment.topLeft,
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(10),
                  //               child: Container(
                  //                   width: 93,
                  //                   height: 100,
                  //                   decoration: BoxDecoration(
                  //                       border: Border.all(
                  //                           width: 1, color: Colors.grey),
                  //                       color: Color(0xffD9D9D9),
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10))),
                  //                   child: _image == null
                  //                       ? Icon(
                  //                           Icons.person,
                  //                           size: 50,
                  //                           color: Colors.black54,
                  //                         )
                  //                       : Image.file(
                  //                           _image!,
                  //                           width: 93,
                  //                           height: 100,
                  //                           fit: BoxFit.cover,
                  //                         )),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Expanded(
                  //             child: Column(
                  //               children: [
                  //                 SizedBox(
                  //                   height: 55,
                  //                 ),
                  //                 Container(
                  //                   width: double.infinity,
                  //                   height: 45,
                  //                   decoration: BoxDecoration(
                  //                       color: Color(0xffD9D9D9),
                  //                       borderRadius:
                  //                           BorderRadius.circular(10)),
                  //                   child: TextButton(
                  //                       onPressed: () {
                  //                         ImagePickerMethod();
                  //                       },
                  //                       child: (Text(
                  //                         "Upload renter image",
                  //                         style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontWeight: FontWeight.normal),
                  //                       ))),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff0748A6),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            uploadImage();
                           //
                           // await FirebaseFirestore
                           //      .instance
                           //      .collection("renters_db")
                           //      .doc(email_controller.text)
                           //      .set({
                           //    "full_name": full_name_controller.text.isEmpty,
                           //    "renterId": email_controller.text.isEmpty,
                           //    "gender": _selectGender,
                           //    "nida_no": nida_no_controller.text,
                           //    "email": email_controller.text,
                           //    "primary_phone_number":
                           //    primary_number_controller.text,
                           //    // "secondary_phone_number": secondary_number_controller.text,
                           //    "house_owner_id": _auth.currentUser?.uid,
                           //    // 'downloadedUrl': downloadUrl
                           //  }).then((value) {
                           //    Navigator.of(context).push(
                           //        MaterialPageRoute(
                           //            builder: (context) =>
                           //                renter_registration_stage2(
                           //                  email:
                           //                  email_controller.text,
                           //                )));
                           //
                           //    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_controller.text, password: primary_number_controller.text);
                           //  }).catchError((error) {
                           //    // Handle the error
                           //    showDialog(
                           //        context: context,
                           //        builder: (context) {
                           //          return Center(
                           //            child: Container(
                           //              height: 100,
                           //              width: double.infinity,
                           //              child: Center(
                           //                child: Text(Text(
                           //                    'Something went wrong: $error')
                           //                as String),
                           //              ),
                           //            ),
                           //          );
                           //        });
                           //  });
                            // FirebaseAuth.instance
                            //     .createUserWithEmailAndPassword(
                            //         email: email_controller.text,
                            //         password: primary_number_controller.text)
                            //     .then((value) async => await FirebaseFirestore
                            //             .instance
                            //             .collection("renters_db")
                            //             .doc(email_controller.text)
                            //             .set({
                            //           "full_name": full_name_controller.text,
                            //           "renterId": email_controller.text,
                            //           "gender": _selectGender,
                            //           "nida_no": nida_no_controller.text,
                            //           "email": email_controller.text,
                            //           "primary_phone_number":
                            //               primary_number_controller.text,
                            //           // "secondary_phone_number": secondary_number_controller.text,
                            //           "house_owner_id": _auth.currentUser?.uid,
                            //           // 'downloadedUrl': downloadUrl
                            //         }).then((value) {
                            //           Navigator.of(context).push(
                            //               MaterialPageRoute(
                            //                   builder: (context) =>
                            //                       renter_registration_stage2(
                            //                         email:
                            //                             email_controller.text,
                            //                       )));
                            //
                            //           // FirebaseAuth.instance.createUserWithEmailAndPassword(email: email_controller.text, password: primary_number_controller.text);
                            //         }).catchError((error) {
                            //           // Handle the error
                            //           showDialog(
                            //               context: context,
                            //               builder: (context) {
                            //                 return Center(
                            //                   child: Container(
                            //                     height: 100,
                            //                     width: double.infinity,
                            //                     child: Center(
                            //                       child: Text(Text(
                            //                               'Something went wrong: $error')
                            //                           as String),
                            //                     ),
                            //                   ),
                            //                 );
                            //               });
                            //         })
                            // );

                            // uploadImage();
                            // setState(() async{
                            //  await  FirebaseAuth.instance
                            //       .createUserWithEmailAndPassword(
                            //           email: email_controller.text,
                            //           password: primary_number_controller.text)
                            //       .then((value) async => Navigator.of(context)
                            //           .push(MaterialPageRoute(
                            //               builder: (context) =>
                            //                   renter_registration_stage2(
                            //                     email: 'email',
                            //                   ))));
                            // });
                          }
                          // if (_formKey.currentState!.validate()) {
                          //   PreferenceUtil prefs = PreferenceUtil();
                          //   prefs
                          //       .getItem("email", "string")
                          //       .then((house_OwnerId) async {
                          //     uploadImage();
                          //     // if (_image == null) {
                          //     //   setState(() {
                          //     //     showDialog(
                          //     //         context: (context),
                          //     //         builder: (context) {
                          //     //           return Dialog(
                          //     //             child: Center(
                          //     //               child: Container(
                          //     //                 height: 100,
                          //     //                 width: double.infinity,
                          //     //                 decoration: BoxDecoration(
                          //     //                     color: Colors.white,
                          //     //                     borderRadius:
                          //     //                         BorderRadius.all(
                          //     //                       Radius.circular(15),
                          //     //                     )),
                          //     //                 padding: EdgeInsets.only(
                          //     //                     left: 20, right: 20),
                          //     //                 child: Text(
                          //     //                   "Please upload the image",
                          //     //                   textAlign: TextAlign.center,
                          //     //                   style: TextStyle(
                          //     //                     color: Colors.black,
                          //     //                   ),
                          //     //                 ),
                          //     //               ),
                          //     //             ),
                          //     //           );
                          //     //         });
                          //     //   });
                          //     // } else {
                          //     //   final ref = FirebaseStorage.instance
                          //     //       .ref('renterImages')
                          //     //       .child('full_name' + '.jpg');
                          //     //   await ref.putFile(_image!);
                          //     //   url = await ref.getDownloadURL();
                          //     // }
                          //
                          //     await FirebaseFirestore.instance
                          //         .collection("renter")
                          //         .doc(email_controller.text)
                          //         .set({
                          //       "full_name": full_name_controller.text,
                          //       "gender": _selectGender,
                          //       "nida_no": nida_no_controller.text,
                          //       "email": email_controller.text,
                          //       "primary_phone_number":
                          //           primary_number_controller.text,
                          //       "secondary_phone_number":
                          //           secondary_number_controller.text,
                          //       "house_id": "",
                          //       "house_owner_id": house_OwnerId,
                          //     }).then((value) => Navigator.of(context).push(
                          //             MaterialPageRoute(
                          //                 builder: (context) =>
                          //                     renter_registration_stage2(
                          //                         email:
                          //                             email_controller.text))).whenComplete(() =>
                          //         showSnackBar(
                          //             "Information Uploaded Successfully",
                          //             Duration(milliseconds: 600))));
                          //   });
                          //
                          //   //          setState(() async {
                          //   // if(_image==null){
                          //   //   Text("Please upload the image");
                          //   // }else {
                          //   //   final ref = FirebaseStorage.instance.ref('renterImages').child('full_name'+'.jpg');
                          //   //   await ref.putFile(_image!);
                          //   //   url =  await ref.getDownloadURL();
                          //   //
                          //   //
                          //   //          }});
                          //   //
                          //   //          await FirebaseFirestore.instance.collection("renters").doc(email_controller.text).set(
                          //   //              {
                          //   //                "full_name": full_name_controller.text,
                          //   //                "gender": _selectGender,
                          //   //                "nida_no": nida_no_controller.text,
                          //   //                "email": email_controller.text,
                          //   //                "primary_phone_number": primary_number_controller.text,
                          //   //                "secondary_phone_number": secondary_number_controller.text,
                          //   //                "house_id": "",
                          //   //                "house_owner_id": 'email',
                          //   //                "profile1": url,
                          //   //
                          //   //
                          //   //
                          //   //              }).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>renter_registration_stage2(email: email_controller.text))));
                          //   //
                          // }
                        },
                        child: (Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ))),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
