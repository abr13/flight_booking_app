import 'package:flight_booking_app/util/date_formatter.dart';
import 'package:flutter/material.dart';

import '../model/flight_model.dart';
import '../query/flight_service.dart';

class FlightProvider extends ChangeNotifier {
  final List<FlightResponseModel> _flights = FlightService.getFlights();
  List<FlightResponseModel> _filteredFlights = [];

  List<FlightResponseModel> get filteredFlights =>
      _filteredFlights.isNotEmpty ? _filteredFlights : _flights;

  void searchFlights(
      {String? origin,
      String? destination,
      String? date,
      void Function()? onSearchFailed}) {
    _filteredFlights = _flights;

    if (origin != null) {
      _filteredFlights = _filteredFlights
          .where((flight) =>
              flight.origin.toLowerCase().contains(origin.toLowerCase()))
          .toList();
    }

    if (destination != null) {
      _filteredFlights = _filteredFlights
          .where((flight) => flight.destination
              .toLowerCase()
              .contains(destination.toLowerCase()))
          .toList();
    }

    if (date != null) {
      DateTime? selectedDate = DateFormatter.parseDate(date);

      _filteredFlights = _filteredFlights
          .where((flight) => flight.date.isAtSameMomentAs(selectedDate))
          .toList();

      if (_filteredFlights.isEmpty && onSearchFailed != null) {
        onSearchFailed();
      }
    }

    notifyListeners();
  }
}
