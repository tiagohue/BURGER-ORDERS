import 'package:burger_orders/data/models/order.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/ui/pages/create_order_page.dart';
import 'package:burger_orders/ui/widgets/add_button.dart';
import 'package:burger_orders/ui/widgets/standard_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final orderRepo = context.watch<OrderRepository>();

    final customerNameController = TextEditingController();

    final updateCustomerNameController = TextEditingController();

    @override
    // ignore: unused_element
    void dispose() {
      customerNameController.dispose();
      super.dispose();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Orders")),
        body: Center(
          child: ListView.builder(
            itemCount: orderRepo.orders.length,
            itemBuilder: (_, index) {
              Order order = orderRepo.orders[index];

              String orderName = "${order.id} : ${order.customerName}";
              return ListTile(
                title: Text(
                  orderName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  "add total price",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // remove button
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => StandardDialog(
                            title: "Delete Order",
                            content: Text("Are you sure to delete $orderName?"),
                            onConfirm: () {
                              orderRepo.delete(order.id!);

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Order deleted!")),
                              );
                            },
                            confirmText: "Delete",
                          ),
                        );
                      },
                      icon: Icon(MaterialCommunityIcons.text_box_minus_outline),
                    ),
                    // edit button
                    IconButton(
                      onPressed: () {
                        updateCustomerNameController.text = order.customerName;

                        showDialog(
                          context: context,
                          builder: (_) => StandardDialog(
                            title: "Update Order",
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: updateCustomerNameController,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                  ),
                                ),
                                Text("todo: add burger list here "),
                              ],
                            ),
                            onConfirm: () {
                              final customerName = updateCustomerNameController
                                  .text
                                  .trim();

                              if (customerName.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Fill in all fields correctly!",
                                    ),
                                  ),
                                );

                                return;
                              }

                              final newOrder = Order(
                                id: order.id,
                                customerName: customerName,
                                date: order.date,
                              );

                              orderRepo.update(newOrder);

                              Navigator.pop(context);
                            },
                            confirmText: "Update",
                          ),
                        );
                      },
                      icon: Icon(MaterialIcons.edit),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: AddButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateOrderPage(),
            ),
          ),
        ),
      ),
    );
  }
}
