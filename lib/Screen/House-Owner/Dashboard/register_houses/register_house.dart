import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/register_houses/registered_houses.dart';
import 'package:house_rental/Utils/PreferenceUtil.dart';

class register_house extends StatefulWidget {
  const register_house({Key? key}) : super(key: key);
  @override
  State<register_house> createState() => _register_houseState();
}

class _register_houseState extends State<register_house> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  TextEditingController house_no_controller = TextEditingController();
  TextEditingController kitchen_no_controller = TextEditingController();
  TextEditingController dining_no_controller = TextEditingController();
  TextEditingController seating_room_no_controller = TextEditingController();
  TextEditingController rooms_no_controller = TextEditingController();
  TextEditingController master_bedroom_no_controller = TextEditingController();
  TextEditingController rent_controller = TextEditingController();

  String house_owner_email = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    PreferenceUtil pref = PreferenceUtil();
    pref.getItem('email', 'string').then((email) {
      setState(() {
        house_owner_email = email;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    house_no_controller.dispose();
    kitchen_no_controller.dispose();
    dining_no_controller.dispose();
    seating_room_no_controller.dispose();
    rooms_no_controller.dispose();
    master_bedroom_no_controller.dispose();
    rent_controller.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ButtonColor,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            )),
        title: Text(
          "Register House",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: BackgroundColor,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "House name:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter house number";
                              }
                            },
                            controller: house_no_controller,
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
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kitchen :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter number of kitchen available";
                              }
                            },
                            controller: kitchen_no_controller,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
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
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dining :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please number of dining available";
                              }
                            },
                            controller: dining_no_controller,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
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
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Seating room :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              // color: ButtonColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please number of rest rooms available";
                              }
                            },
                            controller: seating_room_no_controller,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
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
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Rooms available:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter number of rooms available";
                              }
                            },
                            controller: rooms_no_controller,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
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
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Master Bedroom :",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextFormField(
                            cursorColor: Colors.black87,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please number of master bedrooms available";
                              }
                            },
                            controller: master_bedroom_no_controller,
                            keyboardType: TextInputType.number,
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
                                // borderSide: BorderSide(color: Color(0xff0748A6))
                              ),
                              fillColor: Colors.white,
                              hintStyle: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Cost per month:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black87,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter total rent per month ";
                            }
                          },
                          controller: rent_controller,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintMaxLines: 1,
                              // label: Text("Enter the cost"),
                              contentPadding: EdgeInsets.only(
                                  left: 20, right: 20, top: 8, bottom: 8),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 0.3,
                                    color: Colors.black54,
                                  )),
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
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    width: 0.3,
                                    color: Colors.black54,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 30,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: ButtonColor,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await FirebaseFirestore.instance
                              .collection("houses").doc()
                              .set({
                                "house_no": house_no_controller.text,
                                "kitchen": kitchen_no_controller.text,
                                "dining": dining_no_controller.text,
                                "seating_room": seating_room_no_controller.text,
                                "rooms": rooms_no_controller.text,
                                "master_bed_room":
                                    master_bedroom_no_controller.text,
                                "rent": rent_controller.text,
                                "house_owner_id": house_owner_email,
                            // check if house number is available
                              })
                              .then((value) => {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                registered_houses())),
                            // Fluttertoast.show
                                  })
                              .catchError((onError) =>
                                  {"something went wrong: $onError"});
                        }
                      },
                      child: Text(
                        "Register House",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
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
