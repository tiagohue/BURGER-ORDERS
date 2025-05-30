import 'package:app_de_pedidos_de_hamburguer/ui/widgets/standard_button.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Orders")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StandardButton(text: "See All", onPressed: () {}),
              StandardButton(text: "Create", onPressed: () {}),
              StandardButton(text: "Remove", onPressed: () {}),
              StandardButton(text: "Update", onPressed: () {}),
              StandardButton(text: "Delete", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
