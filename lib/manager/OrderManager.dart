import 'dart:io';

import '../manager/ThogaKadeManager.dart';
import '../model/Order.dart';
import '../repository/OrderDao.dart';

class OrderManager {

  void checkout(List<Map<String, int>> cart) {
    if (cart.isEmpty) {
      print("Empty cart.");
      sleep(Duration(seconds: 2));
      return;
    }
    print("=" * 10);
    print(" Checkout ");
    print("=" * 10);
    try {
      ThogaKadeManager().viewCart();

      stdout.write("Do you want to continue (y/n) - ");
      switch(stdin.readLineSync()!.toLowerCase()) {
        case 'y':
          OrderDao().placedOrder(cart);
          break;
        case 'n':
          break;
        default:
          throw Exception();
      }
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
  }

  void viewPreviousOrders() {
    print("=" * 22);
    print(" View previous orders ");
    print("=" * 22);
    try {
      for(final ord in OrderDao().getAll() ) {
        print(ord.toJson());
      }
    } catch (e) {
      print("Can not load data from database");
      sleep(Duration(seconds: 3));
    }
  }
}
