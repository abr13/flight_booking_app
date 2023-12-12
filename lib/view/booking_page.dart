import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/flight_provider.dart';
import 'components/list_item.dart';
import 'components/search_bar.dart';

class FlightApp extends StatelessWidget {
  const FlightApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Flight Booking App'),
      ),
      body: const Column(
        children: [
          SearchBarComponent(),
          Expanded(child: FlightList()),
        ],
      ),
    );
  }
}

class FlightList extends StatelessWidget {
  const FlightList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FlightProvider>(
      builder: (context, flightProvider, child) {
        return ListView.builder(
          itemCount: flightProvider.filteredFlights.length,
          itemBuilder: (context, index) {
            return FlightListItem(flightProvider.filteredFlights[index]);
          },
        );
      },
    );
  }
}
