// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationServices {
//   FirebaseMessaging messeging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messeging.requestPermission(
//       alert: true,
//       badge: true,
//       announcement: true,
//       sound: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print("user granted permission");
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print("user granted provisional permission permission");
//     } else {
//       print("user not granted permission");
//     }
//   }
//
//   void showNotification(String title, String body) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         Random.secure().nextInt(100000).toString(), "House Rental ",
//         importance: Importance.max);
//
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       channel.id.toString(),
//       channel.name.toString(),
//       channelDescription: "House Rental description",
//       // channelDescription: "House Rental description"
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: "ticker",
//     );
//
//     DarwinNotificationDetails darwinNotificationDetails =
//         const DarwinNotificationDetails(
//             presentAlert: true, presentBadge: true, presentSound: true);
//
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//       iOS: darwinNotificationDetails,
//     );
//     //
//     // Future.delayed(Duration.zero,(){
//     await _flutterLocalNotificationPlugin.show(
//         0, title, body, notificationDetails);
//     // }
//     // );
//   }
//
//   // Future<String> getDeviceToken() async {
//   //   String? token = await messeging.getToken();
//   //   return token!;
//   // }
//
//   void initLocalNotification() async {
//     var androidInitializationSetting =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     var iosInitializationSetting = const DarwinInitializationSettings();
//
//     var initializationSettings = InitializationSettings(
//         android: androidInitializationSetting, iOS: iosInitializationSetting);
//
//     await _flutterLocalNotificationPlugin.initialize(initializationSettings);
//   }
//   //
//   // firebaseInit(){
//   //
//   //   FirebaseMessaging.onMessage.listen((message) {
//   //
//   //     if(kDebugMode){
//   //       print(message.notification!.title.toString());
//   //       print(message.notification!.body.toString());
//   //     }
//   //
//   //     showNotification(message);
//   //
//   //
//   //   });
//   //
//   //
//   // }
//   //
//   // Future<void> showNotification(RemoteMessage message) async {
//   //
//   //   AndroidNotificationChannel  channel = AndroidNotificationChannel(
//   //       Random.secure().nextInt(100000).toString(),
//   //     "House Rental ",
//   //     importance: Importance.max
//   //   );
//   //
//   //
//   //   AndroidNotificationDetails  androidNotificationDetails = AndroidNotificationDetails(
//   //       channel.id.toString(),
//   //       channel.name.toString(),
//   //     channelDescription: "House Rental description",
//   //       // channelDescription: "House Rental description"
//   //     importance: Importance.high,
//   //     priority: Priority.high,
//   //     ticker: "ticker",
//   //
//   //   );
//   //
//   //
//   //   DarwinNotificationDetails  darwinNotificationDetails = DarwinNotificationDetails(
//   //     presentAlert: true,
//   //     presentBadge: true,
//   //     presentSound: true
//   //
//   //   );
//   //
//   //   NotificationDetails  notificationDetails  = NotificationDetails(
//   //     android: androidNotificationDetails,
//   //     iOS: darwinNotificationDetails,
//   //   );
//   //   //
//   //   Future.delayed(Duration.zero,(){
//   //     _flutterLocalNotificationPlugin.show(
//   //         0,
//   //         message.notification!.title.toString(),
//   //         message.notification!.body.toString(),
//   //         notificationDetails
//   //     );
//   //   }
//   //
//   //   );
//   //
//   //
//   // }
//   //
//   // void isTokenRefresh() async {
//   //   await messeging.onTokenRefresh.listen((event) {
//   //     event.toString();
//   //   });
//   // }
// }


import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../House-Owner/Dashboard/notifications.dart';

class NotificationServices{

  FirebaseMessaging messeging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin  _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

   void requestPermission () async {
    NotificationSettings settings =await  messeging.requestPermission(

      alert: true,
      badge: true,
      announcement: true,
      sound: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission permission");
    } else {
      print("user not granted permission");
    }


  }



void initLocalNotifications(BuildContext context,RemoteMessage message) async {

    var _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var _iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _iosInitializationSettings
    );
    await _flutterLocalNotificationPlugin.initialize(

        initializationSettings,

      onDidReceiveNotificationResponse: (payload){
          if(payload!= null){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
              return notifications(payload.toString());

            }));


          }


      }
    );

    //   print(message.notification!.title.toString());
    // print(message.notification!.body.toString());



  }

  void firebaseInit(){

     FirebaseMessaging.onMessage.listen((message) {

   if(kDebugMode){
     print(message.notification!.body.toString());
     print(message.notification!.title.toString());
     print(message.data.toString());
   }

       showNotifications(message);




     });
  }

  Future<void> showNotifications(RemoteMessage message) async{
      AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
          "High importance notification",
        importance: Importance.max
      );
     AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(


       channel.id.toString(),
       channel.name.toString(),
       channelDescription: 'your channel description',
       importance: Importance.high,
       priority: Priority.high,
       ticker: 'ticker'

     );

     DarwinNotificationDetails darwinNotificationDetails =DarwinNotificationDetails(
       presentAlert: true,
       presentBadge: true,
       presentSound: true
     );
     NotificationDetails notificationDetails = NotificationDetails(
       android: androidNotificationDetails,
       iOS: darwinNotificationDetails

     );
     Future.delayed(Duration.zero,(){
       _flutterLocalNotificationPlugin.show(
           0,
           message.notification!.title.toString(),
           message.notification!.body.toString(),
           notificationDetails

       );
     }



     );


  }

  Future<String> getDeviceToken() async {

     String? token =await  messeging.getToken();
     return token!;
  }

void isTokenRefresh() async {
     messeging.onTokenRefresh.listen((event) {
       event.toString();
       print ("refresh");

     });
  }

  void handleMessage (BuildContext context, RemoteMessage message){


  }


}