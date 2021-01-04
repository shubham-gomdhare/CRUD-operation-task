
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/login/signin.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController confPassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),

        body: Padding(
          padding: const EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff19769f),
                  )
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'E-mail',
                      contentPadding: EdgeInsets.only(
                          top: 0, right: 0, left: 10, bottom: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  controller: passController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      contentPadding: EdgeInsets.only(
                          top: 0, right: 0, left: 10, bottom: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 18),
                  controller: confPassController,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      contentPadding: EdgeInsets.only(
                          top: 0, right: 0, left: 10, bottom: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if (passController.text == confPassController.text) {
                    _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text);
                    showDialog(context: context, child:
                    new AlertDialog(
                      title: new Text("Success!"),
                      content: new Text("User created successfully!"),
                    ));
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => MyHomePage(),));
                  } else {
                    showDialog(context: context, child:
                    new AlertDialog(
                      title: new Text("Error!"),
                      content: new Text("Password did not match!"),
                    ));
                  }
                },
                /*Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile())),*/
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, offset: Offset(0, 3), blurRadius: 2)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[Color(0xff19769f), Color(0xff35d8a6)]),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child:InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                    Navigator.pop(context);
                  },

                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account ? ',
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Sign In!',
                              style: TextStyle(color: Color(0xff19769f))),
                        ],
                      ),
                    ),
                  )
              ) ,)
            ],
          ),
        )
    );
  }
}