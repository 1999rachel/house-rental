import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../Utils/UpperCaseTextFormat.dart';
import '../../../services/notification_services.dart';
import '../account/account.dart';
import '../dashboard.dart';
import 'package:http/http.dart' as http;

class notification_page extends StatefulWidget {
  const notification_page({Key? key}) : super(key: key);

  @override
  State<notification_page> createState() => _notification_pageState();
}

class _notification_pageState extends State<notification_page> {
  final ButtonColor = const Color(0xff0748A6);
  final BackgroundColor = const Color(0xffEEEEEE);
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodycontroller = TextEditingController();
  bool isLoading = false;

  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  NotificationServices notificationServices = NotificationServices();
  final now = DateTime.now();

  // @override
  // initState(){
  //   // requestPermission() ;
  //   initInfo();
  //
  //   super.initState();
  // }
  // initInfo(){
  //
  //   var androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher.png');
  //   var initializationSettings = InitializationSettings(android:androidInitialize );
  //   flutterLocalNotificationPlugin.initialize(initializationSettings,onSelect)
  //   // var iosInitialize = IOSInitializationSettings();
  //   // var initializationSettings = InitializationSettings(android:androidInitialize,iOS: iosInitialize );
  //
  //
  // }
  //
  //  requestPermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     carPlay: false,
  //     badge: true,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //
  //   );
  //
  //   if(settings.authorizationStatus==AuthorizationStatus.authorized){
  //     print("user granted permission");
  //   }
  //   else if (settings.authorizationStatus == AuthorizationStatus.provisional){
  //     print("user granted provisional permission");
  //   }
  //   else{
  //     print("user has not be granted permission");
  //   }
  //
  //
  // }
  // getToken() async {
  //
  // await   FirebaseMessaging.instance.getToken().then((token){
  //     setState(() {
  //       mtoken = token!;
  //       print("device token ${mtoken}");
  //     });
  //
  //     saveToken(token!);
  //
  //   });
  // }
  //
  // saveToken(String token) async {
  //  await FirebaseFirestore.instance.collection("house_owner_db").doc(_auth.currentUser?.uid).update(
  //  {
  //
  //    'token':token
  //
  //
  //      });
  //
  // }

  // @override
  // initState(){
  //   notificationServices.sendPushMessage(token, body, title)
  //
  //
  //   super.initState();
  // }
  // void sendPushMessage(String token, body, title)async{
  //   try{
  //
  //     await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //         headers: <String, String>{
  //
  //           'Content-Type':'application/json',
  //           'Authorization':'key=AAAA3oTTLGY:APA91bH5PJKzAbXLvfOkdqyyRVNw3j71FWE_s6pY9AU0Bn3zXLQ1DXySt1KbJsCGcgrzd99St9zwnsKt167Db49lf1c-1h21HX4VxryAPvCP0lN8RVGKCHZHG1UEJU9q7vW160wojlw8'
  //         },
  //
  //         body: jsonEncode(<String, dynamic>{
  //
  //           'priority': 'high',
  //           'data':<String, dynamic>{
  //             'click_action':'FLUTTER_NOTIFICATION_CLICK',
  //             'status': ' done',
  //             'body':body,
  //             'tittle':title
  //           },
  //
  //           "notification":<String, dynamic>{
  //
  //             "title": title,
  //             "body": body,
  //             "android_channel_id":'high_importance_channel',
  //
  //           },
  //           "to": token,
  //
  //
  //         })
  //
  //
  //     );
  //
  //
  //   }
  //   catch(e){
  //
  //     if(kDebugMode){
  //       print ("error during pushing notification");
  //
  //     }
  //
  //
  //   }
  //
  //
  // }

   sendNotificationToRenter(String name, String title, String body) async {
    QuerySnapshot renterSnapshot = await FirebaseFirestore.instance
        .collection('renters_db')
        .where('email', isEqualTo: name)
        .where('status', isEqualTo: 'active')
        .get();

    if (renterSnapshot != null && renterSnapshot.docs.isNotEmpty) {
      print("user found");
      var documentSnapshot = renterSnapshot.docs[0];
      var data = documentSnapshot.data() as Map<String, dynamic>;
      String token = data['token'];


      sendPushMessage(token, title, body,name);

      // Show success message or perform any other action
    }

    else {
      // Renter not found, show error message or perform any other action
    }
  }

