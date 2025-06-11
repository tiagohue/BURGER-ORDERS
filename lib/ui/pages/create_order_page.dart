import 'package:burger_orders/data/models/burger.dart';
import 'package:burger_orders/data/models/order.dart';
import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/ui/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  @override
  Widget build(BuildContext context) {
    final orderRepo = context.watch<OrderRepository>();
    final burgerRepo = context.watch<BurgerRepository>();

    final customerNameController = TextEditingController();

    @override
    // ignore: unused_element
    void dispose() {
      customerNameController.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Orders")),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: 10,
                children: [
                  TextField(
                    controller: customerNameController,
                    decoration: InputDecoration(labelText: "Custumer Name"),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Select burgers here:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: burgerRepo.burgers.length,
                    itemBuilder: (context, index) {
                      Burger burger = burgerRepo.burgers[index];

                      return ListTile(
                        title: Text(
                          burger.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: FittedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  debugPrint("Remove burger");
                                },
                                icon: Icon(Icons.remove),
                              ),
                              Text(
                                "amount",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: () {
                                  debugPrint("Add burger");
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              FittedBox(
                child: Row(
                  children: [
                    StandardButton(
                      text: "Cancel",
                      onPressed: () => Navigator.pop(context),
                    ),
                    StandardButton(
                      text: "Create",
                      onPressed: () {
                        final customerName = customerNameController.text.trim();

                        if (customerName.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Fill in all fields correctly!"),
                            ),
                          );

                          return;
                        }

                        final newOrder = Order(
                          date: DateTime.now().toIso8601String().split('T')[0],
                          customerName: customerName,
                        );

                        orderRepo.create(newOrder);

                        customerNameController.clear();

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
