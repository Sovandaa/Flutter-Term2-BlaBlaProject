import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

class SeatInputField extends StatelessWidget {
  final int initSeat;
  final Function(int) onSeatSelected;

  const SeatInputField({super.key, 
    this.initSeat = 1,  // set defualt value 1 
    required this.onSeatSelected
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.person, size: 16, color: BlaColors.neutral),
      title: Text(
        initSeat.toString(),
        style: TextStyle( color: BlaColors.neutral)
      ),
      onTap: () => {
        // implement navigation, seat input using full dialog
      },
    );
  }
}
