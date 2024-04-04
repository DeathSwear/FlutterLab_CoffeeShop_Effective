// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_database.dart';

// ignore_for_file: type=lint
class $ProductsItemsTable extends ProductsItems
    with TableInfo<$ProductsItemsTable, ProductsItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _icoMeta = const VerificationMeta('ico');
  @override
  late final GeneratedColumn<String> ico = GeneratedColumn<String>(
      'ico', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
      'price', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceTypeMeta =
      const VerificationMeta('priceType');
  @override
  late final GeneratedColumn<String> priceType = GeneratedColumn<String>(
      'price_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIDMeta =
      const VerificationMeta('categoryID');
  @override
  late final GeneratedColumn<int> categoryID = GeneratedColumn<int>(
      'category_i_d', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ico, name, description, price, priceType, categoryID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_items';
  @override
  VerificationContext validateIntegrity(Insertable<ProductsItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ico')) {
      context.handle(
          _icoMeta, ico.isAcceptableOrUnknown(data['ico']!, _icoMeta));
    } else if (isInserting) {
      context.missing(_icoMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('price_type')) {
      context.handle(_priceTypeMeta,
          priceType.isAcceptableOrUnknown(data['price_type']!, _priceTypeMeta));
    } else if (isInserting) {
      context.missing(_priceTypeMeta);
    }
    if (data.containsKey('category_i_d')) {
      context.handle(
          _categoryIDMeta,
          categoryID.isAcceptableOrUnknown(
              data['category_i_d']!, _categoryIDMeta));
    } else if (isInserting) {
      context.missing(_categoryIDMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProductsItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ico'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price'])!,
      priceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price_type'])!,
      categoryID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_i_d'])!,
    );
  }

  @override
  $ProductsItemsTable createAlias(String alias) {
    return $ProductsItemsTable(attachedDatabase, alias);
  }
}

class ProductsItem extends DataClass implements Insertable<ProductsItem> {
  final int id;
  final String ico;
  final String name;
  final String description;
  final String price;
  final String priceType;
  final int categoryID;
  const ProductsItem(
      {required this.id,
      required this.ico,
      required this.name,
      required this.description,
      required this.price,
      required this.priceType,
      required this.categoryID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ico'] = Variable<String>(ico);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['price'] = Variable<String>(price);
    map['price_type'] = Variable<String>(priceType);
    map['category_i_d'] = Variable<int>(categoryID);
    return map;
  }

  ProductsItemsCompanion toCompanion(bool nullToAbsent) {
    return ProductsItemsCompanion(
      id: Value(id),
      ico: Value(ico),
      name: Value(name),
      description: Value(description),
      price: Value(price),
      priceType: Value(priceType),
      categoryID: Value(categoryID),
    );
  }

  factory ProductsItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsItem(
      id: serializer.fromJson<int>(json['id']),
      ico: serializer.fromJson<String>(json['ico']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      price: serializer.fromJson<String>(json['price']),
      priceType: serializer.fromJson<String>(json['priceType']),
      categoryID: serializer.fromJson<int>(json['categoryID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ico': serializer.toJson<String>(ico),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'price': serializer.toJson<String>(price),
      'priceType': serializer.toJson<String>(priceType),
      'categoryID': serializer.toJson<int>(categoryID),
    };
  }

  ProductsItem copyWith(
          {int? id,
          String? ico,
          String? name,
          String? description,
          String? price,
          String? priceType,
          int? categoryID}) =>
      ProductsItem(
        id: id ?? this.id,
        ico: ico ?? this.ico,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        priceType: priceType ?? this.priceType,
        categoryID: categoryID ?? this.categoryID,
      );
  @override
  String toString() {
    return (StringBuffer('ProductsItem(')
          ..write('id: $id, ')
          ..write('ico: $ico, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('priceType: $priceType, ')
          ..write('categoryID: $categoryID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ico, name, description, price, priceType, categoryID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsItem &&
          other.id == this.id &&
          other.ico == this.ico &&
          other.name == this.name &&
          other.description == this.description &&
          other.price == this.price &&
          other.priceType == this.priceType &&
          other.categoryID == this.categoryID);
}

class ProductsItemsCompanion extends UpdateCompanion<ProductsItem> {
  final Value<int> id;
  final Value<String> ico;
  final Value<String> name;
  final Value<String> description;
  final Value<String> price;
  final Value<String> priceType;
  final Value<int> categoryID;
  final Value<int> rowid;
  const ProductsItemsCompanion({
    this.id = const Value.absent(),
    this.ico = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.price = const Value.absent(),
    this.priceType = const Value.absent(),
    this.categoryID = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsItemsCompanion.insert({
    required int id,
    required String ico,
    required String name,
    required String description,
    required String price,
    required String priceType,
    required int categoryID,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ico = Value(ico),
        name = Value(name),
        description = Value(description),
        price = Value(price),
        priceType = Value(priceType),
        categoryID = Value(categoryID);
  static Insertable<ProductsItem> custom({
    Expression<int>? id,
    Expression<String>? ico,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? price,
    Expression<String>? priceType,
    Expression<int>? categoryID,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ico != null) 'ico': ico,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (price != null) 'price': price,
      if (priceType != null) 'price_type': priceType,
      if (categoryID != null) 'category_i_d': categoryID,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? ico,
      Value<String>? name,
      Value<String>? description,
      Value<String>? price,
      Value<String>? priceType,
      Value<int>? categoryID,
      Value<int>? rowid}) {
    return ProductsItemsCompanion(
      id: id ?? this.id,
      ico: ico ?? this.ico,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      priceType: priceType ?? this.priceType,
      categoryID: categoryID ?? this.categoryID,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ico.present) {
      map['ico'] = Variable<String>(ico.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (priceType.present) {
      map['price_type'] = Variable<String>(priceType.value);
    }
    if (categoryID.present) {
      map['category_i_d'] = Variable<int>(categoryID.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsItemsCompanion(')
          ..write('id: $id, ')
          ..write('ico: $ico, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('price: $price, ')
          ..write('priceType: $priceType, ')
          ..write('categoryID: $categoryID, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProductsDatabase extends GeneratedDatabase {
  _$ProductsDatabase(QueryExecutor e) : super(e);
  late final $ProductsItemsTable productsItems = $ProductsItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [productsItems];
}
