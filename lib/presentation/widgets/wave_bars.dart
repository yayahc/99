import 'dart:math' as math;

import 'package:flutter/material.dart';

class WaveBars extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final int barCount;

  const WaveBars({
    super.key,
    required this.color,
    this.width = 18,
    this.height = 18,
    this.barCount = 4,
  });

  @override
  State<WaveBars> createState() => _WaveBarsState();
}

class _WaveBarsState extends State<WaveBars>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barWidth = widget.width / (widget.barCount * 2 - 1);
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(widget.barCount, (i) {
              final phase = i * math.pi / 2;
              final h = 0.30 +
                  0.70 * (0.5 + 0.5 * math.sin(_c.value * 2 * math.pi + phase));
              return Container(
                width: barWidth,
                height: widget.height * h,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(barWidth),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
