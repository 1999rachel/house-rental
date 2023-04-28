import 'package:flutter/material.dart';

import '../LogIn/LogIn.dart';

class account_validation extends StatefulWidget {
  const account_validation({Key? key}) : super(key: key);

  @override
  State<account_validation> createState() => _account_validationState();
}

class _account_validationState extends State<account_validation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffD9D9D9),
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.black,
            )),
        title: Text(
          "Verification code",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xffEEEEEE)),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Please enter verification code sent to",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "0734900159",
                    style: TextStyle(
                        color: Colors.black,
                        // fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 45,
              child: TextFormField(
                textAlign: TextAlign.center,

                // controller: phonenumberController,
                // cursorColor: Colors.black,
                cursorColor: Colors.black,
                showCursor: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
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
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 0,
              color: Color(0xffD9D9D9),
              child: Container(
                height: 40,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xff0748A6),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
