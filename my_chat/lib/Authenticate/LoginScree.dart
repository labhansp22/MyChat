// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'Methods.dart';
import 'package:flutter/material.dart';
import '../Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {

  final Function? toggleView;
  LoginScreen({this.toggleView});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final AuthService _auth=AuthService();
  final _formKey =GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Welcome in MY_CHAT",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Sign In to Contiue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10.0),
                       child: Form(
                        key: _formKey,
                        child:Column(
                          children: [
                              SizedBox(height: 10),
                              
                            SizedBox(
                              width:350,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_box),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (val)=>val!.isEmpty ? 'Enter mail ' : null,
                              onChanged: (val){
                                    setState(()=> email =val);
                                    }
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 350,
                              height: 50,
                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (val)=>val!.length<6 ? 'enter 6 char long password' : null,
                              onChanged: (val){
                                    setState(()=> password =val);
                                    }
                              ),
                            ),
                              SizedBox(height: 20),
                            ElevatedButton(
                              child: Text(
                                'Login',
                               style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: ()async{
                               if(_formKey.currentState!.validate()){
                                setState(() {
                                  isLoading=true;
                                });
                             dynamic result= await _auth.logIn(email, password);
                             
                             if (result ==null){
                              setState((){
                                error ='could not sign in with those cedentials';
                              isLoading=false;

                              }); 
                            }
                            }
                            },
                            ),
                             SizedBox(
                              height: size.height / 20,
                              ),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red,fontSize: 14),
                              ),

                        ],
                        ),
                        ),
                    ),
                  ),
                 
                
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.toggleView!();
                    },
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
 
}
