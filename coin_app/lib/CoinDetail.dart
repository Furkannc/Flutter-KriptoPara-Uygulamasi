import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Coin.dart';
import 'contants.dart';

Future<List<Coin>> fetchCoins(http.Client client, String id) async {
  final response = await client.get(Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&ids=$id&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseCoins, response.body);
}

// A function that converts a response body into a List<Coin>.
List<Coin> parseCoins(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Coin>((json) => Coin.fromJson(json)).toList();
}

class CoinDetail extends StatelessWidget {
  const CoinDetail({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          id.toUpperCase(),
          style: TextStyle(letterSpacing: 10),
        ),
      ),
      body: FutureBuilder<List<Coin>>(
        future: fetchCoins(http.Client(), id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return CoinDetailCard(coin: snapshot.data![0]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CoinDetailCard extends StatelessWidget {
  const CoinDetailCard({Key? key, required this.coin}) : super(key: key);
  final Coin coin;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.network(
                    coin.image,
                    height: 100,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(coin.symbol.toUpperCase(), style: title),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            coin.price_change_percentage_24h > 0
                                ? Icons.arrow_upward_outlined
                                : Icons.arrow_downward_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "%" +
                                coin.price_change_percentage_24h
                                    .toStringAsFixed(2),
                            style: content,
                          )
                        ],
                      ),
                      Text(
                        "Price:  " +
                            coin.current_price.toStringAsFixed(2) +
                            "\$",
                        style: content,
                      )
                    ],
                  ),
                  Spacer(),
                ],
              ),
              Divider(
                height: 20,
                color: Colors.white,
              ),
              Text(
                "Market Cap Rank:  " + coin.market_cap_rank.toString(),
                style: content,
              ),
              Text("Market Cap:  " + coin.market_cap.toString() + "\$",
                  style: content),
              CoinDataTable(coin: coin)
            ],
          ),
        ),
      ),
    );
  }
}

class CoinDataTable extends StatelessWidget {
  const CoinDataTable({Key? key, required this.coin}) : super(key: key);
  final Coin coin;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side:
            BorderSide(color: Colors.white, width: 2, style: BorderStyle.solid),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Market Price",
              style: content,
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Text(
              "24H High:  " + coin.high_24h.toStringAsFixed(2) + "\$",
              style: content,
            ),
            Text(
              "24H Low:  " + coin.low_24h.toStringAsFixed(2) + "\$",
              style: content,
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Text(
              "24H Change",
              style: content,
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  coin.price_change_24h > 0
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                  color: Colors.white,
                ),
                Text(
                  "%" + coin.price_change_percentage_24h.toStringAsFixed(2),
                  style: content,
                ),
              ],
            ),
            Text(
              coin.price_change_24h.toStringAsFixed(2) + "\$",
              style: content,
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Column(
              children: [
                Text(
                  "Market Cap 24H",
                  style: content,
                ),
                Divider(
                  thickness: 2,
                  height: 10,
                  color: Colors.white,
                ),
                Text(
                  "Value:  ${coin.market_cap_change_24h?.toStringAsFixed(2)}\$",
                  style: content,
                ),
                Text(
                  "Percentage:  %${coin.price_change_percentage_24h.toStringAsFixed(2)}",
                  style: content,
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Text(
              "Supply",
              style: content,
            ),
            Divider(
              thickness: 2,
              height: 10,
              color: Colors.white,
            ),
            Text(
              "Circulating:  " + coin.circulating_supply.toStringAsFixed(2),
              style: content,
            ),
            Text(
              "Total:  " + coin.total_supply.toString(),
              style: content,
            ),
            Text(
              "Max:  " + coin.max_supply.toString(),
              style: content,
            )
          ],
        ),
      ),
    );
  }
}
