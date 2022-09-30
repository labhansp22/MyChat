
import 'package:flutter/material.dart';
import 'CreateAccount.dart';
import 'LoginScree.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({ Key? key }) : super(key: key);


  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool showSignIn = true;
  void toggleView(){
    setState(()=> showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    
     if (showSignIn){
      return LoginScreen(toggleView: toggleView);
    }
    else{
      return CreateAccount(toggleView: toggleView);
    }
  }
}