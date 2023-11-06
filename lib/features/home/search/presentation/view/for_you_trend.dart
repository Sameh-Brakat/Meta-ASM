import 'package:flutter/material.dart';
import 'package:social_app/core/components/trend.dart';

class ForYouTrend extends StatelessWidget {
  const ForYouTrend({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: TrendItem(index + 1, trendcat: 'Trending in Egypt'),
          );
        },
        separatorBuilder: (context, index) {
          if (index == 2) {
            return Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20)
                      .copyWith(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Videos for you',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        'Check these popular and trending for you',
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.blue[400],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 15,
                                ),
                            itemCount: 3),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            );
          }
          return SizedBox();
        },
        itemCount: 7);
  }
}
