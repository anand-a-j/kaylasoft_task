import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/controller/home_provider.dart';
import 'package:student_management_app/utils/color.dart';

class RangeSliderWidget extends StatelessWidget {
  const RangeSliderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context, listen: true);
    RangeLabels labels = RangeLabels(
        homeProvider.rangeValues.start.round().toString(),
        homeProvider.rangeValues.end.round().toString());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 45,
      child: Row(
        children: [
          Text(
            "Age Range:  ${homeProvider.rangeValues.start.toInt()} - ${homeProvider.rangeValues.end.toInt()}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          RangeSlider(
            activeColor: primaryColor,
            labels: labels,
            values: homeProvider.rangeValues,
            divisions: 10,
            onChanged: (range) {
              homeProvider.setRangeValues(range);
            },
            min: 0,
            max: 50,
          ),
        ],
      ),
    );
  }
}
