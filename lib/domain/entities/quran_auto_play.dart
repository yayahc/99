import 'package:equatable/equatable.dart';

class QuranAutoPlay extends Equatable {
  final bool enabled;
  final double volume;

  const QuranAutoPlay({required this.enabled, required this.volume});

  const QuranAutoPlay.disabled()
      : enabled = false,
        volume = 0.2;

  QuranAutoPlay copyWith({bool? enabled, double? volume}) => QuranAutoPlay(
        enabled: enabled ?? this.enabled,
        volume: volume ?? this.volume,
      );

  @override
  List<Object?> get props => [enabled, volume];
}
