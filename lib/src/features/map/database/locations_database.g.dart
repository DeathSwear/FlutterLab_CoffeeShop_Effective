// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_database.dart';

// ignore_for_file: type=lint
class $LocationsItemsTable extends LocationsItems
    with TableInfo<$LocationsItemsTable, LocationsItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
      'lat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longMeta = const VerificationMeta('long');
  @override
  late final GeneratedColumn<double> long = GeneratedColumn<double>(
      'long', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _addresMeta = const VerificationMeta('addres');
  @override
  late final GeneratedColumn<String> addres = GeneratedColumn<String>(
      'addres', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [lat, long, addres];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocationsItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lat')) {
      context.handle(
          _latMeta, lat.isAcceptableOrUnknown(data['lat']!, _latMeta));
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('long')) {
      context.handle(
          _longMeta, long.isAcceptableOrUnknown(data['long']!, _longMeta));
    } else if (isInserting) {
      context.missing(_longMeta);
    }
    if (data.containsKey('addres')) {
      context.handle(_addresMeta,
          addres.isAcceptableOrUnknown(data['addres']!, _addresMeta));
    } else if (isInserting) {
      context.missing(_addresMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LocationsItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationsItem(
      lat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lat'])!,
      long: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}long'])!,
      addres: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}addres'])!,
    );
  }

  @override
  $LocationsItemsTable createAlias(String alias) {
    return $LocationsItemsTable(attachedDatabase, alias);
  }
}

class LocationsItem extends DataClass implements Insertable<LocationsItem> {
  final double lat;
  final double long;
  final String addres;
  const LocationsItem(
      {required this.lat, required this.long, required this.addres});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lat'] = Variable<double>(lat);
    map['long'] = Variable<double>(long);
    map['addres'] = Variable<String>(addres);
    return map;
  }

  LocationsItemsCompanion toCompanion(bool nullToAbsent) {
    return LocationsItemsCompanion(
      lat: Value(lat),
      long: Value(long),
      addres: Value(addres),
    );
  }

  factory LocationsItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationsItem(
      lat: serializer.fromJson<double>(json['lat']),
      long: serializer.fromJson<double>(json['long']),
      addres: serializer.fromJson<String>(json['addres']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lat': serializer.toJson<double>(lat),
      'long': serializer.toJson<double>(long),
      'addres': serializer.toJson<String>(addres),
    };
  }

  LocationsItem copyWith({double? lat, double? long, String? addres}) =>
      LocationsItem(
        lat: lat ?? this.lat,
        long: long ?? this.long,
        addres: addres ?? this.addres,
      );
  @override
  String toString() {
    return (StringBuffer('LocationsItem(')
          ..write('lat: $lat, ')
          ..write('long: $long, ')
          ..write('addres: $addres')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lat, long, addres);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationsItem &&
          other.lat == this.lat &&
          other.long == this.long &&
          other.addres == this.addres);
}

class LocationsItemsCompanion extends UpdateCompanion<LocationsItem> {
  final Value<double> lat;
  final Value<double> long;
  final Value<String> addres;
  final Value<int> rowid;
  const LocationsItemsCompanion({
    this.lat = const Value.absent(),
    this.long = const Value.absent(),
    this.addres = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsItemsCompanion.insert({
    required double lat,
    required double long,
    required String addres,
    this.rowid = const Value.absent(),
  })  : lat = Value(lat),
        long = Value(long),
        addres = Value(addres);
  static Insertable<LocationsItem> custom({
    Expression<double>? lat,
    Expression<double>? long,
    Expression<String>? addres,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
      if (addres != null) 'addres': addres,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsItemsCompanion copyWith(
      {Value<double>? lat,
      Value<double>? long,
      Value<String>? addres,
      Value<int>? rowid}) {
    return LocationsItemsCompanion(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      addres: addres ?? this.addres,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (long.present) {
      map['long'] = Variable<double>(long.value);
    }
    if (addres.present) {
      map['addres'] = Variable<String>(addres.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsItemsCompanion(')
          ..write('lat: $lat, ')
          ..write('long: $long, ')
          ..write('addres: $addres, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocationsDatabase extends GeneratedDatabase {
  _$LocationsDatabase(QueryExecutor e) : super(e);
  late final $LocationsItemsTable locationsItems = $LocationsItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [locationsItems];
}
