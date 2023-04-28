import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/normal_users/user_dashboard/renter_account.dart';
import 'package:house_rental/Screen/normal_users/user_dashboard/user_make_payments.dart';
import '../../House-Owner/Dashboard/Register_renter/make_payment.dart';
import '../../House-Owner/Dashboard/Renter_details/resit_view.dart';

import '../../Registration/LogIn/LogIn.dart';
import '../user_dashboard.dart';

class user_payments extends StatefulWidget {
  const user_payments({Key? key}) : super(key: key);

  @override
  State<user_payments> createState() => _user_paymentsState();
}

class _user_paymentsState extends State<user_payments> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final DrawableButtonColor = const Color(0xffD9D9D9);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      floatingActionButton: Container(
        width: 200,
        height: 45,
        decoration: BoxDecoration(
          color: ButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(10))

        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: ButtonColor,
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>use_make_payments()));
          },
        child: Text("Make Payments"),
        ),
      ),
      drawer: Drawer(
        child: Material(
          child: Column(
            children: [DrawerHeader(context), DrawerList(context)],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ButtonColor,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: 35,
              child: Divider(
                thickness: 3,
                height: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.notifications,
        //         size: 24,
        //         color: Colors.white,
        //       ))
        // ],
      ),


      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: BackgroundColor,
          child: Column(
            children: [
              // SizedBox(height: 15,),

              Expanded(
                // child:  Padding(padding: EdgeInsets.only(left: 20,right: 20),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          height: 90,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Date",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 42,
                                  ),
                                  Text(
                                    "13.3.2023",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Account",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "95346772719871771",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 1),
                                    decoration: BoxDecoration(
                                        color: Color(0xff0748A6),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    height: 30,
                                    width: 95,
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          resit_view()));
                                            },
                                            child: Text(
                                              "view resits",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: 20),
              ),
            ],
          )),
    ));
  }

  Widget DrawerHeader(BuildContext context) {
    return Container(
      color: ButtonColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 200,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: ClipRRect(
                    child: Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/profile1.jpeg",
                          // width: 60,height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: BackgroundColor,
                          border: Border(
                              top: BorderSide(width: 1, color: Colors.grey),
                              left: BorderSide(width: 1, color: Colors.grey),
                              right: BorderSide(width: 1, color: Colors.grey),
                              bottom: BorderSide(width: 1, color: Colors.grey)),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Juma Ally Shamba",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "House no.",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("1",
                        style: TextStyle(
                            color: Color(0xffC21F1F),
                            fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget DrawerList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Material(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => user_darshboard()));
              },
              leading: Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => user_payments()));
              },
              leading: Icon(
                Icons.payments_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Payments",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>user_calender()));
              },
              leading: Icon(
                Icons.calendar_month_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Calender",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>message()));
              },
              leading: Icon(
                Icons.message_outlined,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Messages",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>renter_account()));
              },
              leading: Icon(
                Icons.person,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Accounts",
                style: TextStyle(fontSize: 17),
              ),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();

              },
              leading: Icon(
                Icons.logout,
                color: Colors.black,
                size: 24,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
