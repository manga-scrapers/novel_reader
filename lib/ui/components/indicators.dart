part of '../search_screen/custom_search_delegate.dart';

class Indicators {
  static final Indicators _instance = Indicators._singleton();

  factory Indicators() {
    return _instance;
  }

  Indicators._singleton();

  /// Spinning rotating circle with varying color.
  static Widget loadingProgressIndicator(
    BuildContext context, {
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
}
