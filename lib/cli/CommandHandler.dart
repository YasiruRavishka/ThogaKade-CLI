import 'dart:io';

import '../model/CartItem.dart';
import '../service/Validator.dart';
import '../manager/ThogaKadeManager.dart';
import '../manager/InventoryManager.dart';
import '../manager/OrderManager.dart';

class CommandHandler {
  void homepage() {
    homepageLoop:
    while (true) {
      _clearConsole();
      ThogaKadeManager().thogaKadeLogo();
      print("01. Place an order");
      print("02. Inventory Management");
      print("03. View previous orders");
      print("04. Exit");
      try {
        stdout.write("Please, select your option - ");
        switch (int.parse(stdin.readLineSync()!)) {
          case 1:
            orderManagement();
            break;
          case 2:
            inventoryManagement();
            break;
          case 3:
            print("=" * 22);
            print(" View previous orders ");
            print("=" * 22);
            try {
              for (final val in OrderManager().getAllPreviousOrders()!) {
                print(val.toJson());
              }
            } catch (e) {
              print("     Empty orders     ");
              print("=" * 22);
            }
            break;
          case 4:
            stdout.write("Do you want to exit(y/n) : ");
            if(stdin.readLineSync()!.toLowerCase() == 'y') {
              break homepageLoop;
            }
          default:
            throw Exception("Please, enter the valid number.");
        }
      } catch (e) {
        print("Invalid input!, $e");
        sleep(Duration(seconds: 2));
      }
    }
  }

  void orderManagement() {
    orderManagementLoop:
    while (true) {
      _clearConsole();
      print("=" * 16);
      print(" Place an order ");
      print("=" * 16 + "\n");

      viewCart();

      print("01. Add to cart");
      print("02. Clear cart");
      print("03. Checkout");
      print("04. Back to the main menu");
      try {
        stdout.write("Please, select your option - ");
        switch (int.parse(stdin.readLineSync()!)) {
          case 1:
            print("=" * 10);
            print(" Add Item ");
            print("=" * 10);

            try {
              stdout.write("Item id - ");
              int? itemId = int.tryParse(stdin.readLineSync()!);

              stdout.write("qty - ");
              int? itemQty = int.tryParse(stdin.readLineSync()!);

              if (Validator().is_valid_cart_item(itemId!, itemQty!)) {
                OrderManager().addToCart(itemId, itemQty);
              } else {
                print("Expired item or invalid item id");
              }
            } catch (e) {
              print("Invalid argument.\nPlease, try again.");
              sleep(Duration(seconds: 3));
            }
            break;
          case 2:
            stdout.write("Do you want to clear this cart(y/n) : ");
            if(stdin.readLineSync()!.toLowerCase() == 'y') {

            }
            break;
          case 3:
            stdout.write("Do you want to checkout(y/n) : ");
            if(stdin.readLineSync()!.toLowerCase() == 'y') {
              print("=" * 10);
              print(" Checkout ");
              print("=" * 10);
              OrderManager().checkout();
            }
            break;
          case 4:
            break orderManagementLoop;
          default:
            print("Please, enter the valid number.");
            sleep(Duration(seconds: 2));
        }
      } catch (e) {
        print("Invalid input!");
        sleep(Duration(seconds: 2));
      }
    }
  }

  void viewCart() {
    try {
      print("="*11);
      print(" View cart ");
      print("=" * 11);

      for (final val in OrderManager().getAllCart()!) {
        print(val.toJson());
      }
    } catch (e) {
      print("=" * 10);
      print("Empty cart");
      print("=" * 10);
    } finally {
      print("\n\n");
    }
  }

  void inventoryManagement() {
    inventoryManagementLoop:
    while (true) {
      _clearConsole();
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
        switch (int.parse(stdin.readLineSync()!)) {
          case 1:
            print("=" * 21);
            print(" Add a new vegetable ");
            print("=" * 21);
            try {
              stdout.write("Vegetable name - ");
              String vegName = stdin.readLineSync()!;

              stdout.write("Price per KG - ");
              double? vegUPrice = double.tryParse(stdin.readLineSync()!);

              stdout.write("Available Qty - ");
              int? vegStock = int.tryParse(stdin.readLineSync()!);

              stdout.write("Expire date (YYYY-MM-DD) - ");
              DateTime? vegExpDate = DateTime.tryParse(stdin.readLineSync()!);

              InventoryManager().add(vegName, vegUPrice!, vegStock!, vegExpDate!);
            } catch (e) {
              print("Invalid input, try again!");
              sleep(Duration(seconds: 3));
            }
            break;
          case 2:
            print("=" * 14);
            print(" Update stock ");
            print("=" * 14);

            try {
              stdout.write("Vegetable id - ");
              int? vegId = int.tryParse(stdin.readLineSync()!);

              stdout.write("New stock - ");
              int? vegStock = int.tryParse(stdin.readLineSync()!);

              InventoryManager().update(vegId!, vegStock!);
            } catch (e) {
              print("Invalid input, try again!");
              sleep(Duration(seconds: 3));
            }
            break;
          case 3:
            print("=" * 20);
            print(" Remove a vegetable ");
            print("=" * 20);
            try {
              stdout.write("Vegetable id - ");
              int? vegId = int.tryParse(stdin.readLineSync()!);

              InventoryManager().remove(vegId!);
            } catch (e) {
              print("Invalid input, try again!");
              sleep(Duration(seconds: 3));
            }
            break;
          case 4:
            print("=" * 16);
            print(" View inventory ");
            print("=" * 16);
            try {
              for (final veg in InventoryManager().getAll()!) {
                print(veg.toJson());
              }
            } catch (e) {
              print("Can not load data from repo");
              sleep(Duration(seconds: 3));
            }
            break;
          case 5:
            break inventoryManagementLoop;
          default:
            print("Please, enter the valid number.");
            sleep(Duration(seconds: 2));
        }
      } catch (e) {
        print("Invalid input!");
        sleep(Duration(seconds: 2));
      }
    }
  }

  void _clearConsole() {
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }
}
