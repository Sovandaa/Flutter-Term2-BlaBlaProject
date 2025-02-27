import 'package:blabla_project/model/ride/locations.dart';
import 'package:blabla_project/service/locations_service.dart';
import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// A full-screen modal that allows users to search and select a location.
///

class BlaLocationPicker extends StatefulWidget {
  final Location? initLocation;

  const BlaLocationPicker({super.key, this.initLocation});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocations = [];

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();

    if (widget.initLocation != null) {
      filteredLocations = getLocationsFor(widget.initLocation!.name);
    }
  }

  List<Location> getLocationsFor(String text) {
    return LocationsService.availableLocations
        .where((location) =>
            location.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }

  void onBackSelected() {
    Navigator.of(context).pop();
  }

  void onLocationSelected(Location location) {
    Navigator.of(context).pop(location);
  }

  void onSearchChanged(String searchText) {
    List<Location> newSelection = [];

    if (searchText.length > 1) {
      // Start filtering only after 2 characters
      newSelection = getLocationsFor(searchText);
      // newSelection = LocationsService.availableLocations
      //     .where((location) =>
      //         location.name.toUpperCase().contains(searchText.toUpperCase()))
      //     .toList();
    }

    setState(() {
      filteredLocations = newSelection; // update search result
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          BlaSearchBar(
            onBackPressed: onBackSelected,
            onSearchChanged: onSearchChanged,
          ),

          // list of filtered locations
          Expanded(
            child: ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (ctx, index) => LocationTile(
                location: filteredLocations[index],
                onSelected:
                    onLocationSelected, // return selected location, and navigate pop
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

///
/// This tile represents an item in the list of past entered ride inputs
///
class LocationTile extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelected;

  const LocationTile(
      {super.key, required this.location, required this.onSelected});

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onSelected(location),
      title: Text(title,
          style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
      subtitle: Text(subTitle,
          style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),
    );
  }
}

///
///  The Search bar combines the search input + the navigation back button
///  A clear button appears when search contains some text.
///
class BlaSearchBar extends StatefulWidget {
  const BlaSearchBar(
      {super.key, required this.onSearchChanged, required this.onBackPressed});

  final Function(String text) onSearchChanged; // when search text changes
  final VoidCallback onBackPressed;

  @override
  State<BlaSearchBar> createState() => _BlaSearchBarState();
}

class _BlaSearchBarState extends State<BlaSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool get searchIsNotEmpty => _controller.text.isNotEmpty;

  void onChanged(String newText) {
    // 1 - Notity the listener (main widget of text changes)
    widget.onSearchChanged(newText);

    // 2 - Update the cross icon
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius:
            BorderRadius.circular(BlaSpacings.radius), // Rounded corners
      ),
      child: Row(
        children: [
          // Left icon, back button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              onPressed: widget.onBackPressed,
              icon: Icon(
                Icons.arrow_back_ios,
                color: BlaColors.iconLight,
                size: 16,
              ),
            ),
          ),

          // search input field
          Expanded(
            child: TextField(
              focusNode: _focusNode, // Keep input focus
              onChanged: onChanged,
              controller: _controller,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                hintText: "Any city, street...",
                border: InputBorder.none, // No border
                filled: false, // No background fill
              ),
            ),
          ),

          // A clear button appears when search contains some text
          searchIsNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close, color: BlaColors.iconLight),
                  onPressed: () {
                    _controller.clear();
                    _focusNode.requestFocus(); // Ensure it stays focused
                    onChanged("");
                  },
                )
              : SizedBox.shrink(), // Hides the icon if text field is empty
        ],
      ),
    );
  }
}
