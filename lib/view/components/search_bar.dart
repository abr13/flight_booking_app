import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/flight_provider.dart';

class SearchBarComponent extends StatefulWidget {
  const SearchBarComponent({Key? key}) : super(key: key);

  @override
  _SearchBarComponentState createState() => _SearchBarComponentState();
}

class _SearchBarComponentState extends State<SearchBarComponent> {
  DateTime? _selectedDate;
  int _selectedPanelIndex = 0;
  static const int _searchFlightsPanelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildExpandableSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableSearchBar() {
    return ExpansionPanelList.radio(
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(0),
      children: [
        ExpansionPanelRadio(
          value: _searchFlightsPanelIndex,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text('Search Flights'),
            );
          },
          body: Column(
            children: [
              _buildTextField('Origin', _onOriginChanged),
              const SizedBox(height: 8.0),
              _buildTextField('Destination', _onDestinationChanged),
              const SizedBox(height: 8.0),
              _buildDateTextField(context),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _selectedPanelIndex =
              isExpanded ? -1 : _searchFlightsPanelIndex; // Toggle panel
        });
      },
    );
  }

  Widget _buildTextField(String labelText, Function(String) onChanged) {
    return TextField(
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }

  Widget _buildDateTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _selectDate(context),
            child: IgnorePointer(
              child: TextField(
                controller: TextEditingController(
                  text: _selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                      : '',
                ),
                decoration: const InputDecoration(
                  labelText: 'Date (dd/mm/yyyy)',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _selectedDate = null;
              _clearDateFilter();
            });
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _onDateChanged(DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    }
  }

  void _onOriginChanged(String value) {
    Provider.of<FlightProvider>(context, listen: false)
        .searchFlights(origin: value);
  }

  void _onDestinationChanged(String value) {
    Provider.of<FlightProvider>(context, listen: false)
        .searchFlights(destination: value);
  }

  void _onDateChanged(String value) {
    Provider.of<FlightProvider>(context, listen: false)
        .searchFlights(date: value, onSearchFailed: _showSearchFailedSnackbar);
  }

  void _clearDateFilter() {
    Provider.of<FlightProvider>(context, listen: false)
        .searchFlights(date: null);
  }

  void _showSearchFailedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No flights found for the given search criteria.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
