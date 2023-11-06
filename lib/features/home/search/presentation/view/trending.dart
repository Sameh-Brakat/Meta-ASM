import 'package:flutter/material.dart';
import 'package:social_app/core/components/trend.dart';

class Trending extends StatelessWidget {
  const Trending({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15).copyWith(bottom: 0),
            child: Text(
              'Trends',
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child:
                      TrendItem(index + 1, trendcat: 'Trending', isTrend: true),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemCount: 7),
        ],
      ),
    );
  }
}
