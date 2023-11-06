import 'package:flutter/material.dart';
import 'package:social_app/core/components/coming_soon.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonScreen(
      title: 'ASM List',
      icon: IconBroken.Category,
    );
  }
}
