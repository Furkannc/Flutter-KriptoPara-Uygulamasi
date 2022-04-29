class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double current_price;
  final double price_change_percentage_24h;

  const Coin(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.current_price,
      required this.price_change_percentage_24h});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        id: json["id"] as String,
        name: json['name'] as String,
        symbol: json["symbol"] as String,
        image: json["image"] as String,
        current_price: ((json["current_price"] as num)).toDouble(),
        price_change_percentage_24h:
            ((json["price_change_percentage_24h"] as num)).toDouble());
  }
}
