import 'package:burger_orders/ui/widgets/add_button.dart';
import 'package:burger_orders/ui/widgets/standard_button.dart';
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
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (_, _) => ListTile(title: Text("burger")),
          ),
        ),
        floatingActionButton: AddButton(
          modelName: "Order",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: InputDecoration(labelText: "Name")),
              TextField(decoration: InputDecoration(labelText: "Ingredients")),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price"),
              ),
            ],
          ),
          onCreate: () {
            debugPrint("criar");
          },
        ),
      ),
    );
  }
}
