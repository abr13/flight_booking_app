import 'package:flutter/material.dart';

import '../../model/flight_model.dart';
import 'dialog.dart';

class FlightListItem extends StatelessWidget {
  final FlightResponseModel flight;

  const FlightListItem(this.flight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          flight.airlineImage,
          width: 60.0,
          height: 60.0,
          fit: BoxFit.fitWidth,
          color: flight.airline == "IndiGo" ? Colors.blue : null,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              flight.airline,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              "₹${flight.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.black87,
                decoration: flight.discount
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 14.0,
              ),
            ),
            if (flight.discount)
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '₹${flight.discountPrice}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.flight_takeoff,
                        size: 20.0,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        flight.origin,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.flight_land,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        flight.destination,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     const Icon(
            //       Icons.date_range,
            //       size: 18.0,
            //       color: Colors.orange,
            //     ),
            //     const SizedBox(width: 4.0),
            //     Text(
            //       'Date: ${flight.date.day}/${flight.date.month}/${flight.date.year}',
            //       style: const TextStyle(
            //         color: Colors.black87,
            //         fontSize: 14.0,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
        trailing: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => FlightDetailsDialog(flight: flight),
            );
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
