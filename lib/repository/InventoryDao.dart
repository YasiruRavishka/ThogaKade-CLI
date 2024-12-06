import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

import '../model/Vegetable.dart';

class InventoryDao {
  static final InventoryDao _instance = InventoryDao._internal();
  static final String filePath = '${Directory.current.path}/saves/inventory.db';
  final Database db;

  // Private constructor
  InventoryDao._internal() : db = sqlite3.open(filePath);

  factory InventoryDao() {
    return _instance;
  }

  void addVegetable(Vegetable veg) {
    try {
      createTable();
      final stmt = db.prepare('INSERT INTO inventory (name, price_per_kg, quantity, exp_date) VALUES (?, ?, ?, ?)');
      stmt.execute([veg.name,veg.pricePerKg, veg.availableQuantity, veg.expDate.toIso8601String().substring(0,10)]);
      stmt.dispose();
      print('Inventory saved successfully.');
    } catch (e) {
      print('Error saving inventory: $e');
    }
  }

  void removeVegetable(int id) {
    try {
      final stmt = db.prepare('DELETE FROM inventory WHERE id = ?');
      stmt.execute([id]);
      stmt.dispose();
      print('Inventory(id : $id) removed successfully.');
    } catch (e) {
      print('Error removing item from inventory: $e');
    }
  }

  void updateStock(int id, int qty) {
    try {
      final stmt = db.prepare('UPDATE inventory SET quantity = ? WHERE id = ?');
      stmt.execute([qty, id]);
      stmt.dispose();
      print('Inventory(id : $id, qty : $qty) updated successfully.');
    } catch (e) {
      print('Error updating inventory: $e');
    }
  }

  List<Vegetable> getAll() {
    List<Vegetable> result = [];
    for(final row in db.select('SELECT * FROM inventory')) {
      result.add(Vegetable.fromJson(row));
    }
    return result;
  }

  void createTable() {
    db.execute(
        '''
        CREATE TABLE IF NOT EXISTS inventory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price_per_kg REAL NOT NULL,
          quantity INTEGER NOT NULL,
          exp_date TEXT NOT NULL
        );
      '''
    );
    print('Table created successfully.');
  }
}