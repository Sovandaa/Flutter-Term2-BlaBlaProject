import 'package:blabla_project/model/ride/locations.dart';
import 'package:blabla_project/screens/ride_pref/widgets/ride_pref_select_location.dart';
import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationInputField extends StatelessWidget {
  final Location? initLocation;
  final String hint;
  final Function(Location) onLocationSelected;

  const LocationInputField(
      {super.key,
      this.initLocation,
      required this.hint,
      required this.onLocationSelected});

  // method to display the selected location or hint text
  String get selectedLocationLabel => initLocation != null
      ? "${initLocation!.name}"
      : hint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Icon(Icons.radio_button_off, size: 16, color: BlaColors.iconNormal),
      title: Text(
        selectedLocationLabel,
        style: TextStyle( color: BlaColors.neutral)
      ),
      onTap: () async{
        // implement navigate to search location full modal screen
        final Location? selectedLocation = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => RidePrefSelectLocation(
              onLocationSelected: (location) {
                Navigator.pop(ctx, location); // Close dialog and return location
              },
            ),
          ),
        );

        // Return selected location
        if (selectedLocation != null) {
          onLocationSelected(selectedLocation);
        }
      },
    );
  }
}
