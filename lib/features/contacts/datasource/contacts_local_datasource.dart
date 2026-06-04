import '../../../core/database/database_helper.dart';
import '../models/contact_model.dart';

class ContactsLocalDatasource {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertContact(ContactModel contact) async {
    final db = await dbHelper.database;

    return await db.insert('contacts', contact.toMap());
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await dbHelper.database;

    final result = await db.query('contacts', orderBy: 'name ASC');

    return result.map((e) => ContactModel.fromMap(e)).toList();
  }

  Future<int> updateContact(ContactModel contact) async {
    final db = await dbHelper.database;

    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    final db = await dbHelper.database;

    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
