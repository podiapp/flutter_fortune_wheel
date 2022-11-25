part of 'wheel.dart';

Offset _getOffset(Alignment alignment, Offset margins) {
  assert(alignment.x == 0 || alignment.y == 0,
      'Alignments on the diagonals are not yet supported.');

  if (alignment == Alignment.center) {
    return Offset.zero;
  }
  return margins.scale(-alignment.x, -alignment.y);
}

double _getAngle(Alignment alignment) {
  assert(alignment.x == 0 || alignment.y == 0,
      'Alignments on the diagonals are not yet supported.');

  if ([Alignment.center, Alignment.topCenter].contains(alignment)) {
    return 0;
  }
  if (alignment.x == 0) {
    return _math.pi;
  }
  if (alignment == Alignment.centerLeft) {
    return -_math.pi * 0.5;
  }
  if (alignment == Alignment.centerRight) {
    return _math.pi * 0.5;
  }

  throw ArgumentError('Alignments on the diagonals are not yet supported');
}

class _WheelIndicator extends StatelessWidget {
  final FortuneIndicator indicator;

  const _WheelIndicator({
    Key? key,
    required this.indicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margins = getCenteredMargins(constraints);
        final offset = _getOffset(indicator.alignment, margins);
        final angle = _getAngle(indicator.alignment);

        return Align(
          alignment: indicator.alignment,
          child: Transform.translate(
            offset: offset,
            child: Transform.rotate(
              angle: angle,
              child: indicator.child,
            ),
          ),
        );
      },
    );
  }
}
