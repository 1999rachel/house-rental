import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:house_rental/Screen/Registration/LogIn/LogIn.dart';
import 'package:house_rental/Utils/PreferenceUtil.dart';

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
  final List<Widget> screen = [dashboard(), notifications(), salon_owner_account()];

  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>dashboard()));
            },
            icon:Icon(
              Icons.home,
              size: 30,
            ),
          ),
          IconButton(

              onPressed: (){},
              icon:Icon(Icons.notifications, size: 30)),
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>salon_owner_account()));
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
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              child: Center(
                child: Image.asset("assets/logo2.png",fit: BoxFit.cover,),
              ),
              decoration: BoxDecoration(

                  color: ButtonColor,
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )
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
                    width: 70,
                  ),
                  Text("Rachel Jpahet Sironga",style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
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
              Text("Gender",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(
                width: 65,
              ),
              Text("Female",style: TextStyle(
                  color: Colors.black,
                  fontSize: 16

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
                  Text("rachelsironga19@gmail.com",maxLines: 1,style: TextStyle(
                      color: Colors.black,
                      fontSize: 16

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
                  Text("phone",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 70,
                  ),
                  Text("25567877890789",style: TextStyle(
                      color: Colors.black,
                      fontSize: 16

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
                    child: Text("******",style: TextStyle(
                      color: Colors.black
                    ),
                    ),
                  ),


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
                  Text("Sign Out",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: 40,
                  ),

                  TextButton(

                 onPressed: ()=> logOut(),
                  child: const Icon(Icons.logout,color: Colors.black,),
                  ),


                ],
              ),
            )
          ],
        ),

      ),
    ));
  }

  logOut() {
    PreferenceUtil().removeItem("email");
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const LogIn()));
  }
}
