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
  final customerNameController = TextEditingController();
  final Map<int, int> burgerQuantities = {};

  @override
  void dispose() {
    customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderRepo = context.watch<OrderRepository>();
    final burgerRepo = context.watch<BurgerRepository>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(child: Text("Create Order")),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                      int quantity = burgerQuantities[burger.id] ?? 0;

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
                                  setState(() {
                                    if (quantity > 0) {
                                      burgerQuantities[burger.id!] =
                                          quantity - 1;
                                    } else {
                                      burgerQuantities[burger.id!] = 0;
                                    }
                                  });
                                },
                                icon: Icon(Icons.remove),
                              ),
                              Text(
                                quantity.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    burgerQuantities[burger.id!] = quantity + 1;
                                  });
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

                        if (customerName.isEmpty ||
                            burgerQuantities.values.every((q) => q == 0)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Fill in all fields correctly!"),
                            ),
                          );

                          return;
                        }

                        List<OrderBurger> orderBurgers = [];
                        burgerQuantities.forEach((burgerId, quantity) {
                          if (quantity > 0) {
                            orderBurgers.add(
                              OrderBurger(
                                burgerId: burgerId,
                                quantity: quantity,
                              ),
                            );
                          }
                        });

                        final newOrder = Order(
                          date: DateTime.now().toIso8601String().split('T')[0],
                          customerName: customerName,
                          orderBurgers: orderBurgers,
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
