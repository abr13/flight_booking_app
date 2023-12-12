import 'dart:convert';

import '../model/flight_model.dart';

class FlightService {
  static String flightData = '''
[
  {
    "origin": "Delhi",
    "destination": "Mumbai",
    "date": "20/12/2023",
    "airline": "IndiGo",
    "price": 2500.0,
    "airline_image": "assets/indigo.png",
    "discount": true,
    "discount_price": 2000
  },
  {
    "origin": "Bangalore",
    "destination": "Chennai",
    "date": "21/12/2023",
    "airline": "Air India",
    "price": 2800.0,
    "airline_image": "assets/air_india.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Mumbai",
    "destination": "Delhi",
    "date": "22/12/2023",
    "airline": "SpiceJet",
    "price": 2200.0,
    "airline_image": "assets/spicejet.png",
    "discount": true,
    "discount_price": 1800
  },
  {
    "origin": "Chennai",
    "destination": "Bangalore",
    "date": "23/12/2023",
    "airline": "Vistara",
    "price": 3000.0,
    "airline_image": "assets/vistara.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Kolkata",
    "destination": "Hyderabad",
    "date": "24/12/2023",
    "airline": "GoAir",
    "price": 2600.0,
    "airline_image": "assets/goair.png",
    "discount": true,
    "discount_price": 2200
  },
  {
    "origin": "Hyderabad",
    "destination": "Kolkata",
    "date": "25/12/2023",
    "airline": "Air Asia",
    "price": 3200.0,
    "airline_image": "assets/airasia.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Jaipur",
    "destination": "Lucknow",
    "date": "26/12/2023",
    "airline": "GoAir",
    "price": 1800.0,
    "airline_image": "assets/goair.png",
    "discount": true,
    "discount_price": 1500
  },
  {
    "origin": "Lucknow",
    "destination": "Jaipur",
    "date": "27/12/2023",
    "airline": "SpiceJet",
    "price": 2400.0,
    "airline_image": "assets/spicejet.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Ahmedabad",
    "destination": "Pune",
    "date": "28/12/2023",
    "airline": "IndiGo",
    "price": 2000.0,
    "airline_image": "assets/indigo.png",
    "discount": true,
    "discount_price": 1700
  },
  {
    "origin": "Pune",
    "destination": "Ahmedabad",
    "date": "29/12/2023",
    "airline": "Air Asia",
    "price": 2800.0,
    "airline_image": "assets/airasia.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Bhubaneswar",
    "destination": "Guwahati",
    "date": "30/12/2023",
    "airline": "Vistara",
    "price": 3200.0,
    "airline_image": "assets/vistara.png",
    "discount": true,
    "discount_price": 2700
  },
  {
    "origin": "Guwahati",
    "destination": "Bhubaneswar",
    "date": "31/12/2023",
    "airline": "GoAir",
    "price": 2400.0,
    "airline_image": "assets/goair.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Coimbatore",
    "destination": "Trivandrum",
    "date": "01/01/2024",
    "airline": "Air India",
    "price": 3000.0,
    "airline_image": "assets/air_india.png",
    "discount": true,
    "discount_price": 2500
  },
  {
    "origin": "Trivandrum",
    "destination": "Coimbatore",
    "date": "02/01/2024",
    "airline": "SpiceJet",
    "price": 2600.0,
    "airline_image": "assets/spicejet.png",
    "discount": false,
    "discount_price": 0
  },
  {
    "origin": "Ranchi",
    "destination": "Patna",
    "date": "03/01/2024",
    "airline": "IndiGo",
    "price": 2200.0,
    "airline_image": "assets/indigo.png",
    "discount": true,
    "discount_price": 1800
  },
  {
    "origin": "Patna",
    "destination": "Ranchi",
    "date": "04/01/2024",
    "airline": "Air Asia",
    "price": 2800.0,
    "airline_image": "assets/airasia.png",
    "discount": false,
    "discount_price": 0
  }
]
''';

  static List<FlightResponseModel> getFlights() {
    List<dynamic> decodedData = json.decode(flightData);
    return decodedData
        .map((flightJson) => FlightResponseModel.fromJson(flightJson))
        .toList();
  }

  static List<FlightResponseModel> searchFlights(
      {String? origin, String? destination, DateTime? date}) {
    List<FlightResponseModel> allFlights = getFlights();
    List<FlightResponseModel> searchResults = allFlights;

    if (origin != null) {
      searchResults = searchResults
          .where(
              (flight) => flight.origin.toLowerCase() == origin.toLowerCase())
          .toList();
    }

    if (destination != null) {
      searchResults = searchResults
          .where((flight) =>
              flight.destination.toLowerCase() == destination.toLowerCase())
          .toList();
    }

    if (date != null) {
      searchResults = searchResults
          .where((flight) => flight.date.isAtSameMomentAs(date))
          .toList();
    }

    return searchResults;
  }
}
