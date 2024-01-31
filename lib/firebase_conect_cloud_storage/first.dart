import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebases/firebase_conect_cloud_storage/second.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
      runApp(MaterialApp(debugShowCheckedModeBanner: false,home: connect_file(),));
}
class connect_file extends StatefulWidget {
  const connect_file({super.key});

  @override
  State<connect_file> createState() => _connect_fileState();
}

class _connect_fileState extends State<connect_file> {


  Future<UserCredential> signInWithGoogle() async {


    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null)
      {
        return Future.error('Failed to obtain Google authentication details');
      }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    if (googleAuth == null && googleAuth!.accessToken == null && googleAuth!.idToken == null) {
      // Handle the case where either accessToken or idToken is null
      return Future.error('Failed to obtain Google authentication details');
    }
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  // run krvathi error ave tyre minsdkversion 19 krvu
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      String name = user.displayName.toString();
      String email = user.email.toString();


      WidgetsBinding.instance.addPostFrameCallback((_){

        // Add Your Code here.

        //error -setState() or markNeedsBuild() called during build.
        //widgetsBinding no mukiye to error aavse setstate vali e error ne google ma mukvi tyre widgetsBinding valu mukvu
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return logindata(name, email);
        },));

      });


    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase_Login"),),
      body: Column(
        children: [
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {

              signInWithGoogle().then((value) {

                // if(value!=null && value.user!=null)
                //   {
                    String name,email;
                    name=value.user!.displayName.toString();
                    email=value.user!.email.toString();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return logindata(name,email);
                    },));
                  // }

              });
          }, child: Text("Submit"))
        ],
      ),
    );
  }
}
