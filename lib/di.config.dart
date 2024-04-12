// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import 'core/modules/storage_module.dart' as _i14;
import 'core/theme/gaps/app_gap.dart' as _i4;
import 'core/theme/gaps/i_app_gap.dart' as _i3;
import 'core/theme/typography/app_typography.dart' as _i6;
import 'core/theme/typography/i_app_typography.dart' as _i5;
import 'data/datasources/i_name_datasource.dart' as _i8;
import 'data/datasources/local/local_name_datasource.dart' as _i9;
import 'data/repositories/name/name_repository_impl.dart' as _i11;
import 'domain/repositories/name/i_name_repository.dart' as _i10;
import 'domain/usecases/name/get_name_usecase.dart' as _i12;
import 'domain/usecases/name/get_names_usecase.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    gh.singleton<_i3.IAppGap>(() => _i4.AppGap());
    gh.singleton<_i5.IAppTypography>(() => _i6.AppTypography());
    await gh.singletonAsync<_i7.SharedPreferences>(
      () => storageModule.instance,
      instanceName: 'pref',
      preResolve: true,
    );
    gh.singleton<_i8.INameDatasource>(() => _i9.LocalNameDatasourceImpl(
        gh<_i7.SharedPreferences>(instanceName: 'pref')));
    gh.singleton<_i10.INameRepository>(
        () => _i11.NameRepositoryImpl(gh<_i8.INameDatasource>()));
    gh.singleton<_i12.GetNameUsecase>(
        () => _i12.GetNameUsecase(gh<_i10.INameRepository>()));
    gh.singleton<_i13.GetNamesUsecase>(
        () => _i13.GetNamesUsecase(gh<_i10.INameRepository>()));
    return this;
  }
}

class _$StorageModule extends _i14.StorageModule {}
