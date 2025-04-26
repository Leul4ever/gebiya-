import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/store-1.png',
            width: 30.0, // Added width for the image
          ),
          const SizedBox(width: 40),
          Image.asset(
            'assets/icons/pickicon.png',
            width: 30.0, // Added width for the image
          ),
          const SizedBox(width: 30),
          Flexible(
            child: SizedBox(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: ' Current location',
                  labelText: 'Current location',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
