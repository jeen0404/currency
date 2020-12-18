import 'package:currency/database/inti_sqllite.dart';
import 'package:currency/model/currency_model.dart';
import 'package:currency/network/invoke.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyRepository extends InitSqlLite{
  Invoke _invoke = Invoke();
  Future<List<CurrencyModel>> get getList async{
    // first request from network
    try{
      http.Response response=await _invoke.get("latest?");
      if(response.statusCode==200 && response.body.contains('rates')){
        Map<String,dynamic> body=jsonDecode(response.body);
        Map<String,dynamic> rates=body['rates'];
        List<CurrencyModel> list=rates.entries.map((e) => CurrencyModel(e.key,e.value.toDouble(),body['base'])).toList();
        await this.putList(list);
        return list;
      }
      else{
        return await this.getFromDatabase;
      }
    }catch(error){
      return await this.getFromDatabase;
    }
  }

  Future<CurrencyModel>  get(name) async{
    List<Map<String,dynamic>> currency=await  (await instance).query('currency',where:"name =?",whereArgs: [name]);
    print(currency);
    if(currency.length==1){
      return CurrencyModel(currency[0]['name'], currency[0]['value'],currency[0]['base']);
    }
    return null;
  }

  Future<List<CurrencyModel>> get getFromDatabase async{
     List<Map<String, dynamic>> maps =await (await this.instance).query('currency');

    // Convert the List<Map<String, dynamic> into a List<currency>.
    return List.generate(maps.length, (i) {
    return CurrencyModel(maps[i]['name'],maps[i]['value'],maps[i]['base']);
    });
  }

  Future<void> putList(List<CurrencyModel> list) async{
    Batch batch = (await this.instance).batch();
    list.forEach((CurrencyModel element) {
      batch.insert("currency", element.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    });
    await batch.commit(continueOnError:true);
  }




}