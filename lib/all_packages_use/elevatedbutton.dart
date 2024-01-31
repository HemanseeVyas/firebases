import 'package:enhanced_button/enhanced_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_elevated_button/loading_elevated_button.dart';

void main()
{
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: button(),));
}
class button extends StatefulWidget {
  const button({super.key});

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Packages"),),
      body: Column(children: [
        SizedBox(height: 40,),
        LoadingElevatedButton(
          isLoading: true,
          disabledWhileLoading: true,
          onPressed: () {
            print("Button clicked");
          },
          child: const Text('Default Loading'),
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: () {

        }, child: Text("Submit")),
        SizedBox(height: 10,),
        EnhancedButton(
          onPressed: () {},
          enhancedStyle: EnhancedButtonStyle(
            gradient: MaterialStateProperty.all(const LinearGradient(
                colors: [Colors.blue, Colors.red])),
          ),
          child: const Text('Button'),
        ),
        Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.yellow,
            size: 200,
          ),
        ),
        Center(
          child: LoadingAnimationWidget.dotsTriangle(
            // leftDotColor: const Color(0xFF1A1A3F),
            // rightDotColor: const Color(0xFFEA3799),
            size: 200,
            color: Colors.black
          ),
        )
      ]),
    );
  }
}
