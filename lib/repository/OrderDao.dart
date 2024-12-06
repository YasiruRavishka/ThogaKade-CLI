import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

import '../model/Order.dart';

class OrderDao {
  static final OrderDao _instance = OrderDao._internal();
  static final String filePath = '${Directory.current.path}/saves/orders.db';
  final Database db;

  // Private constructor
  OrderDao._internal() : db = sqlite3.open(filePath);

  factory OrderDao() {
    return _instance;
  }

  void placedOrder(List<Map<String,int>> cart) {

  }

  List<Order> getAll() {
    List<Order> result = [];
    for(final row in db.select('SELECT * FROM orders')) {
      result.add(Order.fromJson(row));
    }
    return result;
  }

  void createTable() {
    db.execute(
        '''
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
      '''
    );
    print('Table created successfully.');
  }
}