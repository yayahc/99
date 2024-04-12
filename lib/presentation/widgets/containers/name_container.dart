import 'package:flutter/material.dart';
import 'package:ninety/core/extensions/string_extension.dart';
import 'package:sizer/sizer.dart';
import '../../../models/name.dart';

class NameContainer extends StatelessWidget {
  final Name nameData;
  const NameContainer({super.key, required this.nameData});

  @override
  Container build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      color: Colors.teal,
      child: ListTile(
        title: nameData.transliteration.asWidget(),
      ),
    );
  }
}
