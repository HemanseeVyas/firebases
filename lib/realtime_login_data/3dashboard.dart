import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  String ?id_key;
  Map? val;
  dashboard(this.id_key, this.val);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('add_data');
  List id_key=[];
  List val=[];

  @override
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
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.val!['name']}"),),
      body: StreamBuilder(stream: starCountRef.onValue,
        builder: (context, snapshot) {

       return ListView.builder(itemCount: val.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("${widget.val!['name']}"),
              ),
            );
          },);
      },),
    );
  }
}
