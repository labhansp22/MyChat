// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_v1/Screens/HomeScreen.dart';
import 'wrapper.dart';
import 'user.dart';





class Authenticate extends StatelessWidget {
   const Authenticate({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context)
   {
    final user =Provider.of<User_?>(context);
    

    if (user == null) {
      return Wrapper();
    } else {
      return HomeScreen();
    }

  }

} 