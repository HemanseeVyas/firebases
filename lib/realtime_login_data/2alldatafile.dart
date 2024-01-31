import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '1loginfile.dart';

class alldata extends StatefulWidget {
  const alldata({super.key});

  @override
  State<alldata> createState() => _alldataState();
}

class _alldataState extends State<alldata> {

  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Add Admin"),),
      body: Column(children: [
        SizedBox(height: 10,),
        IconButton(onPressed:  () {
        }, icon: Icon(Icons.contacts_outlined,size: 60,)),
        SizedBox(height: 70,),
        TextField(controller: name,decoration:InputDecoration(labelText: "Enter Name",border: OutlineInputBorder()),),
        SizedBox(height: 10,),
        TextField(controller: contact,decoration:InputDecoration(labelText: "Enter Contact",border: OutlineInputBorder())),
        SizedBox(height: 10,),
        TextField(controller: email,decoration:InputDecoration(labelText: "Enter Email",border: OutlineInputBorder())),
        SizedBox(height: 10,),
        TextField(controller: password,decoration:InputDecoration(labelText: "Enter Password",border: OutlineInputBorder())),
        SizedBox(height: 30,),
        ElevatedButton(onPressed: () async {

          DatabaseReference ref = FirebaseDatabase.instance.ref("add_data").push();

          await ref.set({
            "name": "${name.text}",
            "contact": "${contact.text}",
            "email": "${email.text}",
            "password": "${password.text}",
          });
          print(name.text);

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return login();
          },));
        }, child: Text("Submit"))


      ]),
    );
  }
}
