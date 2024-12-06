import 'dart:io';

import './lib/manager/ThogaKadeManager.dart';
import './lib/manager/InventoryManager.dart';
import './lib/manager/OrderManager.dart';

void main() {
  while (true) {
    homepage();
  }
}

void homepage() {
  clearConsole();
  ThogaKadeManager().thogaKadeLogo();
  print("01. Place an order");
  print("02. Inventory Management");
  print("03. View previous orders");
  try {
    stdout.write("Please, select your option - ");
    String? input = stdin.readLineSync();
    switch (int.parse(input!)) {
      case 1:
        orderManagement();
        break;
      case 2:
        inventoryManagement();
        break;
      case 3:
        OrderManager().viewPreviousOrders();
        break;
      default:
        print("Please, enter the valid number.");
        sleep(Duration(seconds: 2));
    }
  } catch (e) {
    print("Invalid input!");
    sleep(Duration(seconds: 2));
  }
}

void orderManagement() {
  clearConsole();
  print("=" * 16);
  print(" Place an order ");
  print("=" * 16);
  print("01. Add to cart");
  print("02. Clear cart");
  print("03. Checkout");
  print("04. Back to the main menu");
  try {
    stdout.write("Please, select your option - ");
    String? input = stdin.readLineSync();
    switch (int.parse(input!)) {
      case 1:
        ThogaKadeManager().addToCart();
        break;
      case 2:
        ThogaKadeManager().clearCart();
        break;
      case 3:
        OrderManager().checkout(ThogaKadeManager.cart);
        break;
      case 4:
        break;
      default:
        print("Please, enter the valid number.");
        return;
    }
  } catch (e) {
    print("Invalid input!");
    sleep(Duration(seconds: 2));
  }
}

void inventoryManagement() {
  clearConsole();
  print("=" * 22);
  print(" Inventory Management ");
  print("=" * 22);
  print("01. Add vegetable");
  print("02. Update stock");
  print("03. Remove vegetable");
  print("04. View inventory");
  print("05. Back to the main menu");
  try {
    stdout.write("Please, select your option - ");
    String? input = stdin.readLineSync();
    switch (int.parse(input!)) {
      case 1:
        InventoryManager().add();
        break;
      case 2:
        InventoryManager().update();
        break;
      case 3:
        InventoryManager().remove();
        break;
      case 4:
        InventoryManager().viewAll();
        break;
      case 5:
        break;
      default:
        print("Please, enter the valid number.");
    }
  } catch (e) {
    print("Invalid input!");
    sleep(Duration(seconds: 2));
  }
}

void clearConsole() {
  if (Platform.isWindows) {
    Process.runSync('cls', [], runInShell: true);
  } else {
    Process.runSync('clear', [], runInShell: true);
  }
}
