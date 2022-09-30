
// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'Methods.dart';
import '../Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginScree.dart';



class CreateAccount extends StatefulWidget {
  final Function? toggleView;
  CreateAccount({this.toggleView});
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  
  final AuthService _auth=AuthService();
  bool isLoading = false;
  final _formKey= GlobalKey<FormState>();
  String name = '';
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
                        icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context),),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    width: size.width / 1.1,
                    // ignore: prefer_const_constructors
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
                      "Create Account to Contiue!",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            SizedBox(
                              width: 350,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.account_box),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (val)=>val!.isEmpty ? 'Enter name' : null,
                              onChanged: (val){
                                    setState(()=> name =val);
                                    }
                              ),
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                               width: 350,
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.mail),
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
                            SizedBox(height: 20),
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
                                'createAccount',
                               style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: ()async{
                                if(_formKey.currentState!.validate()){
                                  dynamic result=await _auth.createAccount(name, email, password);
                                  if(result==null){
                                    setState(()=> error ='please enter a valid email');
                                  }
                                  else{
                                    Navigator.push(
                             context, MaterialPageRoute(builder: (_) => HomeScreen()));
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Text(
                              error,
                              style: TextStyle(color: Colors.red,fontSize: 14),
                            ),

                        ],
                        ),
                        )
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        widget.toggleView!();
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
