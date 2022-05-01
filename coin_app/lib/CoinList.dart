import 'package:flutter/material.dart';

import 'Coin.dart';
import 'CoinDetail.dart';

class CoinList extends StatelessWidget {
  const CoinList({Key? key, required this.coins}) : super(key: key);

  final List<Coin> coins;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoinDetail(
                  id: coins[index].id,
                ),
              ),
            );
          },
          child: Card(
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
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
          ),
        );
      },
    );
  }
}
