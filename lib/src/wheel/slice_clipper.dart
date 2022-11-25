part of 'wheel.dart';

class _CircleSliceClipper extends CustomClipper<Path> {
  final double angle;
  final double ratio;

  const _CircleSliceClipper(this.angle, this.ratio);

  @override
  Path getClip(Size size) {
    final diameter = _math.min(size.width, size.height);
    return _CircleSlice.buildSlicePath(diameter, angle, 1);
  }

  @override
  bool shouldReclip(_CircleSliceClipper oldClipper) {
    return angle != oldClipper.angle;
  }
}
