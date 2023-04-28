import 'package:flutter/material.dart';
import 'package:house_rental/Screen/Registration/Forgotpassword/verification_code.dart';

class phone_number_verification extends StatefulWidget {
  const phone_number_verification({Key? key}) : super(key: key);

  @override
  State<phone_number_verification> createState() =>
      _phone_number_verificationState();
}

class _phone_number_verificationState extends State<phone_number_verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xffD9D9D9),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Phone verification",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: Container(
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
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Please enter your phone number for",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Verification",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  // controller: phonenumberController,
                  // cursorColor: Colors.black,

                  cursorColor: Colors.black,
                  showCursor: true,
                  keyboardType: TextInputType.number,
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
                        "phone number",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      hintText: "Enter your phone number",
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                      prefixIcon: Icon(
                        Icons.call,
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => verification_code()));
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
          ),
        ),
      ),
    );
  }
}
