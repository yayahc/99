// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FavoriteNameModelTable extends FavoriteNameModel
    with TableInfo<$FavoriteNameModelTable, FavoriteNameModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteNameModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_name_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<FavoriteNameModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteNameModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteNameModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
    );
  }

  @override
  $FavoriteNameModelTable createAlias(String alias) {
    return $FavoriteNameModelTable(attachedDatabase, alias);
  }
}

class FavoriteNameModelData extends DataClass
    implements Insertable<FavoriteNameModelData> {
  final int id;
  const FavoriteNameModelData({required this.id});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    return map;
  }

  FavoriteNameModelCompanion toCompanion(bool nullToAbsent) {
    return FavoriteNameModelCompanion(
      id: Value(id),
    );
  }

  factory FavoriteNameModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteNameModelData(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  FavoriteNameModelData copyWith({int? id}) => FavoriteNameModelData(
        id: id ?? this.id,
      );
  FavoriteNameModelData copyWithCompanion(FavoriteNameModelCompanion data) {
    return FavoriteNameModelData(
      id: data.id.present ? data.id.value : this.id,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteNameModelData(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => id.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteNameModelData && other.id == this.id);
}

class FavoriteNameModelCompanion
    extends UpdateCompanion<FavoriteNameModelData> {
  final Value<int> id;
  const FavoriteNameModelCompanion({
    this.id = const Value.absent(),
  });
  FavoriteNameModelCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<FavoriteNameModelData> custom({
    Expression<int>? id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  FavoriteNameModelCompanion copyWith({Value<int>? id}) {
    return FavoriteNameModelCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteNameModelCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsModelTable extends AppSettingsModel
    with TableInfo<$AppSettingsModelTable, AppSettingsModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('system'));
  static const VerificationMeta _autoPlayQuranMeta =
      const VerificationMeta('autoPlayQuran');
  @override
  late final GeneratedColumn<bool> autoPlayQuran = GeneratedColumn<bool>(
      'auto_play_quran', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("auto_play_quran" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _autoPlayQuranVolumeMeta =
      const VerificationMeta('autoPlayQuranVolume');
  @override
  late final GeneratedColumn<double> autoPlayQuranVolume =
      GeneratedColumn<double>('auto_play_quran_volume', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0.2));
  @override
  List<GeneratedColumn> get $columns =>
      [id, themeMode, autoPlayQuran, autoPlayQuranVolume];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_model';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppSettingsModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('auto_play_quran')) {
      context.handle(
          _autoPlayQuranMeta,
          autoPlayQuran.isAcceptableOrUnknown(
              data['auto_play_quran']!, _autoPlayQuranMeta));
    }
    if (data.containsKey('auto_play_quran_volume')) {
      context.handle(
          _autoPlayQuranVolumeMeta,
          autoPlayQuranVolume.isAcceptableOrUnknown(
              data['auto_play_quran_volume']!, _autoPlayQuranVolumeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      autoPlayQuran: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}auto_play_quran'])!,
      autoPlayQuranVolume: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}auto_play_quran_volume'])!,
    );
  }

  @override
  $AppSettingsModelTable createAlias(String alias) {
    return $AppSettingsModelTable(attachedDatabase, alias);
  }
}

class AppSettingsModelData extends DataClass
    implements Insertable<AppSettingsModelData> {
  final int id;
  final String themeMode;
  final bool autoPlayQuran;
  final double autoPlayQuranVolume;
  const AppSettingsModelData(
      {required this.id,
      required this.themeMode,
      required this.autoPlayQuran,
      required this.autoPlayQuranVolume});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme_mode'] = Variable<String>(themeMode);
    map['auto_play_quran'] = Variable<bool>(autoPlayQuran);
    map['auto_play_quran_volume'] = Variable<double>(autoPlayQuranVolume);
    return map;
  }

  AppSettingsModelCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsModelCompanion(
      id: Value(id),
      themeMode: Value(themeMode),
      autoPlayQuran: Value(autoPlayQuran),
      autoPlayQuranVolume: Value(autoPlayQuranVolume),
    );
  }

  factory AppSettingsModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsModelData(
      id: serializer.fromJson<int>(json['id']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      autoPlayQuran: serializer.fromJson<bool>(json['autoPlayQuran']),
      autoPlayQuranVolume:
          serializer.fromJson<double>(json['autoPlayQuranVolume']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'themeMode': serializer.toJson<String>(themeMode),
      'autoPlayQuran': serializer.toJson<bool>(autoPlayQuran),
      'autoPlayQuranVolume': serializer.toJson<double>(autoPlayQuranVolume),
    };
  }

  AppSettingsModelData copyWith(
          {int? id,
          String? themeMode,
          bool? autoPlayQuran,
          double? autoPlayQuranVolume}) =>
      AppSettingsModelData(
        id: id ?? this.id,
        themeMode: themeMode ?? this.themeMode,
        autoPlayQuran: autoPlayQuran ?? this.autoPlayQuran,
        autoPlayQuranVolume: autoPlayQuranVolume ?? this.autoPlayQuranVolume,
      );
  AppSettingsModelData copyWithCompanion(AppSettingsModelCompanion data) {
    return AppSettingsModelData(
      id: data.id.present ? data.id.value : this.id,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      autoPlayQuran: data.autoPlayQuran.present
          ? data.autoPlayQuran.value
          : this.autoPlayQuran,
      autoPlayQuranVolume: data.autoPlayQuranVolume.present
          ? data.autoPlayQuranVolume.value
          : this.autoPlayQuranVolume,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsModelData(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('autoPlayQuran: $autoPlayQuran, ')
          ..write('autoPlayQuranVolume: $autoPlayQuranVolume')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, themeMode, autoPlayQuran, autoPlayQuranVolume);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsModelData &&
          other.id == this.id &&
          other.themeMode == this.themeMode &&
          other.autoPlayQuran == this.autoPlayQuran &&
          other.autoPlayQuranVolume == this.autoPlayQuranVolume);
}

class AppSettingsModelCompanion extends UpdateCompanion<AppSettingsModelData> {
  final Value<int> id;
  final Value<String> themeMode;
  final Value<bool> autoPlayQuran;
  final Value<double> autoPlayQuranVolume;
  const AppSettingsModelCompanion({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.autoPlayQuran = const Value.absent(),
    this.autoPlayQuranVolume = const Value.absent(),
  });
  AppSettingsModelCompanion.insert({
    this.id = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.autoPlayQuran = const Value.absent(),
    this.autoPlayQuranVolume = const Value.absent(),
  });
  static Insertable<AppSettingsModelData> custom({
    Expression<int>? id,
    Expression<String>? themeMode,
    Expression<bool>? autoPlayQuran,
    Expression<double>? autoPlayQuranVolume,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (themeMode != null) 'theme_mode': themeMode,
      if (autoPlayQuran != null) 'auto_play_quran': autoPlayQuran,
      if (autoPlayQuranVolume != null)
        'auto_play_quran_volume': autoPlayQuranVolume,
    });
  }

  AppSettingsModelCompanion copyWith(
      {Value<int>? id,
      Value<String>? themeMode,
      Value<bool>? autoPlayQuran,
      Value<double>? autoPlayQuranVolume}) {
    return AppSettingsModelCompanion(
      id: id ?? this.id,
      themeMode: themeMode ?? this.themeMode,
      autoPlayQuran: autoPlayQuran ?? this.autoPlayQuran,
      autoPlayQuranVolume: autoPlayQuranVolume ?? this.autoPlayQuranVolume,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (autoPlayQuran.present) {
      map['auto_play_quran'] = Variable<bool>(autoPlayQuran.value);
    }
    if (autoPlayQuranVolume.present) {
      map['auto_play_quran_volume'] =
          Variable<double>(autoPlayQuranVolume.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsModelCompanion(')
          ..write('id: $id, ')
          ..write('themeMode: $themeMode, ')
          ..write('autoPlayQuran: $autoPlayQuran, ')
          ..write('autoPlayQuranVolume: $autoPlayQuranVolume')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteNameModelTable favoriteNameModel =
      $FavoriteNameModelTable(this);
  late final $AppSettingsModelTable appSettingsModel =
      $AppSettingsModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [favoriteNameModel, appSettingsModel];
}

typedef $$FavoriteNameModelTableCreateCompanionBuilder
    = FavoriteNameModelCompanion Function({
  Value<int> id,
});
typedef $$FavoriteNameModelTableUpdateCompanionBuilder
    = FavoriteNameModelCompanion Function({
  Value<int> id,
});

class $$FavoriteNameModelTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteNameModelTable> {
  $$FavoriteNameModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));
}

class $$FavoriteNameModelTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteNameModelTable> {
  $$FavoriteNameModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));
}

class $$FavoriteNameModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteNameModelTable> {
  $$FavoriteNameModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);
}

class $$FavoriteNameModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FavoriteNameModelTable,
    FavoriteNameModelData,
    $$FavoriteNameModelTableFilterComposer,
    $$FavoriteNameModelTableOrderingComposer,
    $$FavoriteNameModelTableAnnotationComposer,
    $$FavoriteNameModelTableCreateCompanionBuilder,
    $$FavoriteNameModelTableUpdateCompanionBuilder,
    (
      FavoriteNameModelData,
      BaseReferences<_$AppDatabase, $FavoriteNameModelTable,
          FavoriteNameModelData>
    ),
    FavoriteNameModelData,
    PrefetchHooks Function()> {
  $$FavoriteNameModelTableTableManager(
      _$AppDatabase db, $FavoriteNameModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteNameModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteNameModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteNameModelTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
          }) =>
              FavoriteNameModelCompanion(
            id: id,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
          }) =>
              FavoriteNameModelCompanion.insert(
            id: id,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FavoriteNameModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FavoriteNameModelTable,
    FavoriteNameModelData,
    $$FavoriteNameModelTableFilterComposer,
    $$FavoriteNameModelTableOrderingComposer,
    $$FavoriteNameModelTableAnnotationComposer,
    $$FavoriteNameModelTableCreateCompanionBuilder,
    $$FavoriteNameModelTableUpdateCompanionBuilder,
    (
      FavoriteNameModelData,
      BaseReferences<_$AppDatabase, $FavoriteNameModelTable,
          FavoriteNameModelData>
    ),
    FavoriteNameModelData,
    PrefetchHooks Function()>;
typedef $$AppSettingsModelTableCreateCompanionBuilder
    = AppSettingsModelCompanion Function({
  Value<int> id,
  Value<String> themeMode,
  Value<bool> autoPlayQuran,
  Value<double> autoPlayQuranVolume,
});
typedef $$AppSettingsModelTableUpdateCompanionBuilder
    = AppSettingsModelCompanion Function({
  Value<int> id,
  Value<String> themeMode,
  Value<bool> autoPlayQuran,
  Value<double> autoPlayQuranVolume,
});

class $$AppSettingsModelTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsModelTable> {
  $$AppSettingsModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get autoPlayQuran => $composableBuilder(
      column: $table.autoPlayQuran, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get autoPlayQuranVolume => $composableBuilder(
      column: $table.autoPlayQuranVolume,
      builder: (column) => ColumnFilters(column));
}

class $$AppSettingsModelTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsModelTable> {
  $$AppSettingsModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get autoPlayQuran => $composableBuilder(
      column: $table.autoPlayQuran,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get autoPlayQuranVolume => $composableBuilder(
      column: $table.autoPlayQuranVolume,
      builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsModelTable> {
  $$AppSettingsModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get autoPlayQuran => $composableBuilder(
      column: $table.autoPlayQuran, builder: (column) => column);

  GeneratedColumn<double> get autoPlayQuranVolume => $composableBuilder(
      column: $table.autoPlayQuranVolume, builder: (column) => column);
}

class $$AppSettingsModelTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsModelTable,
    AppSettingsModelData,
    $$AppSettingsModelTableFilterComposer,
    $$AppSettingsModelTableOrderingComposer,
    $$AppSettingsModelTableAnnotationComposer,
    $$AppSettingsModelTableCreateCompanionBuilder,
    $$AppSettingsModelTableUpdateCompanionBuilder,
    (
      AppSettingsModelData,
      BaseReferences<_$AppDatabase, $AppSettingsModelTable,
          AppSettingsModelData>
    ),
    AppSettingsModelData,
    PrefetchHooks Function()> {
  $$AppSettingsModelTableTableManager(
      _$AppDatabase db, $AppSettingsModelTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<bool> autoPlayQuran = const Value.absent(),
            Value<double> autoPlayQuranVolume = const Value.absent(),
          }) =>
              AppSettingsModelCompanion(
            id: id,
            themeMode: themeMode,
            autoPlayQuran: autoPlayQuran,
            autoPlayQuranVolume: autoPlayQuranVolume,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<bool> autoPlayQuran = const Value.absent(),
            Value<double> autoPlayQuranVolume = const Value.absent(),
          }) =>
              AppSettingsModelCompanion.insert(
            id: id,
            themeMode: themeMode,
            autoPlayQuran: autoPlayQuran,
            autoPlayQuranVolume: autoPlayQuranVolume,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsModelTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsModelTable,
    AppSettingsModelData,
    $$AppSettingsModelTableFilterComposer,
    $$AppSettingsModelTableOrderingComposer,
    $$AppSettingsModelTableAnnotationComposer,
    $$AppSettingsModelTableCreateCompanionBuilder,
    $$AppSettingsModelTableUpdateCompanionBuilder,
    (
      AppSettingsModelData,
      BaseReferences<_$AppDatabase, $AppSettingsModelTable,
          AppSettingsModelData>
    ),
    AppSettingsModelData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteNameModelTableTableManager get favoriteNameModel =>
      $$FavoriteNameModelTableTableManager(_db, _db.favoriteNameModel);
  $$AppSettingsModelTableTableManager get appSettingsModel =>
      $$AppSettingsModelTableTableManager(_db, _db.appSettingsModel);
}
