import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Coin.dart';

Future<List<Coin>> fetchCoins(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=market_cap_desc&per_page=100&page=1&sparkline=false'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCoins, response.body);
}

// A function that converts a response body into a List<Coin>.
List<Coin> parseCoins(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Coin>((json) => Coin.fromJson(json)).toList();
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "COINS",
          style: TextStyle(letterSpacing: 10),
        ),
      ),
      body: FutureBuilder<List<Coin>>(
        future: fetchCoins(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return CoinList(coins: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CoinList extends StatelessWidget {
  const CoinList({Key? key, required this.coins}) : super(key: key);

  final List<Coin> coins;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Image.network(
                  coins[index].image,
                  height: 50,
                  width: 50,
                ),
              ),
              Text(
                coins[index].name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(coins[index].current_price.toStringAsFixed(2),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Spacer(),
              Container(
                child: Column(children: [
                  Icon(
                      coins[index].price_change_percentage_24h > 0
                          ? Icons.arrow_circle_up
                          : Icons.arrow_circle_down,
                      color: coins[index].price_change_percentage_24h > 0
                          ? Colors.green
                          : Colors.red),
                  Text(coins[index]
                      .price_change_percentage_24h
                      .toStringAsFixed(3))
                ]),
              )
            ],
          ),
        );
      },
    );
  }
}
