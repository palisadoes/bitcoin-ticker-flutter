import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'screen_price.dart';
import '../services/rest.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getExchangeRateData();
  }

  void getExchangeRateData() async {
    var data = await ExchangeRate().getExchangeRate();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PriceScreen(
            exchangeRateData: data,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
