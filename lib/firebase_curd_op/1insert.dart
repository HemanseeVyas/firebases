import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '2views.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: adds(),));
}
class adds extends StatefulWidget {
  String ? id;
  Map<String, dynamic> ? data;
  adds([this.id,this.data]);



  @override
  State<adds> createState() => _addsState();
}

class _addsState extends State<adds> {

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.id!=null)
      {
            t1.text=widget.data!['name'];
            t2.text=widget.data!['contact'];
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Curd"),),
      body: Column(children: [
        SizedBox(height: 10),
        TextField(
          controller: t1,
        ),
        SizedBox(height: 10,),
        TextField(
          controller: t2,
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {

            String name=t1.text;
            String contact=t2.text;

            if(widget.id!=null)
              {
                users
                    .doc(widget.id)
                    .update({'name': name,'contact': contact})
                    .then((value) => print("User Updated"))
                    .catchError((error) => print("Failed to update user: $error"));
              }
            else
              {
                users
                    .add({
                  'name': name, // John Doe
                  'contact': contact, // Stokes and Sons

                })
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add user: $error"));
              }


        }, child: Text("Add")),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return views();
          },));
        }, child: Text("View"))
      ],),
    );
  }
}
