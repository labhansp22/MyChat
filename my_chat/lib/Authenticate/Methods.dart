
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';

class AuthService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  final FirebaseAuth _auth=FirebaseAuth.instance;


  User_? _userFromFirebaseUser(User? user){
    return user != null ? User_(uid: user.uid) : null;
  }

  Stream<User_?> get user{
    return _auth.authStateChanges()
    .map(_userFromFirebaseUser);
  }


  Future createAccount(String name, String email, String password) async {
  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
        User? user=userCrendetial.user;
    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "status": "Unavalible",
      "uid": _auth.currentUser!.uid,
    });

    return _userFromFirebaseUser(user);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

     Future logIn(String email, String password) async {
      

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
      
        User? user=userCredential.user;
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return _userFromFirebaseUser(user);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

   Future logOut() async {
     try {
      return await _auth.signOut();
      
    }
   catch (e) {
    print(e.toString());
    return null;
  }
}
}