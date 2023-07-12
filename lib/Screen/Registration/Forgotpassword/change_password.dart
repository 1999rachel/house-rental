import 'package:flutter/material.dart';

import '../../House-Owner/Dashboard/account/account.dart';
import '../LogIn/LogIn.dart';

class change_password extends StatefulWidget {
  const change_password({Key? key}) : super(key: key);

  @override
  State<change_password> createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffD9D9D9),
        elevation: 0,
        leading: IconButton(
            onPressed: () {

              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>salon_owner_account()));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.black,
            )),
        title: Text(
          "Change password",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xffEEEEEE)),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              child: TextFormField(
                // controller: phonenumberController,
                // cursorColor: Colors.black,
                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.text,
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
                      "New password",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    hintText: "Enter new password",
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
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
              height: 45,
              child: TextFormField(
                // controller: phonenumberController,
                // cursorColor: Colors.black,
                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.text,
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
                      "New password",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    hintText: "Enter  new password",
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
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
              height: 45,
              child: TextFormField(
                // controller: phonenumberController,
                // cursorColor: Colors.black,

                keyboardAppearance: Brightness.dark,
                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.text,
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
                      "Confrim password",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    hintText: "Confirm password",
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black54,
                    )),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff0748A6),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 45,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
