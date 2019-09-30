import 'package:flutter/material.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: BannerPainter(
          message: 'DEV',
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topStart,
          color: Colors.red,
        ),
      ),
    );
  }
}
