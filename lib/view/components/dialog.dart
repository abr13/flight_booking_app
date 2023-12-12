import 'package:flutter/material.dart';

import '../../model/flight_model.dart';
import '../../util/date_formatter.dart';

class FlightDetailsDialog extends StatelessWidget {
  final FlightResponseModel flight;

  const FlightDetailsDialog({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Flight Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.airplanemode_active, color: Colors.blue),
            title: Text(flight.airline),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.green),
            title: Text('Origin: ${flight.origin}'),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.red),
            title: Text('Destination: ${flight.destination}'),
          ),
          ListTile(
            leading: const Icon(Icons.date_range, color: Colors.orange),
            title: Text(DateFormatter.formatDate(flight.date)),
          ),
          ListTile(
            leading: const Icon(Icons.attach_money, color: Colors.purple),
            title: Text('Original Price: ₹${flight.price.toStringAsFixed(2)}'),
          ),
          if (flight.discount)
            ListTile(
              leading: const Icon(Icons.local_offer, color: Colors.green),
              title: Text('Discount Price: ₹${flight.discountPrice}'),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            _bookFlight(context);
          },
          child: const Text('Book Now'),
        ),
      ],
    );
  }

  void _bookFlight(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Successful'),
        content: const Text('Your flight has been booked successfully!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
