import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebases/realtime_login_data/2alldatafile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '3dashboard.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: login(),));
}
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController user=TextEditingController();
  TextEditingController contact=TextEditingController();
  List id_key=[];
  List val=[];

  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('add_data');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      Map m=data as Map;
      id_key=m.keys.toList();
      val=m.values.toList();


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
      body: Column(children: [
        SizedBox(height: 10,),
        IconButton(onPressed: () {
        }, icon: Icon(Icons.contact_mail_outlined,size: 50,)),
        SizedBox(height: 10,),
        TextField(controller: user,decoration: InputDecoration(hintText: "Enter Email",labelText: "Enter Email")),
        SizedBox(height: 10,),
        TextField(controller: contact,decoration: InputDecoration(hintText: "Enter Password",labelText: "Enter Password")),
        SizedBox(height: 30,),
        TextButton(onPressed: () {

          for(int i=0; i<id_key.length;i++)
          {
            if(user.text==val[i]['email'] && contact.text==val[i]['password'])
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return dashboard(id_key[i],val[i]);
              },));
            }
          }

        }, child: Text("Submit")),
        TextButton(onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) {
              return alldata();
          },));
        }, child: Text("New Login"))
      ],),
    );
  }
}
