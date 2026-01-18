// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/modules/storage_module.dart' as _i213;
import 'core/theme/colors/i_app_color.dart' as _i884;
import 'core/theme/colors/light_colors.dart' as _i45;
import 'core/theme/gaps/app_gap.dart' as _i403;
import 'core/theme/gaps/i_app_gap.dart' as _i513;
import 'core/theme/typography/app_typography.dart' as _i630;
import 'core/theme/typography/i_app_typography.dart' as _i889;
import 'data/datasources/i_name_datasource.dart' as _i397;
import 'data/datasources/local/local_name_datasource.dart' as _i672;
import 'data/repositories/favorite/favorite_name_repository_impl.dart' as _i856;
import 'data/repositories/name/name_repository_impl.dart' as _i751;
import 'database.dart' as _i969;
import 'domain/repositories/favorite/i_favorite_name_repository.dart' as _i1034;
import 'domain/repositories/name/i_name_repository.dart' as _i420;
import 'domain/usecases/favorite/add_name_to_favorite_usecase.dart' as _i39;
import 'domain/usecases/favorite/get_favorite_names_usecase.dart' as _i827;
import 'domain/usecases/favorite/remove_name_to_favorite_usecase.dart' as _i536;
import 'domain/usecases/name/get_name_usecase.dart' as _i606;
import 'domain/usecases/name/get_names_usecase.dart' as _i420;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    gh.singleton<_i969.AppDatabase>(
      () => storageModule.instance,
      instanceName: 'db',
    );
    gh.singleton<_i513.IAppGap>(() => _i403.AppGap());
    gh.singleton<_i884.IAppColor>(() => _i45.LightColor());
    gh.singleton<_i889.IAppTypography>(() => _i630.AppTypography());
    gh.singleton<_i397.INameDatasource>(() => _i672.LocalNameDatasourceImpl(
        gh<_i969.AppDatabase>(instanceName: 'db')));
    gh.singleton<_i420.INameRepository>(
        () => _i751.NameRepositoryImpl(gh<_i397.INameDatasource>()));
    gh.singleton<_i1034.IFavoriteNameRepository>(
        () => _i856.FavoriteNameRepositoryImpl(gh<_i397.INameDatasource>()));
    gh.singleton<_i606.GetNameUsecase>(
        () => _i606.GetNameUsecase(gh<_i420.INameRepository>()));
    gh.singleton<_i420.GetNamesUsecase>(
        () => _i420.GetNamesUsecase(gh<_i420.INameRepository>()));
    gh.singleton<_i39.AddNameToFavoriteUsecase>(() =>
        _i39.AddNameToFavoriteUsecase(gh<_i1034.IFavoriteNameRepository>()));
    gh.singleton<_i827.GetFavoriteNamesUsecase>(() =>
        _i827.GetFavoriteNamesUsecase(gh<_i1034.IFavoriteNameRepository>()));
    gh.singleton<_i536.RemoveNameToFavoriteUsecase>(() =>
        _i536.RemoveNameToFavoriteUsecase(
            gh<_i1034.IFavoriteNameRepository>()));
    return this;
  }
}

class _$StorageModule extends _i213.StorageModule {}
