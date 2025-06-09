import 'package:app_de_pedidos_de_hamburguer/data/repositories/burguer_repository.dart';
import 'package:app_de_pedidos_de_hamburguer/ui/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BurguersPage extends StatefulWidget {
  const BurguersPage({super.key});

  @override
  State<StatefulWidget> createState() => _BurguersPageState();
}

class _BurguersPageState extends State<BurguersPage> {
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<BurguerRepository>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Burguers")),
        body: Center(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (_, _) => ListTile(title: Text("burguer")),
          ),
          /*child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StandardButton(text: "See All", onPressed: () {}),
              StandardButton(text: "Create", onPressed: () {}),
              StandardButton(text: "Remove", onPressed: () {}),
              StandardButton(text: "Update", onPressed: () {}),
              StandardButton(text: "Delete", onPressed: () {}),
            ],
          ),*/
        ),
      ),
    );
  }
}
