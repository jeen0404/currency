

import 'package:currency/database/inti_sqllite.dart';
import 'package:currency/model/history_model.dart';
import 'package:sqflite/sqflite.dart';

class HistoryRepository extends InitSqlLite{

  Future<void> put(HistoryModel historyModel) async{
    await (await this.instance).insert("history",historyModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> delete(int id) async{
    return await (await this.instance).delete("history",where: "id=?",whereArgs: [id]);
  }

  Future<List<HistoryModel>> get getFromDatabase async{
    List<Map<String, dynamic>> maps =await (await this.instance).query('history');
    // Convert the List<Map<String, dynamic> into a List<currency>.
    return List.generate(maps.length, (i) {
      return HistoryModel(maps[i]['id'],maps[i]['username'],maps[i]['from_currency'],maps[i]['to_currency'],maps[i]['from_value'],maps[i]['to_value'],maps[i]['exchange_rate']);
    });
  }

  Future<List<HistoryModel>> getForUsername(username) async{
    List<Map<String, dynamic>> maps =await (await this.instance).query('history',where: "username=?",whereArgs: [username]);
    // Convert the List<Map<String, dynamic> into a List<currency>.
    return List.generate(maps.length, (i) {
      return HistoryModel(maps[i]['id'],maps[i]['username'],maps[i]['from_currency'],maps[i]['to_currency'],maps[i]['from_value'],maps[i]['to_value'],maps[i]['exchange_rate']);
    });
  }
}