import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

/// Port of the clownfish "橘橘" from prototypes/clownfish/index.html.
/// Drawn in the prototype's viewBox (-82 -62 164 124) and scaled to the canvas,
/// so the same painter serves Flutter widgets and Flame components.

enum FishMouth { smile, open, o }

class FishPose {
  const FishPose({
    this.tailAngle = 0,
    this.pecAngle = 0,
    this.dorsalAngle = 0,
    this.eyeScaleY = 1,
    this.fear = false,
    this.mouth = FishMouth.smile,
    this.sweat = 0,
  });

  /// Degrees.
  final double tailAngle;
  final double pecAngle;
  final double dorsalAngle;

  /// 1 = open, ~0.1 = blink.
  final double eyeScaleY;

  /// Wide eyes with small pupils.
  final bool fear;
  final FishMouth mouth;

  /// 0–1 opacity of the sweat drop.
  final double sweat;

  static const idle = FishPose();
}

const clownfishViewBox = Size(164, 124);

class ClownfishArt {
  ClownfishArt._();

  static const _outline = Color(0xFF2B1D1A);
  static const _deg = 3.141592653589793 / 180;

  static final _body = Path()
    ..moveTo(54, 0)
    ..cubicTo(54, -31, 26, -45, -4, -43)
    ..cubicTo(-34, -41, -50, -21, -50, 0)
    ..cubicTo(-50, 21, -34, 41, -4, 43)
    ..cubicTo(26, 45, 54, 31, 54, 0)
    ..close();

  static final _tail = Path()
    ..moveTo(-44, 0)
    ..cubicTo(-58, -8, -66, -27, -77, -30)
    ..cubicTo(-83, -15, -81, -6, -72, 0)
    ..cubicTo(-81, 6, -83, 15, -77, 30)
    ..cubicTo(-66, 27, -58, 8, -44, 0)
    ..close();

  static final _tailStripe = Path()
    ..moveTo(-70, -24)
    ..cubicTo(-76, -14, -76, -6, -70, 0)
    ..cubicTo(-76, 6, -76, 14, -70, 24);

  static final _dorsal = Path()
    ..moveTo(-26, -36)
    ..cubicTo(-22, -58, 6, -62, 16, -40)
    ..close();

  static final _pelvic = Path()
    ..moveTo(-8, 38)
    ..cubicTo(-4, 54, 12, 56, 16, 37)
    ..close();

  static final _stripes = <Path>[
    Path()
      ..moveTo(8, -50)
      ..quadraticBezierTo(17, 0, 8, 50)
      ..lineTo(23, 50)
      ..quadraticBezierTo(31, 0, 23, -50)
      ..close(),
    Path()
      ..moveTo(-24, -50)
      ..quadraticBezierTo(-15, 0, -24, 50)
      ..lineTo(-10, 50)
      ..quadraticBezierTo(-2, 0, -10, -50)
      ..close(),
    Path()
      ..moveTo(-52, -50)
      ..quadraticBezierTo(-45, 0, -52, 50)
      ..lineTo(-42, 50)
      ..quadraticBezierTo(-36, 0, -42, -50)
      ..close(),
  ];

  static final _pec = Path()
    ..moveTo(4, 12)
    ..cubicTo(-10, 14, -18, 25, -12, 31)
    ..cubicTo(-3, 30, 6, 22, 4, 12)
    ..close();

  static final _smile = Path()
    ..moveTo(45, 6)
    ..quadraticBezierTo(49.5, 10.5, 53, 5.5);

  static final _sweat = Path()
    ..moveTo(-14, -48)
    ..cubicTo(-10, -42, -8, -38, -11, -35)
    ..cubicTo(-14, -32, -19, -35, -18, -39)
    ..cubicTo(-17.5, -42, -15, -45, -14, -48)
    ..close();

  static final _bodyShader = ui.Gradient.radial(
    const Offset(-14, -18),
    80,
    const [Color(0xFFFFB066), Color(0xFFFF7A2E), Color(0xFFF05A14)],
    const [0, 0.55, 1],
  );

  static Paint _stroke(double w, [Color c = _outline]) => Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = w
    ..color = c
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;

  static Paint get _orange => Paint()..shader = _bodyShader;

