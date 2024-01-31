import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: verify(),));
}
class verify extends StatefulWidget {
  const verify({super.key});

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  String v_id="";
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController t1=TextEditingController();
  TextEditingController t2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP SEND & VERIFY..."),),
      body: Column(children: [
        SizedBox(height: 10),
        TextField(
          controller: t1,
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () async {

          await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: '+91${t1.text}',
            verificationCompleted: (PhoneAuthCredential credential) async {
              await auth.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                print('The provided phone number is not valid.');
              }
            },
            codeSent: (String verificationId, int? resendToken) {
                  v_id=verificationId;
                  setState(() {

                  });
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
        }, child: Text("Send OTP")),
        SizedBox(height: 10),
        TextField(
          controller: t2,
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () async {

          String smsCode = '${t2.text}';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: v_id, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);

        }, child: Text("Verify OTP")),
      ]),
    );
  }
}
