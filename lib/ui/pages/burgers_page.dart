import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BurgersPage extends StatefulWidget {
  const BurgersPage({super.key});

  @override
  State<StatefulWidget> createState() => _BurgersPageState();
}

class _BurgersPageState extends State<BurgersPage> {
  @override
  Widget build(BuildContext context) {
    final repo = context.watch<BurgerRepository>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Burgers")),
        body: Center(
          child: ListView.builder(
            itemCount: repo.burgers.length,
            itemBuilder: (_, _) => ListTile(title: Text("burger")),
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
        floatingActionButton: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
