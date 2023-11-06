import 'package:flutter/material.dart';

Widget TrendItem(index, {required trendcat, bool? isTrend}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTrend == true ? '$index-$trendcat ' : trendcat,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis),
        ),
        Text(
          '#بلاش الترند الاصلي عشان منرحش ف داهية :)',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              overflow: TextOverflow.ellipsis),
        ),
        Row(
          children: [
            Text(
              '1048 ',
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
            ),
            Text(
              'posts',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ],
    );
