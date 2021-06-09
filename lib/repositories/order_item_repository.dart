import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webox/models/order_item_model.dart';

class OrderItemRepository {
  static Database _database;

  static Future initialize() async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'shopping_cart_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE order_items(amount INTEGER NOT NULL, laptop_id TEXT NOT NULL UNIQUE)',
          );
        },
        version: 1,
      );
    }
  }

  static Future insert(OrderItemModel orderItem) async {
    await _database.insert(
      'order_items',
      orderItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<OrderItemModel>> getAll() async {
    final orderItems = await _database.query('order_items');

    return List<OrderItemModel>.generate(
      orderItems.length,
      (index) {
        return OrderItemModel(
          orderItems[index]['amount'] as int,
          orderItems[index]['laptop_id'] as String,
        );
      },
    );
  }

  static Future update(OrderItemModel orderItem) async {
    await _database.update(
      'order_items',
      orderItem.toMap(),
      where: 'laptop_id = ?',
      whereArgs: [
        orderItem.laptopId,
      ],
    );
  }

  static Future delete(String laptopId) async {
    await _database.delete(
      'order_items',
      where: 'laptop_id = ?',
      whereArgs: [
        laptopId,
      ],
    );
  }

  static Future<bool> isInCart(String laptopId) async {
    var entries = await _database.query(
      'order_items',
      where: 'laptop_id = ?',
      whereArgs: [
        laptopId,
      ],
    );
    return entries.isNotEmpty && entries.length == 1;
  }

  static Future truncate() async {
    var records = await getAll();
    for (var record in records) {
      await delete(record.laptopId);
    }
  }
}
