import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class InitSqlLite{

   Future<Database> get instance async{
    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
        join(await getDatabasesPath(), 'doggie_database.db'),
    // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
    // Run the CREATE TABLE statement on the database.
     db.execute(
    "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT UNIQUE, password Text)",
    );
     db.execute("""
         CREATE TABLE history(id INTEGER PRIMARY KEY, username TEXT , from_currency TEXT,to_currency TEXT,from_value REAL,to_value REAL,exchange_rate REAL)
         """);
     db.execute("""
     CREATE TABLE currency(id INTEGER PRIMARY KEY, name TEXT UNIQUE, base TEXT,value REAL)
     """);
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
    );
  }

}