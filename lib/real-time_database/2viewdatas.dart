import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '1insertdatas.dart';

class view extends StatefulWidget {
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {

  List id_key=[];
  List val=[];
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('cdmi');

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   starCountRef.onValue.listen((DatabaseEvent event) {
  //     final data = event.snapshot.value;
  //
  //     Map m=data as Map;
  //     id_key=m.keys.toList();
  //     val=m.values.toList();
  //
  //
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View_Data"),),
      body: StreamBuilder(stream: starCountRef.onValue,
        builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active)
              {
                    final data=snapshot.data!.snapshot.value;

                    Map m=data as Map;
                    id_key=m.keys.toList();
                    val=m.values.toList();
                    print(val);
              }
            return ListView.builder(
              itemCount: val.length,
              itemBuilder: (context, index) {
              return Card(
                // srkho data map ma mlvo joiye aetle int to string ni error ny avse
                child: ListTile(
               title: Text("${val[index]['name']}"),
                  trailing: Wrap(children: [
                    IconButton(onPressed: () {

                      DatabaseReference ref = FirebaseDatabase.instance.ref("cdmi").child(id_key[index]);
                      ref.remove();
                      // DatabaseReference

                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return realtime(id_key[index],val[index]);
                      },));
                    }, icon: Icon(Icons.edit))
                  ]),
                )
              );
            },);
      },),
    );
  }
}