  void sendPushMessage(String token, body, title, String name) async {
    try {
      FirebaseFirestore.instance.collection('notifications_db').add(
          {
            'renterEmail':name,
            'house_owner_Email':_auth.currentUser!.uid,
            'token':token,
            'createdAt':now,
            'status':'active',
            'title': title,
            'body': body




          });
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAA3oTTLGY:APA91bH5PJKzAbXLvfOkdqyyRVNw3j71FWE_s6pY9AU0Bn3zXLQ1DXySt1KbJsCGcgrzd99St9zwnsKt167Db49lf1c-1h21HX4VxryAPvCP0lN8RVGKCHZHG1UEJU9q7vW160wojlw8'
          },
          body: jsonEncode(<String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': ' done',
              'body': body,
              'tittle': title
            },
            "notification": <String, dynamic>{
              "title": title,
              "body": body,
              "android_channel_id": 'high_importance_channel',
            },
            "to": token,
          }));

      print("notification sent successfully");
    } catch (e) {
      print("cant send notification");
    }
  }

  // Future<void> sendPushMessage(String token, String title, String body) async {
  //     final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //
  //   // final url = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'));
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'key=AAAA3oTTLGY:APA91bH5PJKzAbXLvfOkdqyyRVNw3j71FWE_s6pY9AU0Bn3zXLQ1DXySt1KbJsCGcgrzd99St9zwnsKt167Db49lf1c-1h21HX4VxryAPvCP0lN8RVGKCHZHG1UEJU9q7vW160wojlw8',
  //   };
  //
  //   final notification = {
  //     'title': title,
  //     'body': body,
  //   };
  //
  //   final message = {
  //     'token': token,
  //     'notification': notification,
  //   };
  //
  //   final bodyJson = jsonEncode(message);
  //
  //   await http.post(url, headers: headers, body: bodyJson);
  //
  //    print("notification sent");
  // }

  sendNotification(){


  }

  //
  // Future<List<String>> fetchDataFromFirebase() async {
  //   List<String> names = [];
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('renters_db').where('house_owner_id', isEqualTo: 'cfkWq0PES9YLVA3qXO8BkySRDXK2').where('email', isEqualTo: 'jean@gmail.com')// Replace with your collection name
  //       .get();
  //   // isEqualTo: _auth.currentUser!.uid
  //   querySnapshot.docs.forEach((doc) {
  //     String name = doc.get('full_name'); // Replace with the field name in your documents
  //     names.add(name);
  //   });
  //
  //   return names;
  // }

  // String selectedName = '';
  // List<String> names = [];
  //
  // Future<void> fetchData() async {
  //   List<String> fetchedNames = await fetchDataFromFirebase();
  //   setState(() {
  //     names = fetchedNames;
  //   });
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  @override
  dispose() {
    namecontroller.dispose();
    bodycontroller.dispose();
    titlecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => notification_page()));
              },
              icon: Icon(Icons.notifications, size: 30)),
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
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: ButtonColor,
        leading: Container(),
        // leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
        title: Text(
          "Create New Notification",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        color: ButtonColor,
        width: double.infinity,
        height: double.infinity,
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  width: double.infinity,
                  child: Center(
                    child: Image.asset("assets/logo2.png"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 4),
                              blurRadius: 4)
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text("Welcome back",style: TextStyle(
                                    //     color: Colors.black,
                                    //     fontSize: 20,
                                    //     fontWeight: FontWeight.bold
                                    // ),),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Text("Create your new notification here",style: TextStyle(
                                    //     color: Colors.black,
                                    //     // fontSize: 17,
                                    //     fontWeight: FontWeight.w400
                                    // ),)

                                    SizedBox(
                                      height: 40,
                                    ),

                                    Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Name:")),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: namecontroller,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black38)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff0748A6),
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0xff0748A6))),
                                          hintText: "eg.abc@gmail.com",
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 30,
                                    // ),
                                //
                                // DropdownButtonFormField<String>(
                                //   value: selectedName,
                                //   items: names.asMap().entries.map((entry) {
                                //     int index = entry.key;
                                //     String name = entry.value;
                                //     return DropdownMenuItem<String>(
                                //       value: index.toString(),
                                //       child: Text(name),
                                //     );
                                //   }).toList(),
                                //   onChanged: (value) {
                                //     setState(() {
                                //       selectedName = names[int.parse(value!)];
                                //     });
                                //   },
                                //   decoration: InputDecoration(
                                //     labelText: 'Select a name',
                                //   ),
                                // ),




                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Title:")),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: TextFormField(

                                        inputFormatters: <TextInputFormatter>[
                                          UpperCaseTextFormat()
                                        ],
                                        controller: titlecontroller,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black38)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff0748A6),
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0xff0748A6))),
                                          hintText: "eg.Payments",
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),

                                    Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text("Body:")),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        inputFormatters: <TextInputFormatter>[
                                          UpperCaseTextFormat()
                                        ],
                                        controller: bodycontroller,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.black38)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xff0748A6),
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0xff0748A6))),
                                          hintText:
                                              "eg. Mkataba wako unaisha...",
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 30,
                                    ),

                                isLoading?Container(
                                  child: SpinKitCircle(

                                    color: ButtonColor,
                                  ),
                                ): GestureDetector(
                                      onTap: () async {

                                        String name =
                                        namecontroller.text.trim();
                                        String title =
                                        titlecontroller.text.trim();
                                        String body =
                                        bodycontroller.text.trim();


                                        if (name.isEmpty || title.isEmpty || body.isEmpty) {
                                          // Show an error message if any field is empty
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Error"),
                                                content: Text("Please fill in all the fields"),
                                                actions: [
                                                  TextButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                        else {
                                          // Start loading
                                          setState(() {
                                            isLoading = true;
                                          });

                                          // Process the notification
                                          await sendNotificationToRenter(name, title, body);

                                          // Stop loading and show normal button
                                          setState(() {
                                            isLoading = false;
                                          });

                                          // Show a success message
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Notification sent successfully',style: TextStyle(
                                                color: Colors.white
                                              ),),
                                              backgroundColor: Colors.black87,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );

                                          // Clear the input fields
                                          namecontroller.clear();
                                          titlecontroller.clear();
                                          bodycontroller.clear();
                                        }
                                        // if (name != " ") {
                                        //   sendNotificationToRenter(
                                        //       name, title, body);
                                        //
                                        //   // QuerySnapshot renterSnapshot = await FirebaseFirestore.instance.collection('renters_db').where('email', isEqualTo: name).get();
                                        //   //  if (renterSnapshot!= null && renterSnapshot.docs.isNotEmpty){
                                        //   //    var documentSnapshot = renterSnapshot.docs[0];
                                        //   //    var data = documentSnapshot.data() as Map<String, dynamic>;
                                        //   //
                                        //   //    String token = data['token'];
                                        //   //
                                        //   //    print('token');
                                        //   //
                                        //   //    sendPushMessage(token,title,body);
                                        //   //
                                        //   //    setState(() {
                                        //   //
                                        //   //      namecontroller.clear();
                                        //   //      titlecontroller.clear();
                                        //   //      bodycontroller.clear();
                                        //   //
                                        //   //
                                        //   //    });
                                        //   //
                                        //   //  }
                                        //   //   if(renterSnapshot==null){
                                        //   //
                                        //   //     print("user not found");
                                        //   //     showDialog(context: context, builder: (context){
                                        //   //       return Dialog(
                                        //   //         child: Container(
                                        //   //           height: 100,
                                        //   //           width: double.infinity,
                                        //   //           decoration: BoxDecoration(
                                        //   //               color:Colors.white,
                                        //   //               boxShadow: [
                                        //   //                 BoxShadow(
                                        //   //                     offset: Offset(2, 4),
                                        //   //                     blurRadius: 4,
                                        //   //                     spreadRadius:4,
                                        //   //                     blurStyle: BlurStyle.normal
                                        //   //
                                        //   //
                                        //   //
                                        //   //                 )
                                        //   //               ],
                                        //   //               borderRadius:BorderRadius.all(Radius.circular(15),
                                        //   //
                                        //   //
                                        //   //               )
                                        //   //           ),
                                        //   //           child: Column(
                                        //   //             children: [
                                        //   //               Text("Please enter correct email  address")
                                        //   //
                                        //   //             ],
                                        //   //           ),
                                        //   //         ),
                                        //   //       );
                                        //   //
                                        //   //
                                        //   //
                                        //   //     });
                                        //   //
                                        //   //     // setState(){
                                        //   //     //   super.initState();
                                        //   //     //
                                        //   //     //
                                        //   //     // }
                                        //   //   }
                                        //   //
                                        //
                                        //   setState(() {
                                        //     isLoading=true;
                                        //     namecontroller.clear();
                                        //     titlecontroller.clear();
                                        //     bodycontroller.clear();
                                        //   });
                                        // }

                                        setState(() {

                                          isLoading=false;

                                        });

                                      },
                                      child: Container(
                                        // margin: EdgeInsets.only(left: 10,right: 10),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xff0748A6),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [

                                            Container(),
                                            Text(
                                              "Send",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.white.withOpacity(0.5),
                                              ),
                                            )


                                          ],

                                        ),
                                      ),
                                    )


                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
