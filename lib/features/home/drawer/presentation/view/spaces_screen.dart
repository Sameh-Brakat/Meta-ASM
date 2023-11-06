import 'package:flutter/material.dart';
import 'package:social_app/core/components/coming_soon.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonScreen(
      title: 'ASM Spaces',
      icon: IconBroken.Voice_2,
    );
  }
}
