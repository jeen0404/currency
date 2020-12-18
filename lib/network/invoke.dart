import 'package:http/http.dart' as http;


class Invoke{
  final String baseUrl ="http://data.fixer.io/api/";
  final String accessKey ="&&access_key=30ac9ff40e4d5c255f3c72654e519174";

  /// get request
  Future<http.Response> get(String path,{Map<String,String> headers=const{}}) async{
    return await http.get(baseUrl+path+accessKey,headers: headers);
  }
  /// post request
  Future<http.Response> post(String path,{Map<String,String> params=const{},Map<String,String> headers=const{}}) async{
    return await http.post(baseUrl+path+accessKey,body: params,headers: headers);
  }

}