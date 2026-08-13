import 'package:bloc/bloc.dart';
import 'package:ninety/domain/entities/quran_auto_play.dart';
import 'package:ninety/domain/params/settings/get_quran_auto_play_param.dart';
import 'package:ninety/domain/params/settings/set_quran_auto_play_param.dart';
import 'package:ninety/domain/usecases/settings/get_quran_auto_play_usecase.dart';
import 'package:ninety/domain/usecases/settings/set_quran_auto_play_usecase.dart';
import 'package:ninety/services/quran_audio/quran_audio_controller.dart';

class QuranAutoPlayCubit extends Cubit<QuranAutoPlay> {
  final GetQuranAutoPlayUsecase _getQuranAutoPlayUsecase;
  final SetQuranAutoPlayUsecase _setQuranAutoPlayUsecase;
  final QuranAudioController _audioController;

  QuranAutoPlayCubit(
    this._getQuranAutoPlayUsecase,
    this._setQuranAutoPlayUsecase,
    this._audioController,
  ) : super(const QuranAutoPlay.disabled());

  Future<void> loadAutoPlay() async {
    final result =
        await _getQuranAutoPlayUsecase.trigger(GetQuranAutoPlayParam());
    result.fold((_) => emit(const QuranAutoPlay.disabled()), emit);
  }

  Future<void> setEnabled(bool enabled) async {
    if (!enabled &&
        _audioController.startedAutomatically &&
        _audioController.current != null) {
      await _audioController.stop();
    }
    await _save(state.copyWith(enabled: enabled));
  }

  void previewVolume(double volume) {
    emit(state.copyWith(volume: volume));
    if (_audioController.startedAutomatically) {
      _audioController.setVolume(volume);
    }
  }

  Future<void> commitVolume(double volume) => _save(state.copyWith(
        volume: volume,
      ));

  Future<void> _save(QuranAutoPlay autoPlay) async {
    emit(autoPlay);
    await _setQuranAutoPlayUsecase.trigger(SetQuranAutoPlayParam(autoPlay));
  }
}
