part of 'wheel.dart';

/// Draws a slice of a circle. The slice's arc starts at the right (3 o'clock)
/// and moves clockwise as far as specified by angle.
class _CircleSlicePainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;
  final Gradient? gradient;
  final double strokeWidth;
  final double angle;
  final double ratio;

  const _CircleSlicePainter({
    required this.fillColor,
    this.strokeColor,
    this.gradient,
    this.ratio = 1,
    this.strokeWidth = 1,
    this.angle = _math.pi / 2,
  }) : assert(angle > 0 && angle < 2 * _math.pi);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = _math.min(size.width, size.height);
    final path = _CircleSlice.buildSlicePath(radius, angle, ratio);

    final gradientPaint = Paint()
      ..shader =
          gradient?.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    final normalPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    // fill slice area
    canvas.drawPath(path, gradient != null ? gradientPaint : normalPaint);

    // draw slice border
    if (strokeWidth > 0) {
      canvas.drawPath(
        path,
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );

      canvas.drawPath(
        Path()
          ..arcTo(
              Rect.fromCircle(
                center: Offset(0, 0),
                radius: radius,
              ),
              0,
              angle,
              false),
        Paint()
          ..color = strokeColor!
          ..strokeWidth = strokeWidth * 2
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(_CircleSlicePainter oldDelegate) {
    return angle != oldDelegate.angle ||
        fillColor != oldDelegate.fillColor ||
        strokeColor != oldDelegate.strokeColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
