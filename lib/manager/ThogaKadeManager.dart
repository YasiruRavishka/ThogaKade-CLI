import 'dart:io';
import '../service/Validator.dart';

class ThogaKadeManager {
  static final ThogaKadeManager _instance = ThogaKadeManager._internal();
  static List<Map<String, int>> cart = [];

  // Private constructor
  ThogaKadeManager._internal();

  factory ThogaKadeManager() {
    return _instance;
  }

  void addToCart() {
    print("=" * 10);
    print(" Add Item ");
    print("=" * 10);

    stdout.write("Item id - ");
    String? itemId = stdin.readLineSync();

    stdout.write("qty - ");
    String? itemQty = stdin.readLineSync();

    try {
      int id = int.parse(itemId!);
      int qty = int.parse(itemQty!);
      if (Validator().is_valid_healthy_vegetable(id)) {
        cart.add({'itemId':id, 'itemQty': qty});
      } else {
        print("Expired item or invalid item id");
      }
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
  }

  void clearCart() {
    cart = [];
    print("cart cleared!");
  }
  
  void viewCart() {
    print("="*11);
    print(" View cart ");
    print("="*11);
    
    for (final val in cart) {
      print(val);
    }
  }

  void thogaKadeLogo() {
    print("=" * 54);
    print("  _____ _                       _  __         _      ");
    print(" |_   _| |__   ___   __ _  __ _| |/ /__ _  __| | ___ ");
    print("   | | | '_ \\ / _ \\ / _` |/ _` | ' // _` |/ _` |/ _ \\");
    print("   | | | | | | (_) | (_| | (_| | . \\ (_| | (_| |  __/");
    print("   |_| |_| |_|\\___/ \\__, |\\__,_|_|\\_\\__,_|\\__,_|\\___|");
    print("                    |___/                            ");
    print("=" * 54);
  }
}
