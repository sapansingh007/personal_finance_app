import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SimpleBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color? barColor;
  final double height;

  const SimpleBarChart({
    super.key,
    required this.data,
    required this.labels,
    this.barColor,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || labels.isEmpty || data.length != labels.length) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text('No data available'),
        ),
      );
    }

    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final chartColor = barColor ?? Theme.of(context).colorScheme.primary;

    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Overview',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildBar(
                      value: data[index],
                      maxValue: maxValue,
                      label: labels[index],
                      color: chartColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                labels.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    width: 32,
                    child: Text(
                      labels[index],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar({
    required double value,
    required double maxValue,
    required String label,
    required Color color,
  }) {
    final availableHeight = 80.0; // Reduced from 120 to prevent overflow
    final barHeight = maxValue > 0 ? (value / maxValue) * availableHeight : 0;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: barHeight.toDouble(),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '\$${value.toInt()}',
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class SimplePieChart extends StatelessWidget {
  final Map<String, double> data;
  final double size;
  final List<Color>? colors;

  const SimplePieChart({
    super.key,
    required this.data,
    this.size = 150,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return SizedBox(
        width: size,
        height: size,
        child: const Center(
          child: Text('No data available'),
        ),
      );
    }

    final total = data.values.reduce((a, b) => a + b);
    final defaultColors = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.warning,
      AppColors.expense,
      AppColors.food,
      AppColors.transport,
    ];
    final chartColors = colors ?? defaultColors;

    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PieChartPainter(
          data: data,
          total: total,
          colors: chartColors,
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final Map<String, double> data;
  final double total;
  final List<Color> colors;

  _PieChartPainter({
    required this.data,
    required this.total,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;
    
    double startAngle = -math.pi / 2;
    int colorIndex = 0;

    data.forEach((key, value) {
      final sweepAngle = (value / total) * 2 * math.pi;
      
      final paint = Paint()
        ..color = colors[colorIndex % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
      colorIndex++;
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
