import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hours/core/constant/app_colors.dart';

class AnalogClock extends StatefulWidget {
  const AnalogClock({
    super.key,
  });

  @override
  State<AnalogClock> createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime _dateTime = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.4,
      width: height * 0.4,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 20,
                color: Colors.grey.withOpacity(0.50)),
          ],
          border: Border.all(color: AppColors.secondColors),
          image: const DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/clock.png"))),
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(_dateTime),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);
  @override
  void paint(Canvas canvas, Size size) {
    double centerx = size.width / 2;
    double centery = size.height / 2;
    Offset center = Offset(centerx, centery);
//minute calculation
    double minx =
        centerx + size.width * 0.32 * cos((dateTime.minute * 6) * pi / 180);
    double miny =
        centery + size.width * 0.32 * sin((dateTime.minute * 6) * pi / 180);
//hour calculation
//dateTime.hour * 30  because 360/12=30
//dateTime.minute * 0.5 each minute we want to turn our hour line a little
    double hourx = centerx +
        size.width *
            0.23 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double houry = centery +
        size.width *
            0.23 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
//second calculation
//size.width * 0.4 define our line height
//dateTime.second * 6 because 360/60=6
    double secondX =
        centerx + size.width * 0.4 * cos((dateTime.second * 6) * pi / 180);
    double secondY =
        centery + size.width * 0.4 * sin((dateTime.second * 6) * pi / 180);
//minute line
    canvas.drawLine(
        center,
        Offset(minx, miny),
        Paint()
          ..color = AppColors.firstColors.withOpacity(0.50)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round);
//hour line
    canvas.drawLine(
        center,
        Offset(hourx, houry),
        Paint()
          ..color = AppColors.firstColors
          ..style = PaintingStyle.stroke
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round);
//second line
    canvas.drawLine(center, Offset(secondX, secondY),
        Paint()..color = AppColors.secondColors);
//center Dots
    Paint dotPinter = Paint()..color = AppColors.secondColors;
    canvas.drawCircle(center, 14, dotPinter);
    canvas.drawCircle(center, 13, Paint()..color = Colors.white);
    canvas.drawCircle(center, 5, dotPinter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
