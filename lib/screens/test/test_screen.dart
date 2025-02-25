import 'package:blabla_project/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            // Primary button with icon
              BlaButton(
                text: 'Primary Button',
                icon: Icons.date_range_rounded,
                type: BlaButtonType.primary,
                onPressed: () {
                  print('Primary Button');
                },
              ),
              const SizedBox(height: 20),

              // Secondary button without icon
              BlaButton(
                text: 'Secondary Button',
                type: BlaButtonType.secondary,
                onPressed: () {
                  print('Secondary Button');
                },
              ),
              const SizedBox(height: 20),

              // primary button without border radius
              BlaButton(
                text: "Search",
                type: BlaButtonType.primary,
                onPressed: () {},
                borderRadius: 0.0, 
              )
          ],
        ),
      ),
    ),
  ));
}