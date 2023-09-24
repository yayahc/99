import 'package:get_it/get_it.dart';
import 'package:ninety/core/common/app_assets/app_assets.dart';
import 'package:ninety/core/error/app_error.dart';
import 'package:ninety/core/theme/colors/i_app_colors.dart';
import 'package:ninety/core/theme/colors/light_colors_impl.dart';
import 'package:ninety/core/usescase/usescase.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/arabe/arabe_name.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/english/english_name.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/french/french_name.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/local_names.dart';
import 'package:ninety/features/name/data/datasources/local_data_sources/name/name_local_datasource_impl.dart';
import 'package:ninety/features/name/data/models/i_name_model.dart';
import 'package:ninety/features/name/data/models/name.dart';
import 'package:ninety/features/name/data/repositories/i_name_data_sources_repository.dart';
import 'package:ninety/features/name/data/repositories/name_repository_impl.dart';
import 'package:ninety/features/name/domain/entities/doua/doua.dart';
import 'package:ninety/features/name/domain/entities/name/name.dart';
import 'package:ninety/features/name/domain/repositories/name_repository/i_name_repository.dart';
import 'package:ninety/features/name/domain/usescases/name_usescases/get_names_usescase.dart';
import 'package:ninety/features/name/presentation/cubit/name_cubit.dart';

final GetIt locator = GetIt.instance;

void configureDependencie() {
  locator.registerSingleton<AudioAssets>(AudioAssets());
  locator.registerSingleton<ArabeNames>(ArabeNames());
  locator.registerSingleton<NameModel>(NameModel(
      id: 0,
      arabe: 'arabe',
      transliteration: 'transliteration',
      translationInAr: 'translationInAr',
      translationInEn: 'translationInEn',
      translationInFr: 'translationInFr',
      details: 'details',
      benefite: 'benefite',
      reference: 'reference',
      audioPath: 'audioPath',
      imagePath: 'imagePath',
      sampleDouas: <Doua>[]));
  locator.registerSingleton<EnglishNames>(EnglishNames());
  locator.registerSingleton<NameCubit>(NameCubit(
      NameCubitState('lang', <ITranslationModel>[]),
      GetNamesUsesCase(NameRepositoryImpl(NameLocalDataSourceImpl()))));
  locator.resetLazySingleton<NameCubitState>(
      instance: NameCubitState('lang', <ITranslationModel>[]));
  locator.registerSingleton<FrenchNames>(FrenchNames());
  locator.registerLazySingleton<UsesCase>(
      () => GetNamesUsesCase(NameRepositoryImpl(NameLocalDataSourceImpl())));
  locator.registerLazySingleton<INameRepository>(
      () => NameRepositoryImpl(NameLocalDataSourceImpl()));
  locator.registerSingleton<Name>(Name(
      id: 0,
      arabe: 'arabe',
      transliteration: 'transliteration',
      translationInAr: 'translationInAr',
      translationInEn: 'translationInEn',
      translationInFr: 'translationInFr',
      details: 'details',
      benefite: 'benefite',
      reference: 'reference',
      audioPath: 'audioPath',
      imagePath: 'imagePath'));
  locator.registerSingleton<LocalNames>(LocalNames());
  locator.resetLazySingleton<ITranslationModel>(
      instance: GenericTranslationModel(
          benefite: 'benefite',
          details: 'details',
          id: 0,
          arabe: 'arabe',
          sampleDoua: <Doua>[],
          translation: 'translation',
          imagePath: 'imagePath',
          audioPath: 'audioPath',
          reference: 'reference',
          transliteration: 'transliteration'));
  locator.resetLazySingleton<INameDataSource>(
      instance: NameLocalDataSourceImpl());
  locator.registerSingleton<IAppColors>(LightColorsImpl());
  locator
      .registerLazySingleton<AppError>(() => GenericAppError('_errorMessage'));
}
