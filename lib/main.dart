import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_rental/Screen/Registration/SignUp/SignUp.dart';

import 'Screen/Registration/LogIn/LogIn.dart';
import 'Screen/normal_users/user_dashboard.dart';
import 'Screen/normal_users/user_dashboard/user_payments.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home:  auth_state_cheker(),
    );
  }
}


class auth_state_cheker extends StatelessWidget {
  final ButtonColor = const Color(0xff0748A6);
  const auth_state_cheker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>Scaffold(

    body: StreamBuilder(

        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
          return Center(
          child: CircularProgressIndicator(

          color: ButtonColor,
          ),
          );
          }
          else if (snapshot.hasError){
            return Center(child: Text("Something went wrong"),);
          }else if(snapshot.hasData){
            return const user_darshboard();
          }
          else {
            return const LogIn();
          }

    }),
  );
}


