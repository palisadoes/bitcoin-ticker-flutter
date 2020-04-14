import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../coin_data.dart';
import '../services/rest.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {

  PriceScreen();

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, double> coinData = {};

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            updateUIValues();
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            selectedCurrency = currenciesList[selectedIndex];
            updateUIValues();
          },
        );
      },
      children: dropdownItems,
    );
  }


  Column cardColumn(){
    List<CurrencyCard> currencyCards = [];
    for (String crypto in cryptoList){
      if (coinData != {}){
      double rate = coinData.containsKey(crypto) ? coinData[crypto] : 0;
      currencyCards.add(
          CurrencyCard(
              assetBase: crypto,
              rateBitcoin: rate,
              selectedCurrency: selectedCurrency),);}
    }
    return Column(
      children: currencyCards,
      crossAxisAlignment: CrossAxisAlignment.stretch,
    );
  }
  
  
  @override
  void initState()  {
    super.initState();
    updateUIValues();
  }
  

  Future<dynamic> updateUIValues() async {
    var data = await ExchangeRate().getExchangeRates(selectedCurrency);
    setState(() {
      coinData = data;
    },);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('₿ Bitcoin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          cardColumn(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    Key key,
    @required this.assetBase,
    @required this.rateBitcoin,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String assetBase;
  final double rateBitcoin;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $assetBase = ${rateBitcoin == null? 0 :rateBitcoin.toStringAsFixed(2)} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
