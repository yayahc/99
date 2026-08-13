import 'package:injectable/injectable.dart';
import 'package:ninety/data/datasources/local/surahs_data.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/get_quran_auto_play_param.dart';
import 'package:ninety/domain/usecases/settings/get_quran_auto_play_usecase.dart';
import 'package:ninety/services/quran_audio/quran_audio_controller.dart';

@singleton
class QuranAutoPlayService {
  final GetQuranAutoPlayUsecase _getQuranAutoPlayUsecase;
  final QuranAudioController _controller;

  bool _alreadyRan = false;

  QuranAutoPlayService(this._getQuranAutoPlayUsecase, this._controller);

  Future<void> startIfEnabled() async {
    if (_alreadyRan) return;
    _alreadyRan = true;

    final result =
        await _getQuranAutoPlayUsecase.trigger(GetQuranAutoPlayParam());
    final settings =
        result.fold((_) => const QuranAutoPlay.disabled(), (value) => value);

    if (!settings.enabled || settings.volume <= 0) return;
    if (_controller.current != null) return;

    await _controller.playInBackground(SurahsData.all.first, settings.volume);
  }
}
