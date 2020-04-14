import 'package:http/http.dart' as http;
import 'dart:convert';
import '../coin_data.dart';

const apiKey = '4018B4C5-9E16-49C2-BCA9-B6B4157A3519';
const openWeatherMapURL = 'https://rest.coinapi.io/v1/exchangerate';

class ExchangeRate {

  Future<dynamic> getApiExchangeRates(String _currency) async {
    Map<String, double> data = {};
    for (String exchange in cryptoList){
      String url = '$openWeatherMapURL/$exchange/$_currency?apikey=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(url);
      double price = await networkHelper.getPrice();
      data[exchange] = price;
      print(url);
    }
    print(data);
    return data;
  }

  Future<dynamic> getExchangeRates(String _currency) async {
    Map<String, double> data = {};
    double count = 0;
    for (String exchange in cryptoList){
      data[exchange] = count++;
    }
    print(data);
    return data;
  }


}


class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getPrice() async {
    double price;
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      price = result['price'];
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return price;
  }
}
