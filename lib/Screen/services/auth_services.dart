
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class Authservices {

FirebaseAuth _auth =  FirebaseAuth.instance;



// SignInWithEmailAndPassword

  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = _auth.signInWithEmailAndPassword(email: email, password: password) as UserCredential;
      User? user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;

    }
  }


  Future registerEmailAndPassword(String email, String password) async{
  try {
    UserCredential result = _auth.createUserWithEmailAndPassword(email: email, password: password) as UserCredential;
    User? user = result.user;
    return _userFromFirebaseUser(user);

}catch(e){
    print(e.toString());
    return null;

  }
  }

  // user object

  User? _userFromFirebaseUser(User? user) {

    return user!=null? user :null;
  }

  //create a signin stream




}