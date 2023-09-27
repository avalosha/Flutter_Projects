import 'dart:ffi';

import 'package:bitcoin_ticker_flutter/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String apikey = '083B8973-9349-4E1A-85A6-8D7B0A2E4986';

class CoinData {
  String currency;

  CoinData();

  Future<dynamic> getCoinData(String currency) async {
    NetworkHelper networkHelper = NetworkHelper();
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/BTC/$currency',
        {'apikey': apikey});

    var coinData = await networkHelper.getData(url);
    return coinData;
  }

  Future<dynamic> makeMultipleRequests(String currency) async {
    NetworkHelper networkHelper = NetworkHelper();
    List<Uri> urls = [];
    Map<String, double> map = Map();

    for (String crypto in cryptoList) {
      var url = Uri.https('rest.coinapi.io',
          '/v1/exchangerate/$crypto/$currency', {'apikey': apikey});
      urls.add(url);
    }

    await Future.forEach(urls, (url) async {
      var coinData = await networkHelper.getData(url);
      print(coinData);
      String base = coinData['asset_id_base'];
      double rate = coinData['rate'];
      map[base] = rate;
    });

    return map;
  }
}
