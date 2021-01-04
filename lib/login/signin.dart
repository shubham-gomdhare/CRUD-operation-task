
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/HomePage.dart';
import 'package:flutter_app/login/forget.dart';
import 'package:flutter_app/login/signup.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user =  FirebaseAuth.instance.currentUser;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
        const EdgeInsets.only(left: 25, right: 25, top: 100, bottom: 35)  ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sign In',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff19769f),
                )),
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
                    contentPadding: EdgeInsets.only(top: 0, right: 0, left: 10, bottom: 0 ),
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
                    contentPadding: EdgeInsets.only(top: 0, right: 0, left: 10, bottom: 0 ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Color(0xff19769f),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Remember')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Forget(),));
                  },
                  child: Text(
                    'Forget Password ?',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () async {
                try{
                      if(emailController.text != null && passController.text != null){
                       final newUser = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
                       if(newUser != null) {
                         Navigator.pop(context);
                         Navigator.push(context, MaterialPageRoute(
                           builder: (context) => MyHomePage(),));

                       }
                       else
                         showDialog(context: context, child:
                         new AlertDialog(
                           title: new Text("Error!"),
                           content: new Text("Sign In failed!"),
                         ));
                  }
                }catch(e){
                  showDialog(context: context, child:
                  new AlertDialog(
                    title: new Text("Sign In failed!"),
                    content: new Text(e.toString()),
                  ));
                }
              },
              child: Container(
                height: 40,
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
                      'Sign In',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
            ),

            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Dont Have Account ? ',
                        style: TextStyle(color: Colors.grey),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Create Account.',
                              style: TextStyle(color: Color(0xff19769f))),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
