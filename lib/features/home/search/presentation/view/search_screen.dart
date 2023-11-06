import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:social_app/core/styles/icon_broken.dart';
import 'package:social_app/features/home/home_page/presentation/view/home_screen.dart';
import 'package:social_app/features/home/search/presentation/view/entertainment_trend.dart';
import 'package:social_app/features/home/search/presentation/view/for_you_trend.dart';
import 'package:social_app/features/home/search/presentation/view/news_trending.dart';
import 'package:social_app/features/home/search/presentation/view/sports_trend.dart';
import 'package:social_app/features/home/search/presentation/view/trending.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: [
            Tab(
              text: 'For you',
            ),
            Tab(
              text: 'Trending',
            ),
            Tab(
              text: 'News',
            ),
            Tab(
              text: 'Sportss',
            ),
            Tab(
              text: 'Entertainment',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ForYouTrend(),
          Trending(),
          NewsTrend(),
          SportsTrend(),
          EntertainmentTrend(),
        ],
      ),
    );
  }
}
