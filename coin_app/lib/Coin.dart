// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final int market_cap;
  final int market_cap_rank;
  final double total_volume;
  final double high_24h;
  final double low_24h;
  final double price_change_24h;
  final double price_change_percentage_24h;
  final double? market_cap_change_24h;
  final double market_cap_change_percentage_24h;
  final double circulating_supply;
  final double? total_supply;
  final double? max_supply;
  final double ath;
  final double ath_change_percentage;
  final String ath_date;
  final double atl;
  final double atl_change_percentage;
  final String atl_date;
  final String last_updated;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.current_price,
    required this.market_cap,
    required this.market_cap_rank,
    required this.total_volume,
    required this.high_24h,
    required this.low_24h,
    required this.price_change_24h,
    required this.price_change_percentage_24h,
    required this.market_cap_change_24h,
    required this.market_cap_change_percentage_24h,
    required this.circulating_supply,
    required this.total_supply,
    required this.max_supply,
    required this.ath,
    required this.ath_change_percentage,
    required this.ath_date,
    required this.atl,
    required this.atl_change_percentage,
    required this.atl_date,
    required this.last_updated,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        id: json["id"] as String,
        name: json['name'] as String,
        symbol: json["symbol"] as String,
        image: json["image"] as String,
        current_price: ((json["current_price"] as num)).toDouble(),
        price_change_percentage_24h:
            ((json["price_change_percentage_24h"] as num)).toDouble(),
        ath_change_percentage: json["ath_change_percentage"] as double,
        ath_date: json["ath_date"] as String,
        ath: ((json["ath"] as num).toDouble()),
        atl_change_percentage: json["atl_change_percentage"] as double,
        atl_date: json["atl_date"] as String,
        atl: json["atl"] as double,
        circulating_supply: json["circulating_supply"] as double,
        high_24h: ((json["high_24h"] as num).toDouble()),
        last_updated: json["last_updated"] as String,
        low_24h: ((json["low_24h"] as num).toDouble()),
        market_cap_change_24h:
            ((json["market_cap_change_24h"] as num).toDouble()),
        market_cap_change_percentage_24h:
            json["market_cap_change_percentage_24h"] as double,
        market_cap_rank: json["market_cap_rank"] as int,
        market_cap: json["market_cap"] as int,
        max_supply: json["max_supply"] as double?,
        price_change_24h: json["price_change_24h"] as double,
        total_supply: json["total_supply"] as double?,
        total_volume: ((json["total_volume"] as num).toDouble()));
  }
}
