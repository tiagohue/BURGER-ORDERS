import 'package:burger_orders/data/models/order.dart';
import 'package:flutter/material.dart';

class OrderUpdateProvider extends ChangeNotifier {
  late Order orderToUpdate;

  void setOrder(Order order) {
    orderToUpdate = order;

    notifyListeners();
  }
}
