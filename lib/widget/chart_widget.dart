import 'dart:math';
import 'package:expenses_manager/theme/style.dart';
import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  final List<PieChartData> data;

  const PieChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(200))),
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: Text(
                  '0.00 €',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ))
        : Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(200))),
            child: Padding(
                padding: const EdgeInsets.all(3),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final centerX = constraints.maxWidth / 2;
                      final centerY = constraints.maxHeight / 2;
                      final radius = min(centerX, centerY);

                      return Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: PieChartPainter(data),
                            ),
                          ),
                          Positioned(
                            left: centerX - radius,
                            top: centerY - radius,
                            width: radius * 2,
                            height: radius * 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(300))),
                                  child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          'Totale: \n ${data.fold<double>(0.0, (sum, entry) => sum + entry.value).toStringAsFixed(2)} €',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )));
  }
}

class PieChartPainter extends CustomPainter {
  final List<PieChartData> data;

  PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(center.dx, center.dy);

    double total = data.fold(0.0, (acc, d) => acc + d.value);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -pi / 2;
    double currentAngle = startAngle;

    for (final d in data) {
      final sweepAngle = 2 * pi * (d.value / total);
      final color = d.color;
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      canvas.drawArc(rect, currentAngle, sweepAngle, true, paint);
      final labelPercentage = "${(d.value / total * 100).toStringAsFixed(1)}%";
      const textStyle = TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: kTextColor,
        backgroundColor: Colors.white,
      );
      final labelPainter = TextPainter(
        text: TextSpan(
          text: labelPercentage,
          style: textStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      final labelWidth = labelPainter.width;
      final labelHeight = labelPainter.height;
      final labelX = center.dx +
          (radius + 20) * 0.75 * cos(currentAngle + sweepAngle / 2) -
          labelWidth /
              2; // Aggiungi un offset di 20 pixel dal bordo del grafico
      final labelY = center.dy +
          (radius + 20) * 0.75 * sin(currentAngle + sweepAngle / 2) -
          labelHeight / 2;
      final labelOffset = Offset(
        labelX,
        labelY,
      );
      labelPainter.paint(canvas, labelOffset);
      currentAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(PieChartPainter oldDelegate) {
    return false;
  }
}

class PieChartData {
  final double value;
  final Color color;

  const PieChartData({required this.value, required this.color});
}
