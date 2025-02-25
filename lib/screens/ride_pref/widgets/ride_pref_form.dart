import 'package:blabla_project/theme/theme.dart';
import 'package:blabla_project/widgets/actions/bla_button.dart';
import 'package:blabla_project/widgets/display/bla_divider.dart';
import 'package:blabla_project/widgets/inputs/date_picker_field.dart';
import 'package:blabla_project/widgets/inputs/location_input_field.dart';
import 'package:blabla_project/widgets/inputs/seat_input_field.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  Location? arrival;
  DateTime departureDate = DateTime.now();
  int requestedSeats = 1;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    // check if inital ride pref is provide or not (set default)
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // method to update state (change value)
  void onSelectDeparture(Location newLocation) {
    setState(() {
      departure = newLocation;
    });
  }

  void onSelectArrival(Location newLocation) {
    setState(() {
      arrival = newLocation;
    });
  }

  void onSelectDepartureDate(DateTime date) {
    setState(() {
      departureDate = date;
    });
  }

  void onSelectSeat(int seat) {
    setState(() {
      requestedSeats = seat;
    });
  }

  // method to swap location between departure and arrival
  void swapLocations() {
    if (departure != null || arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Departure Field Input wrap with switch
          Row(
            children: [
              Expanded(
                child: LocationInputField(
                    hint: "Leaving from",
                    initLocation: departure,
                    onLocationSelected: onSelectDeparture),
              ),

              // swap button, switch location
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.swap_vert,
                        color: BlaColors.primary, size: 20),
                    onPressed: swapLocations,
                  ),
                ),
              ),
            ],
          ),
          BlaDivider(),

          // Arrival Field
          LocationInputField(
            hint: "Going to",
            initLocation: arrival,
            onLocationSelected: onSelectArrival,
          ),

          BlaDivider(),

          // Select Date Field
          DatePickerField(
            initDate: departureDate,
            onDateSelected: onSelectDepartureDate,
          ),

          BlaDivider(),

          // Select Seats Field
          SeatInputField(onSeatSelected: onSelectSeat),

          const SizedBox(
            height: BlaSpacings.s,
          ),

          BlaButton(
            type: BlaButtonType.primary,
            text: "Search",
            onPressed: () => {}, // implement to search screen
            borderRadius: 0.0,
          ),
        ]);
  }
}
