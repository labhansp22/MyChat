import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authenticate/Autheticate.dart';
import 'Authenticate/Methods.dart';
import 'Authenticate/user.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User_?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Authenticate(),
      ),
    );
  }
}