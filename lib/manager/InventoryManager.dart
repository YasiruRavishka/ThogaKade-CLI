import 'dart:io';

import '../model/Vegetable.dart';
import '../repository/InventoryDao.dart';

class InventoryManager {

  void add() {
    print("=" * 21);
    print(" Add a new vegetable ");
    print("=" * 21);

    stdout.write("Vegetable name - ");
    String? vegName = stdin.readLineSync();

    stdout.write("Price per KG - ");
    String? vegUPrice = stdin.readLineSync();

    stdout.write("Available Qty - ");
    String? vegStock = stdin.readLineSync();

    stdout.write("Expire date (YYYY-MM-DD) - ");
    String? vegExpDate = stdin.readLineSync();

    try {
      InventoryDao().addVegetable(new Vegetable(
          name: vegName!,
          pricePerKg: double.parse(vegUPrice!),
          availableQuantity: int.parse(vegStock!),
          expDate: DateTime.parse(vegExpDate!)));
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
  }

  void remove() {
    print("=" * 20);
    print(" Remove a vegetable ");
    print("=" * 20);

    stdout.write("Vegetable id - ");
    String? vegId = stdin.readLineSync();

    try {
      InventoryDao().removeVegetable(int.parse(vegId!));
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
  }

  void update() {
    print("=" * 14);
    print(" Update stock ");
    print("=" * 14);

    stdout.write("Vegetable id - ");
    String? vegId = stdin.readLineSync();

    stdout.write("New stock - ");
    String? vegStock = stdin.readLineSync();

    try {
      InventoryDao().updateStock(int.parse(vegId!), int.parse(vegStock!));
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
  }

  void viewAll() {
    print("=" * 16);
    print(" View inventory ");
    print("=" * 16);
    try {
      for(final veg in InventoryDao().getAll() ) {
        print(veg.toJson());
      }
    } catch (e) {
      print("Can not load data from database");
      sleep(Duration(seconds: 3));
    }
  }
}
