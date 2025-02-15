import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final Widget prototype;
  final ListView listView;

  const CustomListView({
    super.key,
    required this.prototype,
    required this.listView,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0.0,
            child: prototype,
          ),
        ),
        const SizedBox(width: double.infinity),
        Positioned.fill(child: listView),
      ],
    );
  }
}