import 'package:flutter/material.dart';

class WaterData extends StatelessWidget {
  const WaterData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () {},
          onLongPress: () {},
          borderRadius: BorderRadius.circular(16),
          
        ),
      ),
    );
  }
}