import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/payments/renter_list.dart';
import 'package:house_rental/Screen/House-Owner/Dashboard/register_houses/registered_houses.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import 'Register_renter/renter_registration_stage1.dart';
import 'Renter_details/check_renter_payments.dart';
import 'Renter_details/renter_detail.dart';
import 'account/account.dart';
import 'notifications.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final CardColor = const Color(0xffFBFBFB);
  int currentTab = 0;
  final List<Widget> screen = [
    dashboard(),
    notifications(),
    salon_owner_account()
  ];

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  Widget currentWidget = dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
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
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: BackgroundColor),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(color: ButtonColor),
            child: Padding(
              padding: EdgeInsets.only(bottom: 40,top: 10),
              child: Center(
                child: Image.asset("assets/logo2.png"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200, left: 15, right: 15),
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Container(
                width: double.infinity,
                // padding: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              registered_houses()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: BackgroundColor),
                                  child: Icon(
                                    Icons.app_registration,
                                    size: 70,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Register houses",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              renter_registration_stage1()));
                                },
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: BackgroundColor),
                                    child: Center(
                                      child: Icon(
                                        Icons.person_add_alt_1_sharp,
                                        size: 70,
                                        color: Colors.black87,
                                      ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Register renter",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              renter_details()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                      color: BackgroundColor),
                                  child: Center(
                                      child: Icon(
                                    Icons.people,
                                    size: 70,
                                    color: Colors.black87,
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Renter details",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              renter_payments()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                      color: BackgroundColor),
                                  child: Center(
                                      child: Icon(
                                    Icons.newspaper,
                                    size: 70,
                                    color: Colors.black87,
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Contracts",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
