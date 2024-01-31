import 'package:firebases/realmcalss.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

void main()
{
      runApp(MaterialApp(debugShowCheckedModeBanner: false,home: data(),));
}
class data extends StatefulWidget {
  const data({super.key});

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {

  // late Realm realm;

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // final config = Configuration.local([Car.name, Car.contact]);
    // realm = Realm(config);
    //
    // realm.write(() {
    //   print("hello");
    //   // realm.add("heyyuu");
    // });
    //
    // String name="";
    // String contact="";
    // var myCar = Car(config);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Realm_database"),),
      body: Column(children: [
        TextField(controller: t1,),
        TextField(controller: t2,),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {

        }, child: Text("Submit"))
      ],),
    );
  }
}
