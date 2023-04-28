import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:house_rental/Screen/normal_users/user_dashboard/user_payments.dart';

import '../../Registration/Forgotpassword/change_password.dart';
import '../../Registration/LogIn/LogIn.dart';
import '../user_dashboard.dart';

class renter_account extends StatefulWidget {
  const renter_account({Key? key}) : super(key: key);

  @override
  State<renter_account> createState() => _renter_accountState();
}

class _renter_accountState extends State<renter_account> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
              "Account",
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
          children: [ Container(
          color: ButtonColor,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
          SizedBox(height: 10,),
                Container(
                  height: 160,
                  width: double.infinity,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: ClipRRect(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:FullScreenWidget(child: Image.asset(
                                "assets/profile1.jpeg",
                                // width: 60,height: 60,
                                fit: BoxFit.cover,
                              )),
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
                        height: 8,
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
          ),
        ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 65,
                  ),
                  Text("Rachel Jpahet Sironga",style: TextStyle(
                      color: Colors.black,
                  ),)
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 70,
                  ),
                  Text("rachelsironga19@gmail.com",style: TextStyle(
                      color: Colors.black,

                  ),)
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("phone 1",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 55,
                  ),
                  Text("25567877890789",style: TextStyle(
                      color: Colors.black,

                  ),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),


            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("phone 2",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 55,
                  ),
                  Text("25567877890789",style: TextStyle(
                      color: Colors.black,

                  ),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("Room no",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 55,
                  ),
                  Text("01",style: TextStyle(
                      color: Colors.black,

                  ),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("Date in",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 60,
                  ),
                  Text("14/5/2024",style: TextStyle(
                    color: Colors.black,

                  ),)
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("Date out",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 60,
                  ),
                  Text("14/5/2024",style: TextStyle(
                    color: Colors.black,

                  ),)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Row(

                children: [
                  Text("password",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 40,
                  ),

                  TextButton(

                    onPressed: (){

                      showDialog(context: (context), builder: (BuildContextcontext){

                        return Center(child: Container(
                          margin: EdgeInsets.only(left: 20,right: 20),


                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),

                          child: TextButton(
                            onPressed: (){

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>change_password()));
                            },
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child: Center(
                                child: Text("Change password",style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16

                                ),),
                              ),
                            ),
                          ),
                        ));

                      });
                    },
                    child: Text("Change password",style: TextStyle(
                        color: Colors.black
                    ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

      ),




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
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LogIn()));
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
