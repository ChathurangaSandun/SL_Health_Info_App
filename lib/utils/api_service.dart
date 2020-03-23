import 'package:dashboard/classes/corona_result.dart';
import 'package:dashboard/classes/stat-result.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  final govUrl = "http://hpb.health.gov.lk/api/get-current-statistical";
  final staticUrl =  "https://coronaapichathuranga.azurewebsites.net/api/CoronaStates/90";


  Future<Data> fetchCoronaData() async {
    final response = await get(govUrl);
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      print(jsonResult);
      final data =  CoronaResult.fromJson(jsonResult).data;
      return data;
    }

    return null;
  }

  Future<List<Records>> fetchCoronaStat() async {
    final response = await get(staticUrl);
    print( json.decode(response.body));
    if (response.statusCode == 200) {
      final jsonResult = json.decode(response.body);
      //print(jsonResult);
      final data =  StatResult.fromJson(jsonResult).records;
      return data;
    }

    return null;
  }
}


