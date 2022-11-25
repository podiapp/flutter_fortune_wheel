part of 'wheel.dart';

class _CircleSlice extends StatelessWidget {
  static Path buildSlicePath(double radius, double angle, [double ratio = 1]) {
    final startPoint = Offset(radius * (1 - ratio), 0);
    return Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      // ..moveTo(0, 0)
      ..lineTo(radius, 0)
      ..arcTo(Rect.fromCircle(center: const Offset(0, 0), radius: radius), 0,
          angle, false)
      ..relativeLineTo(
          -cos(angle) * radius * ratio, -sin(angle) * radius * ratio)
      ..arcToPoint(startPoint,
          radius: Radius.circular(radius * (1 - ratio)), clockwise: false)
      ..close();
  }

  final double radius;
  final double angle;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final Gradient? gradient;
  final double ratio;

  const _CircleSlice({
    Key? key,
    required this.radius,
    required this.fillColor,
    required this.strokeColor,
    this.strokeWidth = 1,
    required this.ratio,
    this.gradient,
    required this.angle,
  })  : assert(radius > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius,
      height: radius,
      child: CustomPaint(
        painter: _CircleSlicePainter(
          angle: angle,
          fillColor: fillColor,
          gradient: gradient,
          ratio: ratio,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _CircleSliceLayout extends StatelessWidget {
  final Widget? child;
  final _CircleSlice slice;
  final GestureHandler? handler;
  final Axis axis;

  const _CircleSliceLayout({
    Key? key,
    required this.slice,
    required this.axis,
    this.child,
    this.handler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: slice.radius,
      height: slice.radius,
      child: GestureDetector(
        onTap: handler?.onTap,
        onTapCancel: handler?.onTapCancel,
        onTapDown: handler?.onTapDown,
        onTapUp: handler?.onTapUp,
        onDoubleTap: handler?.onDoubleTap,
        onDoubleTapCancel: handler?.onDoubleTapCancel,
        onDoubleTapDown: handler?.onDoubleTapDown,
        onForcePressEnd: handler?.onForcePressEnd,
        onForcePressPeak: handler?.onForcePressPeak,
        onForcePressStart: handler?.onForcePressStart,
        onForcePressUpdate: handler?.onForcePressUpdate,
        onLongPress: handler?.onLongPress,
        onLongPressEnd: handler?.onLongPressEnd,
        onLongPressMoveUpdate: handler?.onLongPressMoveUpdate,
        onLongPressStart: handler?.onLongPressStart,
        onLongPressUp: handler?.onLongPressUp,
        onPanCancel: handler?.onPanCancel,
        onPanDown: handler?.onPanDown,
        onPanEnd: handler?.onPanEnd,
        onPanStart: handler?.onPanStart,
        onPanUpdate: handler?.onPanUpdate,
        onScaleEnd: handler?.onScaleEnd,
        onScaleStart: handler?.onScaleStart,
        onScaleUpdate: handler?.onScaleUpdate,
        onSecondaryLongPress: handler?.onSecondaryLongPress,
        onSecondaryLongPressMoveUpdate: handler?.onSecondaryLongPressMoveUpdate,
        onSecondaryLongPressStart: handler?.onSecondaryLongPressStart,
        onSecondaryLongPressEnd: handler?.onSecondaryLongPressEnd,
        onSecondaryLongPressUp: handler?.onSecondaryLongPressUp,
        onHorizontalDragCancel: handler?.onHorizontalDragCancel,
        onHorizontalDragDown: handler?.onHorizontalDragDown,
        onHorizontalDragEnd: handler?.onHorizontalDragEnd,
        onHorizontalDragStart: handler?.onHorizontalDragStart,
        onHorizontalDragUpdate: handler?.onHorizontalDragUpdate,
        onVerticalDragCancel: handler?.onVerticalDragCancel,
        onVerticalDragDown: handler?.onVerticalDragDown,
        onVerticalDragEnd: handler?.onVerticalDragEnd,
        onVerticalDragStart: handler?.onVerticalDragStart,
        onVerticalDragUpdate: handler?.onVerticalDragUpdate,
        onSecondaryTap: handler?.onSecondaryTap,
        onSecondaryTapCancel: handler?.onSecondaryTapCancel,
        onSecondaryTapDown: handler?.onSecondaryTapDown,
        onSecondaryTapUp: handler?.onSecondaryTapUp,
        onTertiaryTapCancel: handler?.onTertiaryTapCancel,
        onTertiaryTapDown: handler?.onTertiaryTapDown,
        onTertiaryTapUp: handler?.onTertiaryTapUp,
        child: ClipPath(
          clipper: _CircleSliceClipper(slice.angle, slice.ratio),
          child: CustomMultiChildLayout(
            delegate: _CircleSliceLayoutDelegate(slice.angle, slice.ratio),
            children: [
              LayoutId(
                id: _SliceSlot.slice,
                child: slice,
              ),
              if (child != null)
                LayoutId(
                  id: _SliceSlot.child,
                  child: Transform.rotate(
                    angle:
                        slice.angle / 2 + (axis == Axis.vertical ? 0 : pi / 2),
                    child: child,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