  static void _rotated(Canvas canvas, double deg, Offset pivot, void Function() draw) {
    canvas.save();
    canvas.translate(pivot.dx, pivot.dy);
    canvas.rotate(deg * _deg);
    canvas.translate(-pivot.dx, -pivot.dy);
    draw();
    canvas.restore();
  }

  /// Paints the fish facing right, filling [size] (aspect 164:124).
  static void paint(Canvas canvas, Size size, FishPose pose) {
    final k = size.width / clownfishViewBox.width;
    canvas.save();
    canvas.scale(k);
    canvas.translate(82, 62);

    // tail
    _rotated(canvas, pose.tailAngle, const Offset(-44, 0), () {
      canvas.drawPath(_tail, _orange);
      canvas.drawPath(_tail, _stroke(2.4));
      canvas.drawPath(_tailStripe, _stroke(3.5, const Color(0xFFFFFFFF)));
    });

    // dorsal + pelvic fins (behind body)
    _rotated(canvas, pose.dorsalAngle, const Offset(-5, -38), () {
      canvas.drawPath(_dorsal, _orange);
      canvas.drawPath(_dorsal, _stroke(2.4));
    });
    canvas.drawPath(_pelvic, _orange);
    canvas.drawPath(_pelvic, _stroke(2.4));

    // body + clipped stripes
    canvas.drawPath(_body, _orange);
    canvas.save();
    canvas.clipPath(_body);
    final white = Paint()..color = const Color(0xFFFFFFFF);
    for (final s in _stripes) {
      canvas.drawPath(s, white);
      canvas.drawPath(s, _stroke(2.6));
    }
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(14, -26), width: 60, height: 18),
      Paint()..color = const Color(0x47FFFFFF),
    );
    canvas.restore();
    canvas.drawPath(_body, _stroke(2.6));

    // cheek
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(36, 12), width: 13, height: 7.6),
      Paint()..color = const Color(0x8CFF5F8A),
    );

    // eye
    canvas.save();
    canvas.translate(32, -9);
    final eyeScale = pose.fear ? 1.15 : 1.0;
    canvas.scale(eyeScale, pose.fear ? 1.15 : pose.eyeScaleY);
    canvas.drawCircle(Offset.zero, 13, white);
    canvas.drawCircle(Offset.zero, 13, _stroke(2.4));
    canvas.drawCircle(
      pose.fear ? const Offset(1, 0.5) : const Offset(2.5, 0.5),
      pose.fear ? 4.2 : 8.5,
      Paint()..color = _outline,
    );
    canvas.drawCircle(const Offset(5.5, -3.5), 3, white);
    canvas.drawCircle(const Offset(-0.5, 4), 1.4, white);
    canvas.restore();

    // mouth
    switch (pose.mouth) {
      case FishMouth.smile:
        canvas.drawPath(_smile, _stroke(2.4));
      case FishMouth.open:
        canvas.drawOval(Rect.fromCenter(center: const Offset(50, 6), width: 8, height: 10), Paint()..color = _outline);
        canvas.drawOval(
          Rect.fromCenter(center: const Offset(50, 8.5), width: 5, height: 4),
          Paint()..color = const Color(0xFFFF7F9E),
        );
      case FishMouth.o:
        canvas.drawOval(Rect.fromCenter(center: const Offset(50.5, 6), width: 5.2, height: 6.4), Paint()..color = _outline);
    }

    // pectoral fin (front)
    _rotated(canvas, pose.pecAngle, const Offset(4, 12), () {
      canvas.drawPath(_pec, Paint()..color = const Color(0xFFFF9A52));
      canvas.drawPath(_pec, _stroke(2.2));
    });

    // sweat drop
    if (pose.sweat > 0) {
      final a = (pose.sweat.clamp(0, 1) * 255).round();
      canvas.drawPath(_sweat, Paint()..color = Color.fromARGB(a, 0xBF, 0xEA, 0xFF));
      canvas.drawPath(_sweat, _stroke(1.6, Color.fromARGB(a, 0x3A, 0x87, 0xB5)));
    }

    canvas.restore();
  }
}

class ClownfishPainter extends CustomPainter {
  const ClownfishPainter({this.pose = FishPose.idle});

  final FishPose pose;

  @override
  void paint(Canvas canvas, Size size) => ClownfishArt.paint(canvas, size, pose);

  @override
  bool shouldRepaint(ClownfishPainter oldDelegate) => oldDelegate.pose != pose;
}
