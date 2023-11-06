import 'package:flutter/material.dart';

Widget IconAndTitleAndInfo(
  context, {
  required IconData icon,
  required String text1,
  required String text2,
  required Widget navigatTo,
}) {
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => navigatTo,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 19),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
