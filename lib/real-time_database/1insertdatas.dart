import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '2viewdatas.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
    runApp(MaterialApp(debugShowCheckedModeBanner: false,home: realtime(),));
}
class realtime extends StatefulWidget {
  String ? id_key;
  Map? val;
  realtime([this.id_key, this.val]);

  @override
  State<realtime> createState() => _realtimeState();
}

class _realtimeState extends State<realtime> {

  TextEditingController name=TextEditingController();
  TextEditingController contact=TextEditingController();
  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  TextEditingController t3=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.id_key!=null)
      {
          name.text=widget.val!['name'];
          contact.text=widget.val!['contact'];
          t1.text=widget.val!['Marks']['sub1'];
          t2.text=widget.val!['Marks']['sub2'];
          t3.text=widget.val!['Marks']['sub3'];
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Real-Time-Dtabase"),),

      body: Column(children: [
        SizedBox(height: 10,),
        TextField(controller: name,),
        TextField(controller: contact,),
        TextField(controller: t1,),
        TextField(controller: t2,),
        TextField(controller: t3,),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () async {

          if(widget.id_key!=null)
            {
              DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").child(widget.id_key!);

              await ref.update({
                "name": "${name.text}",
                "contact": "${contact.text}",
                "Marks": {
                  "sub1": "${t1.text}",
                  "sub2": "${t2.text}",
                  "sub3": "${t3.text}",
                }
              });
            }
          else
            {
                  DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").push();

                  await ref.set({
                    "name": "${name.text}",
                    "contact": "${contact.text}",
                    "Marks": {
                      "sub1": "${t1.text}",
                      "sub2": "${t2.text}",
                      "sub3": "${t3.text}",
                    }
                  });
            }

          // DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").push();
          //
          // await ref.set({
          //   "name": "${name.text}",
          //   "contact": "${contact.text}",
          //   "Marks": {
          //     "sub1": "${t1.text}",
          //     "sub2": "${t2.text}",
          //     "sub3": "${t3.text}",
          //   }
          // });

        }, child: Text("Submit")),
        ElevatedButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
              return view();
          },));
        }, child: Text("View"))
      ]),
    );
  }
}
