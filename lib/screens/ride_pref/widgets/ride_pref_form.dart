import 'package:blabla_project/screens/ride_pref/widgets/ride_pref_input_tile.dart';
import 'package:blabla_project/screens/rides/rides_screen.dart';
import 'package:blabla_project/theme/theme.dart';
import 'package:blabla_project/utils/animations_util.dart';
import 'package:blabla_project/utils/date_time_util.dart';
import 'package:blabla_project/widgets/actions/bla_button.dart';
import 'package:blabla_project/widgets/display/bla_divider.dart';
import 'package:blabla_project/widgets/inputs/bla_location_picker.dart';
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

  void onDeparturePressed() async {
    // 1- select a location
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(initLocation: departure,))
    );

    // 2- update form if needed
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrivalPressed() async {
    // 1- select a location
    Location? selectedLocation = await Navigator.of(context).push<Location>(
        AnimationUtils.createBottomToTopRoute(BlaLocationPicker(initLocation: arrival,))
    );
    // 2- update from if needed
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSubmit(){
    bool hasDeparture = departure != null;
    bool hasArrival = arrival != null;

    if (hasDeparture && hasArrival) {
      // 1- Crea a Ride Pref from user inputs
      RidePref newRideRef = RidePref(
          departure: departure!,
          departureDate: departureDate,
          arrival: arrival!,
          requestedSeats: requestedSeats);

      // 2 - Navigate to the rides screen (with a buttom to top animation)
      Navigator.of(context)
          .push(AnimationUtils.createBottomToTopRoute(RidesScreen(
        initialRidePref: newRideRef,
      )));
    }
  }

  void onSwappingLocationPressed() {
    setState(() {
      // switch only if both departure and arrivate are defined
      if (departure != null && arrival != null) {

        // Use copy to prevent modify original locations 
        Location temp = departure!;
        departure = Location.copy(arrival!);
        arrival = Location.copy(temp);
      }
    });
  }

  // ----------------------------------
  // Compute the widgets rendering, prepares values before rendering the UI
  // ----------------------------------

  // Use getters to compute UI labels dynamically
  String get departureLabel =>departure != null ? departure!.name : "Leaving from";
  String get arrivalLabel => arrival != null ? arrival!.name : "Going to";

  bool get showDeparturePLaceHolder => departure == null;
  bool get showArrivalPLaceHolder => arrival == null;

  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get numberLabel => requestedSeats.toString();

  bool get switchVisible => arrival != null && departure != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: BlaSpacings.m),
            child: Column(
              children: [
                // 1- Input the ride departure
                RidePrefInputTile(
                  isPlaceHolder: showDeparturePLaceHolder,
                  title: departureLabel,
                  leftIcon:  Icons.circle_outlined,
                  onPressed: onDeparturePressed,
                  rightIcon: switchVisible ? Icons.swap_vert : null,
                  onRightIconPressed: switchVisible ? onSwappingLocationPressed : null,
                ),
                const BlaDivider(),

                // 2- Input the ride arrival
                RidePrefInputTile(
                    isPlaceHolder: showArrivalPLaceHolder,
                    title: arrivalLabel,
                    leftIcon: Icons.circle_outlined,
                    onPressed: onArrivalPressed),
                const BlaDivider(),

                // 3- Input the ride date
                RidePrefInputTile(
                    title: dateLabel,
                    leftIcon: Icons.calendar_month,
                    onPressed: () => {}),
                const BlaDivider(),

                // 4-  Input the requested number of seats
                RidePrefInputTile(
                    title: numberLabel,
                    leftIcon: Icons.person_2_outlined,
                    onPressed: () => {})
              ],
            ),
          ),

          // 5- search button for submit ride pref to look for ride
          BlaButton(text: 'Search', onPressed: onSubmit,),
        ]);
  }
}