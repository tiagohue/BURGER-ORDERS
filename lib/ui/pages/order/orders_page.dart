import 'package:burger_orders/data/models/burger.dart';
import 'package:burger_orders/data/models/order.dart';
import 'package:burger_orders/data/repositories/burger_repository.dart';
import 'package:burger_orders/data/repositories/order_repository.dart';
import 'package:burger_orders/providers/order_update_provider.dart';
import 'package:burger_orders/ui/pages/order/create_order_page.dart';
import 'package:burger_orders/ui/pages/order/update_order_page.dart';
import 'package:burger_orders/ui/utils.dart';
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
    final burgerRepo = context.watch<BurgerRepository>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: FittedBox(child: Text("Orders")),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: orderRepo.orders.length,
            itemBuilder: (_, index) {
              Order order = orderRepo.orders[index];

              String orderName = "${order.id} : ${order.customerName}";
              double totalPrice = 0;
              for (OrderBurger ob in order.orderBurgers) {
                Burger b = burgerRepo.retrieve(ob.burgerId);
                totalPrice += b.price * ob.quantity;
              }

              return ListTile(
                title: Text(
                  orderName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  "Total: ${Utils.formatReal(totalPrice)}",
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
                        Provider.of<OrderUpdateProvider>(
                          context,
                          listen: false,
                        ).setOrder(order);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                UpdateOrderPage(),
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
