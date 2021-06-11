import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
  @override
  _CircularProgressPageState createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  double percentage = 0;
  double newPercentage = 0.0;

  @override
  void initState() {
    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));

    controller.addListener(() {
      setState(() {
        percentage = lerpDouble(percentage, newPercentage, controller.value);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.orange.shade800,
        onPressed: () {
          setState(() {
            percentage = newPercentage;
            newPercentage += 10;
            if (newPercentage > 100) {
              newPercentage = 0;
              percentage = 0;
            }
            controller.forward(from: 0.0);
          });
        },
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 300,
          height: 300,
          //color: Colors.red,
          child: CustomPaint(
            child: Center(
              child: TextPercentage(percentage: percentage),
            ),
            painter: _RadialProgress(percentage),
          ),
        ),
      ),
    );
  }
}

class TextPercentage extends StatelessWidget {
  TextPercentage({@required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${percentage.toStringAsFixed(1)}%',
      style: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey.shade300,
      ),
    );
  }
}

class _RadialProgress extends CustomPainter {
  final percentage;

  _RadialProgress(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..strokeWidth = 4
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke;

    Offset center = new Offset(size.width * 0.5, size.height / 2);
    double radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    final paintArc = new Paint()
      ..strokeWidth = 10
      ..color = Colors.orange.shade800
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
