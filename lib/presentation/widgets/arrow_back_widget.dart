import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ninety/core/extensions/context_extension.dart';

class ArrowBackWidget extends StatelessWidget {
  const ArrowBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pop(),
      child: Container(
        alignment: Alignment.center,
        child: Icon(Icons.arrow_back, color: context.colors.black),
      ),
    );
  }
}
