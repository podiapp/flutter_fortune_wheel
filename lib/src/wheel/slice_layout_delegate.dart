part of 'wheel.dart';

enum _SliceSlot {
  slice,
  child,
}

class _CircleSliceLayoutDelegate extends MultiChildLayoutDelegate {
  final double angle;
  final double ratio;

  _CircleSliceLayoutDelegate(this.angle, this.ratio);

  @override
  void performLayout(Size size) {
    late Size sliceSize;

    if (hasChild(_SliceSlot.slice)) {
      sliceSize = layoutChild(
        _SliceSlot.slice,
        BoxConstraints.tight(size),
      );
      positionChild(_SliceSlot.slice, Offset.zero);
    }

    if (hasChild(_SliceSlot.child)) {
      final childSize = layoutChild(
        _SliceSlot.child,
        BoxConstraints.loose(size),
      );

      final topRectVector = _math.Point(sliceSize.width * (1 - ratio / 2), 0.0);
      final halfAngleVector = topRectVector.rotate(angle / 2);

      positionChild(
        _SliceSlot.child,
        Offset(
          halfAngleVector.x - childSize.width / 2,
          halfAngleVector.y - childSize.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRelayout(_CircleSliceLayoutDelegate oldDelegate) {
    return angle != oldDelegate.angle || ratio != oldDelegate.ratio;
  }
}
