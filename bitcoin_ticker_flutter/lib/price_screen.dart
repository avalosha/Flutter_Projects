import 'dart:io' show Platform;
import 'package:bitcoin_ticker_flutter/crypto_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String selectedCurrency;
  Map<String, double> cryptoMap;
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    getCryptoData(currenciesList.first);
  }

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> items = [];
    /*
    for (int i = 0; i < currenciesList.length; i++) {
      String coin = '${currenciesList[i]}';
      DropdownMenuItem item = DropdownMenuItem(
        child: Text(coin),
        value: coin,
      );
      items.add(item);
    }
    */
    for (String currency in currenciesList) {
      items.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) {
        setState(() async {
          getCryptoData(value);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> items = [];
    for (String currency in currenciesList) {
      items.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) async {
        getCryptoData(currenciesList[selectedIndex]);
      },
      children: items,
    );
  }

  void getCryptoData(String currency) async {
    isWaiting = true;
    try {
      selectedCurrency = currency;
      var cryptoData = await coinData.makeMultipleRequests(selectedCurrency);
      isWaiting = false;
      setState(() {
        cryptoMap = cryptoData;
        print('Data $cryptoMap');
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                crypto: 'BTC',
                change: isWaiting ? '?' : cryptoMap["BTC"].toInt(),
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                crypto: 'ETH',
                change: isWaiting ? '?' : cryptoMap["ETH"].toInt(),
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                crypto: 'LTC',
                change: isWaiting ? '?' : cryptoMap["LTC"].toInt(),
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
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
