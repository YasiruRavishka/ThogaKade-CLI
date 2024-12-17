import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

import '../model/Vegetable.dart';
import '../model/Order.dart';
import '../model/CartItem.dart';

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();
  static final String filePath = '${Directory.current.path}/app.db';
  static List<CartItem> __cart = [];
  final Database db;

  // Private constructor
  AppRepository._internal() : db = sqlite3.open(filePath) {
    _createTable();
  }

  factory AppRepository() {
    return _instance;
  }

  // -------------------- Inventory Handling --------------------
  void addVegetable(Vegetable veg) {
    try {
      final stmt = db.prepare(
          'INSERT INTO inventory (name, price_per_kg, quantity, exp_date) VALUES (?, ?, ?, ?)');
      stmt.execute([
        veg.name,
        veg.pricePerKg,
        veg.availableQuantity,
        veg.expDate.toIso8601String().substring(0, 10)
      ]);
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
      print('Inventory(id : $id) updated successfully.');
    } catch (e) {
      print('Error updating inventory: $e');
    }
  }

  Vegetable? searchVegetableById(int id) {
    try {
      for (final row
          in db.select('SELECT * FROM inventory WHERE id = ?', [id])) {
        return Vegetable.fromJson(row);
      }
    } catch (e) {
      print('Error in searchVegetableById(vegId): $e');
    }
    return null;
  }

  List<Vegetable> getAllVegetable() {
    List<Vegetable> result = [];
    for (final row in db.select('SELECT * FROM inventory')) {
      result.add(Vegetable.fromJson(row));
    }
    return result;
  }

  // -------------------- Order Handling --------------------
  void addToCart(CartItem item) {
    __cart.add(item);
    print("Cart item added.");
  }

  List<CartItem>? getCart() {
    return __cart.isEmpty ? null : __cart;
  }

  void clearCart() {
    __cart = [];
  }

  void placedOrder(Order order) {
    db.execute('BEGIN TRANSACTION');
    try {
      db.execute('INSERT INTO orders (id, total, timestamp) VALUES (?, ?, ?)',
          [order.id, order.total, order.timestamp.toIso8601String()]);
      for (final item in order.items) {
        db.execute(
            'INSERT INTO order_items (order_id, inventory_id, qty) VALUES (?, ?, ?)',
            [
              db.select('SELECT seq FROM sqlite_sequence WHERE name = ?', ['orders']).first['seq'] as int,
              item.itemId,
              item.itemQty
            ]);
        db.execute('UPDATE inventory SET quantity = quantity - ? WHERE id = ?', [item.itemQty, item.itemId]);
      }
      db.execute('COMMIT');
      clearCart();
      print('Order placed successfully.');
    } catch (e) {
      db.execute('ROLLBACK;');
      print('Error saving inventory: $e');
    }
  }

  List<Order>? getAllOrder() {
    List<Order> result = [];
    try {
      for (final row in db.select('SELECT * FROM orders')) {
        result.add(Order.fromJson(row));
      }
      return result;
    } catch (e) {
      print("Data fetching error.");
    }
    return null;
  }

  // -------------------- DB tables create query --------------------
  void _createTable() {
    db.execute('''
        CREATE TABLE IF NOT EXISTS inventory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          price_per_kg REAL NOT NULL,
          quantity INTEGER NOT NULL,
          exp_date TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          total REAL NOT NULL,
          timestamp TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS order_items (
          order_id INTEGER NOT NULL,
          inventory_id INTEGER NOT NULL,
          qty INTEGER NOT NULL,
          PRIMARY KEY (order_id,inventory_id),
          FOREIGN KEY (order_id) REFERENCES orders(id),     
          FOREIGN KEY (inventory_id) REFERENCES inventory(id)
        );
        ''');
    print('DB created successfully.');
  }
}
