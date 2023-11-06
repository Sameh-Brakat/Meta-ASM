import 'package:flutter/material.dart';
import 'package:social_app/core/components/trend.dart';

class EntertainmentTrend extends StatelessWidget {
  const EntertainmentTrend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: TrendItem(index + 1, trendcat: 'Trending in Entertainment'),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox();
        },
        itemCount: 7);
  }
}
