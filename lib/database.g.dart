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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteNameModelTable favoriteNameModel =
      $FavoriteNameModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteNameModel];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteNameModelTableTableManager get favoriteNameModel =>
      $$FavoriteNameModelTableTableManager(_db, _db.favoriteNameModel);
}
