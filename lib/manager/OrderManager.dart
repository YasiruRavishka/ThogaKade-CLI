import 'dart:io';

import '../model/Order.dart';
import '../model/CartItem.dart';
import '../repository/AppRepository.dart';

class OrderManager {
  bool addToCart(int itemId, int itemQty) {
    try {
      AppRepository()
          .addToCart(CartItem.fromJson({'item_id': itemId, 'item_qty': itemQty}));
      return true;
    } catch (e) {
      print("Error!, addToCart()");
    }
    return false;
  }

  List<CartItem>? getAllCart() {
    return AppRepository().getCart();
  }

  bool checkout() {
    try {
      final List<CartItem> _cart = AppRepository().getCart()!;
      if (_cart.isEmpty) {
        throw Exception("Empty cart.");
      }
      double _total = 0;
      for (final val in _cart) {
        _total += AppRepository().searchVegetableById(val.itemId)!.pricePerKg *
            val.itemQty;
      }
      AppRepository().placedOrder(
          Order(items: _cart, total: _total, timestamp: DateTime.now()));
      return true;
    } catch (e) {
      print("Invalid!, $e.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
    return false;
  }

  List<Order>? getAllPreviousOrders() {
    try {
      return AppRepository().getAllOrder()!;
    } catch (e) {
      print("Can't load data from database");
      sleep(Duration(seconds: 3));
    }
    return null;
  }
}
