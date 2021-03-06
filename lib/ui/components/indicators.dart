import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class Indicators {
  static final Indicators _instance = Indicators._singleton();

  factory Indicators() {
    return _instance;
  }

  Indicators._singleton();

  /// Spinning rotating circle with varying color.
  static Widget loadingProgressIndicator({
    Color? begin,
    Color? end,
    int? seconds,
  }) {
    return Center(
      child: MirrorAnimation<Color?>(
        duration: Duration(seconds: seconds ?? 1),
        tween:
            ColorTween(begin: begin ?? Colors.red, end: end ?? Colors.yellow),
        builder: (context, child, value) {
          return SpinKitRotatingCircle(
            color: value,
          );
        },
      ),
    );
  }

  /// Shimmer effect
  static Widget shimmerProgressIndicator(BuildContext context) {
    return GFShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _emptyHeader(context),
          const SizedBox(height: 12.0),
          Expanded(
            flex: 2,
            child: _emptyChapters(context),
          ),
        ],
      ),
    );
  }

  static Widget _emptyChapters(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int itemCount = 3; // TODO: make it dynamic
        return Column(
          children: List.generate(
            itemCount,
            (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 2.0,
                  ),
                  child: Container(
                    height: constraints.maxHeight / 2,
                    width: constraints.maxWidth,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Widget _emptyHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 160,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget errorIndicator(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error),
          Text(error),
        ],
      ),
    );
  }
}
