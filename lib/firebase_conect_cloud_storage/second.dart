import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'first.dart';

class logindata extends StatefulWidget {

  String name;
  String email;
  logindata(this.name, this.email);

  @override
  State<logindata> createState() => _logindataState();
}

class _logindataState extends State<logindata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login_Data_Show"),),
      body: Column(
        children: [

          Text("${widget.name}"),
          Text("${widget.email}"),

          SizedBox(height: 10,),
          ElevatedButton(onPressed:() {
            GoogleSignIn().signOut(); // logout kriye tyre login id vlu btve
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return connect_file();
            },));
          }, child: Text("Logout")),
        ],
      ),
    );
  }
}
