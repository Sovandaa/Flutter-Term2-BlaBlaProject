import 'package:blabla_project/dummy_data/dummy_data.dart';
import 'package:blabla_project/model/ride/locations.dart';
import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// Full Screen Dialog to select location
///
class RidePrefSelectLocation extends StatefulWidget {
  final Function(Location) onLocationSelected; // return selected location
  
  const RidePrefSelectLocation({super.key, required this.onLocationSelected});

  @override
  State<RidePrefSelectLocation> createState() => _RidePrefSelectLocation();
}

class _RidePrefSelectLocation extends State<RidePrefSelectLocation> {
  late TextEditingController searchController; // search input controller
  List<Location> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // method use to filter location match with input
  void filterLocations(String input) {
    setState(() {
      filteredLocations = [];
      for (var location in fakeLocations) {
        if (location.name.toLowerCase().contains(input.toLowerCase())) {
          filteredLocations.add(location);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white,

        // navigate back to main screen
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios, color: BlaColors.neutralLight),
        ),

        // search input field 
        title: TextField(
          controller: searchController,
          onChanged: filterLocations, // call filter when input change (to matching)
          decoration: const InputDecoration(
            hintText: 'Search location',
            border: InputBorder.none,
          ),
        ),

        // close button to exit modal
        actions: [
          IconButton(
            onPressed: () {
              searchController.clear();
              filterLocations('');
            },
            icon: Icon(Icons.close, color: BlaColors.neutralLight),
          ),
        ],
      ),

      // show all list or matching location
      body: filteredLocations.isEmpty
          ? const Center(child: Text("No results of Location!"))
          : ListView.builder(
              itemCount: filteredLocations.length,
              itemBuilder: (context, index) {
                Location location =
                    filteredLocations[index]; // get location of each index
                return ListTile(
                  title: Text(location.name),
                  subtitle: Text(location.country.name),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: BlaColors.neutralLight, size: 16),
                  onTap: () {
                    widget.onLocationSelected(
                        location); // return selected location, then close dialog
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
    );
  }
}