import 'package:flutter_sqlite/contact.dart';
import 'package:flutter_sqlite/databaseprovider.dart';
import 'package:sqflite/sqflite.dart';

class ContactDataAccess {
  getAll() async {
    final db = await DatabaseProvider.db.database;
    var results = await db.query("Contact");
    var list = results.map((e) => Contact.fromMap(e)).toList();
    return list;
  }

  getByID(int id) async {
    final db = await DatabaseProvider.db.database;
    var results = await db.query("Contact", where: "id = ?", whereArgs: [id]);
    var contact = results.isNotEmpty ? Contact.fromMap(results.first) : null;
    return contact;
  }

  insert(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var result = await db.insert(
        "Contact",
        {
          "name": contact.name,
          "email": contact.email,
          "phone": contact.phone,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  update(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var result = await db.update("Contact", contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
    return result;
  }

  delete(Contact contact) async {
    final db = await DatabaseProvider.db.database;
    var result = await db.delete("Contact", where: "id = ?", whereArgs: [id]);
    return result;
  }

  deleteAll() async {
    final db = await DatabaseProvider.db.database;
    var result = await db.delete("Contact");
    return result;
  }
}
