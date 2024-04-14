/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsAudiosGen {
  const $AssetsAudiosGen();

  /// File path: assets/audios/eight.wav
  String get eight => 'assets/audios/eight.wav';

  /// File path: assets/audios/eighteen.wav
  String get eighteen => 'assets/audios/eighteen.wav';

  /// File path: assets/audios/eleven.wav
  String get eleven => 'assets/audios/eleven.wav';

  /// File path: assets/audios/fifteen.wav
  String get fifteen => 'assets/audios/fifteen.wav';

  /// File path: assets/audios/five.wav
  String get five => 'assets/audios/five.wav';

  /// File path: assets/audios/four.wav
  String get four => 'assets/audios/four.wav';

  /// File path: assets/audios/fourteen.wav
  String get fourteen => 'assets/audios/fourteen.wav';

  /// File path: assets/audios/nine.wav
  String get nine => 'assets/audios/nine.wav';

  /// File path: assets/audios/nineteen.wav
  String get nineteen => 'assets/audios/nineteen.wav';

  /// File path: assets/audios/one.wav
  String get one => 'assets/audios/one.wav';

  /// File path: assets/audios/seven.wav
  String get seven => 'assets/audios/seven.wav';

  /// File path: assets/audios/seventeen.wav
  String get seventeen => 'assets/audios/seventeen.wav';

  /// File path: assets/audios/six.wav
  String get six => 'assets/audios/six.wav';

  /// File path: assets/audios/sixteen.wav
  String get sixteen => 'assets/audios/sixteen.wav';

  /// File path: assets/audios/ten.wav
  String get ten => 'assets/audios/ten.wav';

  /// File path: assets/audios/thirteen.wav
  String get thirteen => 'assets/audios/thirteen.wav';

  /// File path: assets/audios/three.wav
  String get three => 'assets/audios/three.wav';

  /// File path: assets/audios/twelve.wav
  String get twelve => 'assets/audios/twelve.wav';

  /// File path: assets/audios/twenty.wav
  String get twenty => 'assets/audios/twenty.wav';

  /// File path: assets/audios/two.wav
  String get two => 'assets/audios/two.wav';

  /// List of all assets
  List<String> get values => [
        eight,
        eighteen,
        eleven,
        fifteen,
        five,
        four,
        fourteen,
        nine,
        nineteen,
        one,
        seven,
        seventeen,
        six,
        sixteen,
        ten,
        thirteen,
        three,
        twelve,
        twenty,
        two
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/separator.svg
  SvgGenImage get separator => const SvgGenImage('assets/svgs/separator.svg');

  /// List of all assets
  List<SvgGenImage> get values => [separator];
}

class Assets {
  Assets._();

  static const $AssetsAudiosGen audios = $AssetsAudiosGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
