import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final String text;

  const StandardButton({super.key, required this.text});

  /*@override
  State<StatefulWidget> createState() => _StandardButtonState();*/

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        fixedSize: Size(200, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(
            //color: Colors.black,
            width: 2,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "NewRocker",
          //color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}

/*class _StandardButtonState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 5),
        ),
      ),

      child: Text(
        widget.text,
        style: TextStyle(
          fontFamily: "NewRocker",
          color: Colors.black,
          fontSize: 30,
        ),
      ),
    );
  }
}*/
