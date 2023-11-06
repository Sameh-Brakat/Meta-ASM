import 'package:flutter/material.dart';
import 'package:social_app/core/components/coming_soon.dart';
import 'package:social_app/core/styles/icon_broken.dart';

class BlueScreen extends StatelessWidget {
  const BlueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonScreen(
      title: 'ASM Blue',
      icon: Icons.verified,
    );
  }
}
