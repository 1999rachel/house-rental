import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_rental/Screen/Registration/SignUp/SignUp.dart';

import 'Screen/Registration/LogIn/LogIn.dart';
import 'Screen/normal_users/user_dashboard.dart';
import 'Screen/normal_users/user_dashboard/user_payments.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
 // await FirebaseMessaging.instance.getInitialMessage();
 //
 //
 //  FirebaseMessaging messaging = FirebaseMessaging.instance;
 //
 //  NotificationSettings settings = await messaging.requestPermission(
 //    alert: true,
 //    announcement: false,
 //    badge: true,
 //    carPlay: false,
 //    criticalAlert: false,
 //    provisional: false,
 //    sound: true,
 //  );
 //
 //  print('User granted permission: ${settings.authorizationStatus}');
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
 print(message.notification!.title.toString());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Color(0xff0748A6),
      ),
      home:  LogIn(),
    );
  }

}


// class auth_state_cheker extends StatelessWidget {
//   final ButtonColor = const Color(0xff0748A6);
//   const auth_state_cheker({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) =>Scaffold(
//
//     body: StreamBuilder(
//
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot){
//           if (snapshot.connectionState==ConnectionState.waiting){
//           return Center(
//           child: CircularProgressIndicator(
//
//           color: ButtonColor,
//           ),
//           );
//           }
//           else if (snapshot.hasError){
//             return Center(child: Text("Something went wrong"),);
//           }else if(snapshot.hasData){
//             return const user_darshboard();
//           }
//           else {
//             return LogIn();
//           }
//
//     }),
//   );
// }


