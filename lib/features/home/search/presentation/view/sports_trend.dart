import 'package:flutter/material.dart';
import 'package:social_app/core/components/trend.dart';

class SportsTrend extends StatelessWidget {
  const SportsTrend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: TrendItem(index + 1, trendcat: 'Trending in Sports'),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox();
        },
        itemCount: 7);
  }
}
