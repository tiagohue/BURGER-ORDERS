import 'package:flutter/material.dart';

class BurguersPage extends StatefulWidget {
  const BurguersPage({super.key});

  @override
  State<StatefulWidget> createState() => _BurguersPageState();
}

class _BurguersPageState extends State<BurguersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Text("todo"));
  }
}
