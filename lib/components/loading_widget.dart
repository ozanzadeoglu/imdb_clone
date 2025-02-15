import 'package:flutter/material.dart';
import 'package:imdb_app/constants/color_constants.dart';
import 'package:kartal/kartal.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: ColorConstants.iconYellow,
        size: context.sized.height * 0.1,
      ),
    );
  }
}
