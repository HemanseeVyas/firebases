import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebases/firebase_curd_op/1insert.dart';
import 'package:flutter/material.dart';

class views extends StatefulWidget {
  const views({super.key});

  @override
  State<views> createState() => _viewsState();
}

class _viewsState extends State<views> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  title: Text(data['name']),
                  subtitle: Text(data['contact']),
                  trailing: Wrap(children: [
                    IconButton(onPressed: () {

                      users
                          .doc(document.id)
                          .delete()
                          .then((value) => print("User Deleted"))
                          .catchError((error) => print("Failed to delete user: $error"));

                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return adds(document.id,data);
                      },));
                    }, icon: Icon(Icons.edit)),
                  ]),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
