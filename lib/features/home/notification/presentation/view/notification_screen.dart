import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All',
            ),
            Tab(
              text: 'Verified',
            ),
            Tab(
              text: 'Mentions',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          NotificationCat(),
          NotificationCat(),
          NotificationCat(),
        ],
      ),
    );
  }

  Widget NotificationCat() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'There was a login to your account @Sameh_Barakat1 from a new device on Aug 30, 2023.Review it now.',
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemCount: 4,
    );
  }
}
