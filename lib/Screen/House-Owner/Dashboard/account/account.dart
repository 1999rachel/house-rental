import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:house_rental/Screen/Registration/LogIn/LogIn.dart';
import 'package:house_rental/Utils/PreferenceUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Registration/Forgotpassword/change_password.dart';
import '../dashboard.dart';
import '../notifications.dart';

class salon_owner_account extends StatefulWidget {
  const salon_owner_account({Key? key}) : super(key: key);

  @override
  State<salon_owner_account> createState() => _salon_owner_accountState();
}

class _salon_owner_accountState extends State<salon_owner_account> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final List<Widget> screen = [
    dashboard(),
    notifications(),
    salon_owner_account()
  ];

  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LogIn())));
  }
  Future<void> logOut() async {
    // Update login status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);

    // Navigate back to the login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  }


  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => dashboard()));
            },
            icon: Icon(
              Icons.home,
              size: 30,
            ),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications, size: 30)),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => salon_owner_account()));
            },
            icon: Icon(Icons.person, size: 30),
          ),
        ],
        color: BackgroundColor,
        buttonBackgroundColor: ButtonColor,
        backgroundColor: BackgroundColor,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: BackgroundColor,
        child: StreamBuilder<DocumentSnapshot>(
          // stream: FirebaseFirestore.instance.collection("house_owner_db").doc(_auth.currentUser?.uid).snapshots(),

          stream: FirebaseFirestore.instance
              .collection("house_owner_db")
              .doc(_auth.currentUser?.uid)
              .snapshots(),

          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKitCircle(color: ButtonColor));
            }
            final data = snapshot.data!.data() as Map<String, dynamic>;
            // final full_name = data['full_name'] as String;
            // final gender = data['gender'] as String;
            // final email = data['email'] as String;
            // final primary_phone_number = data['primary_phone_number'] as String;
            // final secondary_phone_number =
            //     data['secondary_phone_number'] as String;

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  child: Center(
                    child: Image.asset(
                      "assets/logo2.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: ButtonColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 73,
                      ),
                      Text(
                        data['full_name'],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 65,
                      ),
                      Text(
                        data['gender'],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 75,
                      ),
                      Text(
                        data['email'],
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "phone 1",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        data['primary_phone_number'],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "phone 2",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        data['secondary_phone_number'],
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "password",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: (context),
                              builder: (BuildContextcontext) {
                                return Center(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  width: double.infinity,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  change_password()));
                                    },
                                    child: Container(
                                      height: 45,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Center(
                                        child: Text(
                                          "Change password",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                              });
                        },
                        child: Text(
                          "******",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        "Sign Out",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      TextButton(
                        onPressed: () async {

                          logOut();
                          // SharedPreferences pref =  await SharedPreferences.getInstance();
                          //  pref.setBool('logIn', false);
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn()));
                          //
                          //  //     .then((value) =>
                          //  //
                          //  //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn()))
                          //  // );
                          //

                        },
                        // onPressed: () => _signOut(),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    ));
  }

  // logOut() {
  //   PreferenceUtil().removeItem("email");
  //   Navigator.of(context).push(
  //       MaterialPageRoute(
  //           builder: (context) => const LogIn()));
  // }
}
