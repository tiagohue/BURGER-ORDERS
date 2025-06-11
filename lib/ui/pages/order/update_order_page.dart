import 'package:burger_orders/data/models/burger.dart';
import 'package:burger_orders/data/models/order.dart';
import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/providers/order_update_provider.dart';
import 'package:burger_orders/ui/widgets/standard_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateOrderPage extends StatefulWidget {
  const UpdateOrderPage({super.key});

  @override
  State<StatefulWidget> createState() => _UpdateOrderPageState();
}

class _UpdateOrderPageState extends State<UpdateOrderPage> {
  final Map<int, int> burgerQuantities = {};
  final customerNameController = TextEditingController();

  @override
  void initState() {
    super.initState;
    final orderToUpdate = Provider.of<OrderUpdateProvider>(
      context,
      listen: false,
    ).orderToUpdate;

    customerNameController.text = orderToUpdate.customerName;
    for (OrderBurger orderBurger in orderToUpdate.orderBurgers) {
      burgerQuantities[orderBurger.burgerId] = orderBurger.quantity;
    }
  }

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
          title: FittedBox(child: Text("Update Order")),
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
                    "Change burgers here:",
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
                      text: "Update",
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

                        final updateOrder = Order(
                          id: Provider.of<OrderUpdateProvider>(
                            context,
                            listen: false,
                          ).orderToUpdate.id!,
                          date: DateTime.now().toIso8601String().split('T')[0],
                          customerName: customerName,
                          orderBurgers: orderBurgers,
                        );

                        orderRepo.update(updateOrder);

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
