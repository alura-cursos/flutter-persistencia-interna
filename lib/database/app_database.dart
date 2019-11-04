import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
//    onDowngrade: onDatabaseDowngradeDelete,
  );
//  return getDatabasesPath().then((dbPath) {
//    final String path = join(dbPath, 'bytebank.db');
//    return openDatabase(path, onCreate: (db, version) {
//      db.execute('CREATE TABLE contacts('
//          'id INTEGER PRIMARY KEY, '
//          'name TEXT, '
//          'account_number INTEGER)');
//    }, version: 1,
////    onDowngrade: onDatabaseDowngradeDelete,
//    );
//  });
}

Future<int> save(Contact contact) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert('contacts', contactMap);
//  return getDatabase().then((db) {
//    final Map<String, dynamic> contactMap = Map();
//    contactMap['name'] = contact.name;
//    contactMap['account_number'] = contact.accountNumber;
//    return db.insert('contacts', contactMap);
//  });
}

Future<List<Contact>> findAll() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('contacts');
  final List<Contact> contacts = List();
  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
  return contacts;
//  return getDatabase().then((db) {
//    return db.query('contacts').then((maps) {
//      final List<Contact> contacts = List();
//      for (Map<String, dynamic> row in maps) {
//        final Contact contact = Contact(
//          row['id'],
//          row['name'],
//          row['account_number'],
//        );
//        contacts.add(contact);
//      }
//      return contacts;
//    });
//  });
}
