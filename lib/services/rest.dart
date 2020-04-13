import 'networking.dart';

const apiKey = '4018B4C5-9E16-49C2-BCA9-B6B4157A3519';
const openWeatherMapURL = 'https://rest.coinapi.io/v1/exchangerate/BTC';

class ExchangeRate {
  Future<dynamic> getExchangeRate(String _currency) async {
    NetworkHelper networkHelper =
        NetworkHelper('$openWeatherMapURL/$_currency?apikey=$apiKey');
    var data = await networkHelper.getData();
    return data;
  }
}