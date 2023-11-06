import 'package:flutter/material.dart';
import 'package:social_app/core/styles/icon_broken.dart';

AppBar AppBarComponents(context,
    {required String title, bool username = true}) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left)),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        if (username)
          Text(
            '@samehelsayedbarakat',
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis),
          )
      ],
    ),
  );
}
