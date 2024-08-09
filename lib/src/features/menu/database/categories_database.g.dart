// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_database.dart';

// ignore_for_file: type=lint
class $CategoriesItemsTable extends CategoriesItems
    with TableInfo<$CategoriesItemsTable, CategoriesItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, tag];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_items';
  @override
  VerificationContext validateIntegrity(Insertable<CategoriesItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  CategoriesItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $CategoriesItemsTable createAlias(String alias) {
    return $CategoriesItemsTable(attachedDatabase, alias);
  }
}

class CategoriesItem extends DataClass implements Insertable<CategoriesItem> {
  final int id;
  final String tag;
  const CategoriesItem({required this.id, required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag'] = Variable<String>(tag);
    return map;
  }

  CategoriesItemsCompanion toCompanion(bool nullToAbsent) {
    return CategoriesItemsCompanion(
      id: Value(id),
      tag: Value(tag),
    );
  }

  factory CategoriesItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesItem(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String>(tag),
    };
  }

  CategoriesItem copyWith({int? id, String? tag}) => CategoriesItem(
        id: id ?? this.id,
        tag: tag ?? this.tag,
      );
  @override
  String toString() {
    return (StringBuffer('CategoriesItem(')
          ..write('id: $id, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesItem && other.id == this.id && other.tag == this.tag);
}

class CategoriesItemsCompanion extends UpdateCompanion<CategoriesItem> {
  final Value<int> id;
  final Value<String> tag;
  final Value<int> rowid;
  const CategoriesItemsCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesItemsCompanion.insert({
    required int id,
    required String tag,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tag = Value(tag);
  static Insertable<CategoriesItem> custom({
    Expression<int>? id,
    Expression<String>? tag,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesItemsCompanion copyWith(
      {Value<int>? id, Value<String>? tag, Value<int>? rowid}) {
    return CategoriesItemsCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesItemsCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CategoriesDatabase extends GeneratedDatabase {
  _$CategoriesDatabase(QueryExecutor e) : super(e);
  late final $CategoriesItemsTable categoriesItems =
      $CategoriesItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [categoriesItems];
}
