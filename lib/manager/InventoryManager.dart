import 'dart:io';

import '../model/Vegetable.dart';
import '../repository/AppRepository.dart';

class InventoryManager {

  bool add(String name, double uPrice, int stock, DateTime expDate) {
    try {
      AppRepository().addVegetable(new Vegetable(
          name: name,
          pricePerKg: uPrice,
          availableQuantity: stock,
          expDate: expDate));
      return true;
    } catch (e) {
      print("Unable to update db.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
    return false;
  }

  bool remove(int id) {
    try {
      AppRepository().removeVegetable(id);
      return true;
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
    return false;
  }

  bool update(int id, int stock) {
    try {
      AppRepository().updateStock(id, stock);
      return true;
    } catch (e) {
      print("Invalid argument.\nPlease, try again.");
      sleep(Duration(seconds: 3));
    }
    return false;
  }

  List<Vegetable>? getAll() {
    try {
      return AppRepository().getAllVegetable();
    } catch (e) {
      print("Can't load data from inventory");
      sleep(Duration(seconds: 3));
    }
    return null;
  }
}
