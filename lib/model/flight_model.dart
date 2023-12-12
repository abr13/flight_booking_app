import 'package:intl/intl.dart';

class FlightResponseModel {
  final String origin;
  final String destination;
  final DateTime date;
  final String airline;
  final double price;
  final String airlineImage;
  final bool discount;
  final int discountPrice;

  FlightResponseModel({
    required this.origin,
    required this.destination,
    required this.date,
    required this.airline,
    required this.price,
    required this.airlineImage,
    required this.discount,
    required this.discountPrice,
  });

  factory FlightResponseModel.fromJson(Map<String, dynamic> json) {
    return FlightResponseModel(
      origin: json['origin'],
      destination: json['destination'],
      date: DateFormat('dd/MM/yyyy').parse(json['date']),
      airline: json['airline'],
      price: json['price'].toDouble(),
      airlineImage: json['airline_image'],
      discount: json['discount'],
      discountPrice: json['discount_price'],
    );
  }
}
