import 'package:flutter/material.dart';

class Button extends StatefulWidget {

 final String text;

 const Button({
   super.key,
   required this.text
});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: (){
        print("Button clicked");
      },
      child: Row(
        children: [
          Text("Click me ${widget.text}"),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
