// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TxType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TxType>($CategoriesTable.$convertertype);
  @override
  late final GeneratedColumnWithTypeConverter<FeedColor, String> feedColor =
      GeneratedColumn<String>(
        'feed_color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedColor>($CategoriesTable.$converterfeedColor);
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, type, feedColor, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $CategoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      feedColor: $CategoriesTable.$converterfeedColor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feed_color'],
        )!,
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TxType, String, String> $convertertype =
      const EnumNameConverter<TxType>(TxType.values);
  static JsonTypeConverter2<FeedColor, String, String> $converterfeedColor =
      const EnumNameConverter<FeedColor>(FeedColor.values);
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final TxType type;
  final FeedColor feedColor;
  final int sortOrder;
  const Category({
    required this.id,
    required this.name,
    required this.type,
    required this.feedColor,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type),
      );
    }
    {
      map['feed_color'] = Variable<String>(
        $CategoriesTable.$converterfeedColor.toSql(feedColor),
      );
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      feedColor: Value(feedColor),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: $CategoriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      feedColor: $CategoriesTable.$converterfeedColor.fromJson(
        serializer.fromJson<String>(json['feedColor']),
      ),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $CategoriesTable.$convertertype.toJson(type),
      ),
      'feedColor': serializer.toJson<String>(
        $CategoriesTable.$converterfeedColor.toJson(feedColor),
      ),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    TxType? type,
    FeedColor? feedColor,
    int? sortOrder,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    feedColor: feedColor ?? this.feedColor,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      feedColor: data.feedColor.present ? data.feedColor.value : this.feedColor,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('feedColor: $feedColor, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type, feedColor, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.feedColor == this.feedColor &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<TxType> type;
  final Value<FeedColor> feedColor;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.feedColor = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required TxType type,
    required FeedColor feedColor,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       feedColor = Value(feedColor),
       sortOrder = Value(sortOrder);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? feedColor,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (feedColor != null) 'feed_color': feedColor,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<TxType>? type,
    Value<FeedColor>? feedColor,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      feedColor: feedColor ?? this.feedColor,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CategoriesTable.$convertertype.toSql(type.value),
      );
    }
    if (feedColor.present) {
      map['feed_color'] = Variable<String>(
        $CategoriesTable.$converterfeedColor.toSql(feedColor.value),
      );
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('feedColor: $feedColor, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TxRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('TWD'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TxType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TxType>($TransactionsTable.$convertertype);
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _feedGrantedMeta = const VerificationMeta(
    'feedGranted',
  );
  @override
  late final GeneratedColumn<bool> feedGranted = GeneratedColumn<bool>(
    'feed_granted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("feed_granted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isTutorialMeta = const VerificationMeta(
    'isTutorial',
  );
  @override
  late final GeneratedColumn<bool> isTutorial = GeneratedColumn<bool>(
    'is_tutorial',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_tutorial" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    currency,
    type,
    categoryId,
    date,
    note,
    feedGranted,
    isTutorial,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TxRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('feed_granted')) {
      context.handle(
        _feedGrantedMeta,
        feedGranted.isAcceptableOrUnknown(
          data['feed_granted']!,
          _feedGrantedMeta,
        ),
      );
    }
    if (data.containsKey('is_tutorial')) {
      context.handle(
        _isTutorialMeta,
        isTutorial.isAcceptableOrUnknown(data['is_tutorial']!, _isTutorialMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TxRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TxRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      type: $TransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      feedGranted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}feed_granted'],
      )!,
      isTutorial: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_tutorial'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TxType, String, String> $convertertype =
      const EnumNameConverter<TxType>(TxType.values);
}

class TxRecord extends DataClass implements Insertable<TxRecord> {
  final int id;

  /// Whole currency units (NT$ has no decimals).
  final int amount;
  final String currency;
  final TxType type;
  final String categoryId;
  final DateTime date;
  final String note;
  final bool feedGranted;
  final bool isTutorial;
  final DateTime createdAt;
  const TxRecord({
    required this.id,
    required this.amount,
    required this.currency,
    required this.type,
    required this.categoryId,
    required this.date,
    required this.note,
    required this.feedGranted,
    required this.isTutorial,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['currency'] = Variable<String>(currency);
    {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type),
      );
    }
    map['category_id'] = Variable<String>(categoryId);
    map['date'] = Variable<DateTime>(date);
    map['note'] = Variable<String>(note);
    map['feed_granted'] = Variable<bool>(feedGranted);
    map['is_tutorial'] = Variable<bool>(isTutorial);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      amount: Value(amount),
      currency: Value(currency),
      type: Value(type),
      categoryId: Value(categoryId),
      date: Value(date),
      note: Value(note),
      feedGranted: Value(feedGranted),
      isTutorial: Value(isTutorial),
      createdAt: Value(createdAt),
    );
  }

  factory TxRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TxRecord(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      type: $TransactionsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String>(json['note']),
      feedGranted: serializer.fromJson<bool>(json['feedGranted']),
      isTutorial: serializer.fromJson<bool>(json['isTutorial']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'currency': serializer.toJson<String>(currency),
      'type': serializer.toJson<String>(
        $TransactionsTable.$convertertype.toJson(type),
      ),
      'categoryId': serializer.toJson<String>(categoryId),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String>(note),
      'feedGranted': serializer.toJson<bool>(feedGranted),
      'isTutorial': serializer.toJson<bool>(isTutorial),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TxRecord copyWith({
    int? id,
    int? amount,
    String? currency,
    TxType? type,
    String? categoryId,
    DateTime? date,
    String? note,
    bool? feedGranted,
    bool? isTutorial,
    DateTime? createdAt,
  }) => TxRecord(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    type: type ?? this.type,
    categoryId: categoryId ?? this.categoryId,
    date: date ?? this.date,
    note: note ?? this.note,
    feedGranted: feedGranted ?? this.feedGranted,
    isTutorial: isTutorial ?? this.isTutorial,
    createdAt: createdAt ?? this.createdAt,
  );
  TxRecord copyWithCompanion(TransactionsCompanion data) {
    return TxRecord(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      type: data.type.present ? data.type.value : this.type,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      feedGranted: data.feedGranted.present
          ? data.feedGranted.value
          : this.feedGranted,
      isTutorial: data.isTutorial.present
          ? data.isTutorial.value
          : this.isTutorial,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TxRecord(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('type: $type, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('feedGranted: $feedGranted, ')
          ..write('isTutorial: $isTutorial, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    currency,
    type,
    categoryId,
    date,
    note,
    feedGranted,
    isTutorial,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TxRecord &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.type == this.type &&
          other.categoryId == this.categoryId &&
          other.date == this.date &&
          other.note == this.note &&
          other.feedGranted == this.feedGranted &&
          other.isTutorial == this.isTutorial &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<TxRecord> {
  final Value<int> id;
  final Value<int> amount;
  final Value<String> currency;
  final Value<TxType> type;
  final Value<String> categoryId;
  final Value<DateTime> date;
  final Value<String> note;
  final Value<bool> feedGranted;
  final Value<bool> isTutorial;
  final Value<DateTime> createdAt;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.type = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.feedGranted = const Value.absent(),
    this.isTutorial = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int amount,
    this.currency = const Value.absent(),
    required TxType type,
    required String categoryId,
    required DateTime date,
    this.note = const Value.absent(),
    this.feedGranted = const Value.absent(),
    this.isTutorial = const Value.absent(),
    required DateTime createdAt,
  }) : amount = Value(amount),
       type = Value(type),
       categoryId = Value(categoryId),
       date = Value(date),
       createdAt = Value(createdAt);
  static Insertable<TxRecord> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<String>? currency,
    Expression<String>? type,
    Expression<String>? categoryId,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<bool>? feedGranted,
    Expression<bool>? isTutorial,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (type != null) 'type': type,
      if (categoryId != null) 'category_id': categoryId,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (feedGranted != null) 'feed_granted': feedGranted,
      if (isTutorial != null) 'is_tutorial': isTutorial,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? amount,
    Value<String>? currency,
    Value<TxType>? type,
    Value<String>? categoryId,
    Value<DateTime>? date,
    Value<String>? note,
    Value<bool>? feedGranted,
    Value<bool>? isTutorial,
    Value<DateTime>? createdAt,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      note: note ?? this.note,
      feedGranted: feedGranted ?? this.feedGranted,
      isTutorial: isTutorial ?? this.isTutorial,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $TransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (feedGranted.present) {
      map['feed_granted'] = Variable<bool>(feedGranted.value);
    }
    if (isTutorial.present) {
      map['is_tutorial'] = Variable<bool>(isTutorial.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('type: $type, ')
          ..write('categoryId: $categoryId, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('feedGranted: $feedGranted, ')
          ..write('isTutorial: $isTutorial, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeedInventoryTable extends FeedInventory
    with TableInfo<$FeedInventoryTable, FeedStock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedInventoryTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<FeedColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedColor>($FeedInventoryTable.$convertercolor);
  @override
  late final GeneratedColumnWithTypeConverter<FeedLevel, String> level =
      GeneratedColumn<String>(
        'level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedLevel>($FeedInventoryTable.$converterlevel);
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [color, level, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedStock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {color, level};
  @override
  FeedStock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedStock(
      color: $FeedInventoryTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
      level: $FeedInventoryTable.$converterlevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}level'],
        )!,
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $FeedInventoryTable createAlias(String alias) {
    return $FeedInventoryTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeedColor, String, String> $convertercolor =
      const EnumNameConverter<FeedColor>(FeedColor.values);
  static JsonTypeConverter2<FeedLevel, String, String> $converterlevel =
      const EnumNameConverter<FeedLevel>(FeedLevel.values);
}

class FeedStock extends DataClass implements Insertable<FeedStock> {
  final FeedColor color;
  final FeedLevel level;
  final int quantity;
  const FeedStock({
    required this.color,
    required this.level,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    {
      map['color'] = Variable<String>(
        $FeedInventoryTable.$convertercolor.toSql(color),
      );
    }
    {
      map['level'] = Variable<String>(
        $FeedInventoryTable.$converterlevel.toSql(level),
      );
    }
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  FeedInventoryCompanion toCompanion(bool nullToAbsent) {
    return FeedInventoryCompanion(
      color: Value(color),
      level: Value(level),
      quantity: Value(quantity),
    );
  }

  factory FeedStock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedStock(
      color: $FeedInventoryTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
      level: $FeedInventoryTable.$converterlevel.fromJson(
        serializer.fromJson<String>(json['level']),
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'color': serializer.toJson<String>(
        $FeedInventoryTable.$convertercolor.toJson(color),
      ),
      'level': serializer.toJson<String>(
        $FeedInventoryTable.$converterlevel.toJson(level),
      ),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  FeedStock copyWith({FeedColor? color, FeedLevel? level, int? quantity}) =>
      FeedStock(
        color: color ?? this.color,
        level: level ?? this.level,
        quantity: quantity ?? this.quantity,
      );
  FeedStock copyWithCompanion(FeedInventoryCompanion data) {
    return FeedStock(
      color: data.color.present ? data.color.value : this.color,
      level: data.level.present ? data.level.value : this.level,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedStock(')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(color, level, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedStock &&
          other.color == this.color &&
          other.level == this.level &&
          other.quantity == this.quantity);
}

class FeedInventoryCompanion extends UpdateCompanion<FeedStock> {
  final Value<FeedColor> color;
  final Value<FeedLevel> level;
  final Value<int> quantity;
  final Value<int> rowid;
  const FeedInventoryCompanion({
    this.color = const Value.absent(),
    this.level = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FeedInventoryCompanion.insert({
    required FeedColor color,
    required FeedLevel level,
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : color = Value(color),
       level = Value(level);
  static Insertable<FeedStock> custom({
    Expression<String>? color,
    Expression<String>? level,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (color != null) 'color': color,
      if (level != null) 'level': level,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FeedInventoryCompanion copyWith({
    Value<FeedColor>? color,
    Value<FeedLevel>? level,
    Value<int>? quantity,
    Value<int>? rowid,
  }) {
    return FeedInventoryCompanion(
      color: color ?? this.color,
      level: level ?? this.level,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (color.present) {
      map['color'] = Variable<String>(
        $FeedInventoryTable.$convertercolor.toSql(color.value),
      );
    }
    if (level.present) {
      map['level'] = Variable<String>(
        $FeedInventoryTable.$converterlevel.toSql(level.value),
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedInventoryCompanion(')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FishesTable extends Fishes with TableInfo<$FishesTable, Fish> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FishesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inTankMeta = const VerificationMeta('inTank');
  @override
  late final GeneratedColumn<bool> inTank = GeneratedColumn<bool>(
    'in_tank',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_tank" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _satietyMeta = const VerificationMeta(
    'satiety',
  );
  @override
  late final GeneratedColumn<double> satiety = GeneratedColumn<double>(
    'satiety',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _satietyAtMeta = const VerificationMeta(
    'satietyAt',
  );
  @override
  late final GeneratedColumn<DateTime> satietyAt = GeneratedColumn<DateTime>(
    'satiety_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _everPlacedMeta = const VerificationMeta(
    'everPlaced',
  );
  @override
  late final GeneratedColumn<bool> everPlaced = GeneratedColumn<bool>(
    'ever_placed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ever_placed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    inTank,
    satiety,
    satietyAt,
    everPlaced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fishes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fish> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('in_tank')) {
      context.handle(
        _inTankMeta,
        inTank.isAcceptableOrUnknown(data['in_tank']!, _inTankMeta),
      );
    }
    if (data.containsKey('satiety')) {
      context.handle(
        _satietyMeta,
        satiety.isAcceptableOrUnknown(data['satiety']!, _satietyMeta),
      );
    }
    if (data.containsKey('satiety_at')) {
      context.handle(
        _satietyAtMeta,
        satietyAt.isAcceptableOrUnknown(data['satiety_at']!, _satietyAtMeta),
      );
    } else if (isInserting) {
      context.missing(_satietyAtMeta);
    }
    if (data.containsKey('ever_placed')) {
      context.handle(
        _everPlacedMeta,
        everPlaced.isAcceptableOrUnknown(data['ever_placed']!, _everPlacedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fish map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fish(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      inTank: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_tank'],
      )!,
      satiety: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}satiety'],
      )!,
      satietyAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}satiety_at'],
      )!,
      everPlaced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ever_placed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FishesTable createAlias(String alias) {
    return $FishesTable(attachedDatabase, alias);
  }
}

class Fish extends DataClass implements Insertable<Fish> {
  final int id;
  final String speciesId;
  final bool inTank;

  /// 0–100. Frozen while the fish is in the backpack (D-15).
  final double satiety;
  final DateTime satietyAt;

  /// Whether the fish has ever been placed in the tank; the 50% start applies only once.
  final bool everPlaced;
  final DateTime createdAt;
  const Fish({
    required this.id,
    required this.speciesId,
    required this.inTank,
    required this.satiety,
    required this.satietyAt,
    required this.everPlaced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['species_id'] = Variable<String>(speciesId);
    map['in_tank'] = Variable<bool>(inTank);
    map['satiety'] = Variable<double>(satiety);
    map['satiety_at'] = Variable<DateTime>(satietyAt);
    map['ever_placed'] = Variable<bool>(everPlaced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FishesCompanion toCompanion(bool nullToAbsent) {
    return FishesCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      inTank: Value(inTank),
      satiety: Value(satiety),
      satietyAt: Value(satietyAt),
      everPlaced: Value(everPlaced),
      createdAt: Value(createdAt),
    );
  }

  factory Fish.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fish(
      id: serializer.fromJson<int>(json['id']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      inTank: serializer.fromJson<bool>(json['inTank']),
      satiety: serializer.fromJson<double>(json['satiety']),
      satietyAt: serializer.fromJson<DateTime>(json['satietyAt']),
      everPlaced: serializer.fromJson<bool>(json['everPlaced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'speciesId': serializer.toJson<String>(speciesId),
      'inTank': serializer.toJson<bool>(inTank),
      'satiety': serializer.toJson<double>(satiety),
      'satietyAt': serializer.toJson<DateTime>(satietyAt),
      'everPlaced': serializer.toJson<bool>(everPlaced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Fish copyWith({
    int? id,
    String? speciesId,
    bool? inTank,
    double? satiety,
    DateTime? satietyAt,
    bool? everPlaced,
    DateTime? createdAt,
  }) => Fish(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    inTank: inTank ?? this.inTank,
    satiety: satiety ?? this.satiety,
    satietyAt: satietyAt ?? this.satietyAt,
    everPlaced: everPlaced ?? this.everPlaced,
    createdAt: createdAt ?? this.createdAt,
  );
  Fish copyWithCompanion(FishesCompanion data) {
    return Fish(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      inTank: data.inTank.present ? data.inTank.value : this.inTank,
      satiety: data.satiety.present ? data.satiety.value : this.satiety,
      satietyAt: data.satietyAt.present ? data.satietyAt.value : this.satietyAt,
      everPlaced: data.everPlaced.present
          ? data.everPlaced.value
          : this.everPlaced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fish(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('inTank: $inTank, ')
          ..write('satiety: $satiety, ')
          ..write('satietyAt: $satietyAt, ')
          ..write('everPlaced: $everPlaced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    speciesId,
    inTank,
    satiety,
    satietyAt,
    everPlaced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fish &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.inTank == this.inTank &&
          other.satiety == this.satiety &&
          other.satietyAt == this.satietyAt &&
          other.everPlaced == this.everPlaced &&
          other.createdAt == this.createdAt);
}

class FishesCompanion extends UpdateCompanion<Fish> {
  final Value<int> id;
  final Value<String> speciesId;
  final Value<bool> inTank;
  final Value<double> satiety;
  final Value<DateTime> satietyAt;
  final Value<bool> everPlaced;
  final Value<DateTime> createdAt;
  const FishesCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.inTank = const Value.absent(),
    this.satiety = const Value.absent(),
    this.satietyAt = const Value.absent(),
    this.everPlaced = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FishesCompanion.insert({
    this.id = const Value.absent(),
    required String speciesId,
    this.inTank = const Value.absent(),
    this.satiety = const Value.absent(),
    required DateTime satietyAt,
    this.everPlaced = const Value.absent(),
    required DateTime createdAt,
  }) : speciesId = Value(speciesId),
       satietyAt = Value(satietyAt),
       createdAt = Value(createdAt);
  static Insertable<Fish> custom({
    Expression<int>? id,
    Expression<String>? speciesId,
    Expression<bool>? inTank,
    Expression<double>? satiety,
    Expression<DateTime>? satietyAt,
    Expression<bool>? everPlaced,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (inTank != null) 'in_tank': inTank,
      if (satiety != null) 'satiety': satiety,
      if (satietyAt != null) 'satiety_at': satietyAt,
      if (everPlaced != null) 'ever_placed': everPlaced,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FishesCompanion copyWith({
    Value<int>? id,
    Value<String>? speciesId,
    Value<bool>? inTank,
    Value<double>? satiety,
    Value<DateTime>? satietyAt,
    Value<bool>? everPlaced,
    Value<DateTime>? createdAt,
  }) {
    return FishesCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      inTank: inTank ?? this.inTank,
      satiety: satiety ?? this.satiety,
      satietyAt: satietyAt ?? this.satietyAt,
      everPlaced: everPlaced ?? this.everPlaced,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (inTank.present) {
      map['in_tank'] = Variable<bool>(inTank.value);
    }
    if (satiety.present) {
      map['satiety'] = Variable<double>(satiety.value);
    }
    if (satietyAt.present) {
      map['satiety_at'] = Variable<DateTime>(satietyAt.value);
    }
    if (everPlaced.present) {
      map['ever_placed'] = Variable<bool>(everPlaced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FishesCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('inTank: $inTank, ')
          ..write('satiety: $satiety, ')
          ..write('satietyAt: $satietyAt, ')
          ..write('everPlaced: $everPlaced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $FeedGrantsTable extends FeedGrants
    with TableInfo<$FeedGrantsTable, FeedGrant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedGrantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _txIdMeta = const VerificationMeta('txId');
  @override
  late final GeneratedColumn<int> txId = GeneratedColumn<int>(
    'tx_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeedColor, String> color =
      GeneratedColumn<String>(
        'color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedColor>($FeedGrantsTable.$convertercolor);
  @override
  late final GeneratedColumnWithTypeConverter<FeedLevel, String> level =
      GeneratedColumn<String>(
        'level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedLevel>($FeedGrantsTable.$converterlevel);
  static const VerificationMeta _grantedAtMeta = const VerificationMeta(
    'grantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
    'granted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, txId, color, level, grantedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feed_grants';
  @override
  VerificationContext validateIntegrity(
    Insertable<FeedGrant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tx_id')) {
      context.handle(
        _txIdMeta,
        txId.isAcceptableOrUnknown(data['tx_id']!, _txIdMeta),
      );
    }
    if (data.containsKey('granted_at')) {
      context.handle(
        _grantedAtMeta,
        grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_grantedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FeedGrant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FeedGrant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      txId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tx_id'],
      ),
      color: $FeedGrantsTable.$convertercolor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}color'],
        )!,
      ),
      level: $FeedGrantsTable.$converterlevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}level'],
        )!,
      ),
      grantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}granted_at'],
      )!,
    );
  }

  @override
  $FeedGrantsTable createAlias(String alias) {
    return $FeedGrantsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeedColor, String, String> $convertercolor =
      const EnumNameConverter<FeedColor>(FeedColor.values);
  static JsonTypeConverter2<FeedLevel, String, String> $converterlevel =
      const EnumNameConverter<FeedLevel>(FeedLevel.values);
}

class FeedGrant extends DataClass implements Insertable<FeedGrant> {
  final int id;
  final int? txId;
  final FeedColor color;
  final FeedLevel level;
  final DateTime grantedAt;
  const FeedGrant({
    required this.id,
    this.txId,
    required this.color,
    required this.level,
    required this.grantedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || txId != null) {
      map['tx_id'] = Variable<int>(txId);
    }
    {
      map['color'] = Variable<String>(
        $FeedGrantsTable.$convertercolor.toSql(color),
      );
    }
    {
      map['level'] = Variable<String>(
        $FeedGrantsTable.$converterlevel.toSql(level),
      );
    }
    map['granted_at'] = Variable<DateTime>(grantedAt);
    return map;
  }

  FeedGrantsCompanion toCompanion(bool nullToAbsent) {
    return FeedGrantsCompanion(
      id: Value(id),
      txId: txId == null && nullToAbsent ? const Value.absent() : Value(txId),
      color: Value(color),
      level: Value(level),
      grantedAt: Value(grantedAt),
    );
  }

  factory FeedGrant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FeedGrant(
      id: serializer.fromJson<int>(json['id']),
      txId: serializer.fromJson<int?>(json['txId']),
      color: $FeedGrantsTable.$convertercolor.fromJson(
        serializer.fromJson<String>(json['color']),
      ),
      level: $FeedGrantsTable.$converterlevel.fromJson(
        serializer.fromJson<String>(json['level']),
      ),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'txId': serializer.toJson<int?>(txId),
      'color': serializer.toJson<String>(
        $FeedGrantsTable.$convertercolor.toJson(color),
      ),
      'level': serializer.toJson<String>(
        $FeedGrantsTable.$converterlevel.toJson(level),
      ),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
    };
  }

  FeedGrant copyWith({
    int? id,
    Value<int?> txId = const Value.absent(),
    FeedColor? color,
    FeedLevel? level,
    DateTime? grantedAt,
  }) => FeedGrant(
    id: id ?? this.id,
    txId: txId.present ? txId.value : this.txId,
    color: color ?? this.color,
    level: level ?? this.level,
    grantedAt: grantedAt ?? this.grantedAt,
  );
  FeedGrant copyWithCompanion(FeedGrantsCompanion data) {
    return FeedGrant(
      id: data.id.present ? data.id.value : this.id,
      txId: data.txId.present ? data.txId.value : this.txId,
      color: data.color.present ? data.color.value : this.color,
      level: data.level.present ? data.level.value : this.level,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FeedGrant(')
          ..write('id: $id, ')
          ..write('txId: $txId, ')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('grantedAt: $grantedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, txId, color, level, grantedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FeedGrant &&
          other.id == this.id &&
          other.txId == this.txId &&
          other.color == this.color &&
          other.level == this.level &&
          other.grantedAt == this.grantedAt);
}

class FeedGrantsCompanion extends UpdateCompanion<FeedGrant> {
  final Value<int> id;
  final Value<int?> txId;
  final Value<FeedColor> color;
  final Value<FeedLevel> level;
  final Value<DateTime> grantedAt;
  const FeedGrantsCompanion({
    this.id = const Value.absent(),
    this.txId = const Value.absent(),
    this.color = const Value.absent(),
    this.level = const Value.absent(),
    this.grantedAt = const Value.absent(),
  });
  FeedGrantsCompanion.insert({
    this.id = const Value.absent(),
    this.txId = const Value.absent(),
    required FeedColor color,
    required FeedLevel level,
    required DateTime grantedAt,
  }) : color = Value(color),
       level = Value(level),
       grantedAt = Value(grantedAt);
  static Insertable<FeedGrant> custom({
    Expression<int>? id,
    Expression<int>? txId,
    Expression<String>? color,
    Expression<String>? level,
    Expression<DateTime>? grantedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (txId != null) 'tx_id': txId,
      if (color != null) 'color': color,
      if (level != null) 'level': level,
      if (grantedAt != null) 'granted_at': grantedAt,
    });
  }

  FeedGrantsCompanion copyWith({
    Value<int>? id,
    Value<int?>? txId,
    Value<FeedColor>? color,
    Value<FeedLevel>? level,
    Value<DateTime>? grantedAt,
  }) {
    return FeedGrantsCompanion(
      id: id ?? this.id,
      txId: txId ?? this.txId,
      color: color ?? this.color,
      level: level ?? this.level,
      grantedAt: grantedAt ?? this.grantedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (txId.present) {
      map['tx_id'] = Variable<int>(txId.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(
        $FeedGrantsTable.$convertercolor.toSql(color.value),
      );
    }
    if (level.present) {
      map['level'] = Variable<String>(
        $FeedGrantsTable.$converterlevel.toSql(level.value),
      );
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedGrantsCompanion(')
          ..write('id: $id, ')
          ..write('txId: $txId, ')
          ..write('color: $color, ')
          ..write('level: $level, ')
          ..write('grantedAt: $grantedAt')
          ..write(')'))
        .toString();
  }
}

class $FeedingsTable extends Feedings with TableInfo<$FeedingsTable, Feeding> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FeedingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fishIdMeta = const VerificationMeta('fishId');
  @override
  late final GeneratedColumn<int> fishId = GeneratedColumn<int>(
    'fish_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fishes (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<FeedColor, String> feedColor =
      GeneratedColumn<String>(
        'feed_color',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedColor>($FeedingsTable.$converterfeedColor);
  @override
  late final GeneratedColumnWithTypeConverter<FeedLevel, String> feedLevel =
      GeneratedColumn<String>(
        'feed_level',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FeedLevel>($FeedingsTable.$converterfeedLevel);
  static const VerificationMeta _fedAtMeta = const VerificationMeta('fedAt');
  @override
  late final GeneratedColumn<DateTime> fedAt = GeneratedColumn<DateTime>(
    'fed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readyAtMeta = const VerificationMeta(
    'readyAt',
  );
  @override
  late final GeneratedColumn<DateTime> readyAt = GeneratedColumn<DateTime>(
    'ready_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMsMeta = const VerificationMeta(
    'remainingMs',
  );
  @override
  late final GeneratedColumn<int> remainingMs = GeneratedColumn<int>(
    'remaining_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fishId,
    feedColor,
    feedLevel,
    fedAt,
    readyAt,
    remainingMs,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feedings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Feeding> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fish_id')) {
      context.handle(
        _fishIdMeta,
        fishId.isAcceptableOrUnknown(data['fish_id']!, _fishIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fishIdMeta);
    }
    if (data.containsKey('fed_at')) {
      context.handle(
        _fedAtMeta,
        fedAt.isAcceptableOrUnknown(data['fed_at']!, _fedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fedAtMeta);
    }
    if (data.containsKey('ready_at')) {
      context.handle(
        _readyAtMeta,
        readyAt.isAcceptableOrUnknown(data['ready_at']!, _readyAtMeta),
      );
    } else if (isInserting) {
      context.missing(_readyAtMeta);
    }
    if (data.containsKey('remaining_ms')) {
      context.handle(
        _remainingMsMeta,
        remainingMs.isAcceptableOrUnknown(
          data['remaining_ms']!,
          _remainingMsMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feeding map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feeding(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fishId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fish_id'],
      )!,
      feedColor: $FeedingsTable.$converterfeedColor.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feed_color'],
        )!,
      ),
      feedLevel: $FeedingsTable.$converterfeedLevel.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}feed_level'],
        )!,
      ),
      fedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fed_at'],
      )!,
      readyAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ready_at'],
      )!,
      remainingMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_ms'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $FeedingsTable createAlias(String alias) {
    return $FeedingsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FeedColor, String, String> $converterfeedColor =
      const EnumNameConverter<FeedColor>(FeedColor.values);
  static JsonTypeConverter2<FeedLevel, String, String> $converterfeedLevel =
      const EnumNameConverter<FeedLevel>(FeedLevel.values);
}

class Feeding extends DataClass implements Insertable<Feeding> {
  final int id;
  final int fishId;
  final FeedColor feedColor;
  final FeedLevel feedLevel;
  final DateTime fedAt;
  final DateTime readyAt;

  /// Remaining digestion time saved while the fish sits in the backpack.
  final int? remainingMs;
  final bool completed;
  const Feeding({
    required this.id,
    required this.fishId,
    required this.feedColor,
    required this.feedLevel,
    required this.fedAt,
    required this.readyAt,
    this.remainingMs,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fish_id'] = Variable<int>(fishId);
    {
      map['feed_color'] = Variable<String>(
        $FeedingsTable.$converterfeedColor.toSql(feedColor),
      );
    }
    {
      map['feed_level'] = Variable<String>(
        $FeedingsTable.$converterfeedLevel.toSql(feedLevel),
      );
    }
    map['fed_at'] = Variable<DateTime>(fedAt);
    map['ready_at'] = Variable<DateTime>(readyAt);
    if (!nullToAbsent || remainingMs != null) {
      map['remaining_ms'] = Variable<int>(remainingMs);
    }
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  FeedingsCompanion toCompanion(bool nullToAbsent) {
    return FeedingsCompanion(
      id: Value(id),
      fishId: Value(fishId),
      feedColor: Value(feedColor),
      feedLevel: Value(feedLevel),
      fedAt: Value(fedAt),
      readyAt: Value(readyAt),
      remainingMs: remainingMs == null && nullToAbsent
          ? const Value.absent()
          : Value(remainingMs),
      completed: Value(completed),
    );
  }

  factory Feeding.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feeding(
      id: serializer.fromJson<int>(json['id']),
      fishId: serializer.fromJson<int>(json['fishId']),
      feedColor: $FeedingsTable.$converterfeedColor.fromJson(
        serializer.fromJson<String>(json['feedColor']),
      ),
      feedLevel: $FeedingsTable.$converterfeedLevel.fromJson(
        serializer.fromJson<String>(json['feedLevel']),
      ),
      fedAt: serializer.fromJson<DateTime>(json['fedAt']),
      readyAt: serializer.fromJson<DateTime>(json['readyAt']),
      remainingMs: serializer.fromJson<int?>(json['remainingMs']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fishId': serializer.toJson<int>(fishId),
      'feedColor': serializer.toJson<String>(
        $FeedingsTable.$converterfeedColor.toJson(feedColor),
      ),
      'feedLevel': serializer.toJson<String>(
        $FeedingsTable.$converterfeedLevel.toJson(feedLevel),
      ),
      'fedAt': serializer.toJson<DateTime>(fedAt),
      'readyAt': serializer.toJson<DateTime>(readyAt),
      'remainingMs': serializer.toJson<int?>(remainingMs),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  Feeding copyWith({
    int? id,
    int? fishId,
    FeedColor? feedColor,
    FeedLevel? feedLevel,
    DateTime? fedAt,
    DateTime? readyAt,
    Value<int?> remainingMs = const Value.absent(),
    bool? completed,
  }) => Feeding(
    id: id ?? this.id,
    fishId: fishId ?? this.fishId,
    feedColor: feedColor ?? this.feedColor,
    feedLevel: feedLevel ?? this.feedLevel,
    fedAt: fedAt ?? this.fedAt,
    readyAt: readyAt ?? this.readyAt,
    remainingMs: remainingMs.present ? remainingMs.value : this.remainingMs,
    completed: completed ?? this.completed,
  );
  Feeding copyWithCompanion(FeedingsCompanion data) {
    return Feeding(
      id: data.id.present ? data.id.value : this.id,
      fishId: data.fishId.present ? data.fishId.value : this.fishId,
      feedColor: data.feedColor.present ? data.feedColor.value : this.feedColor,
      feedLevel: data.feedLevel.present ? data.feedLevel.value : this.feedLevel,
      fedAt: data.fedAt.present ? data.fedAt.value : this.fedAt,
      readyAt: data.readyAt.present ? data.readyAt.value : this.readyAt,
      remainingMs: data.remainingMs.present
          ? data.remainingMs.value
          : this.remainingMs,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feeding(')
          ..write('id: $id, ')
          ..write('fishId: $fishId, ')
          ..write('feedColor: $feedColor, ')
          ..write('feedLevel: $feedLevel, ')
          ..write('fedAt: $fedAt, ')
          ..write('readyAt: $readyAt, ')
          ..write('remainingMs: $remainingMs, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fishId,
    feedColor,
    feedLevel,
    fedAt,
    readyAt,
    remainingMs,
    completed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feeding &&
          other.id == this.id &&
          other.fishId == this.fishId &&
          other.feedColor == this.feedColor &&
          other.feedLevel == this.feedLevel &&
          other.fedAt == this.fedAt &&
          other.readyAt == this.readyAt &&
          other.remainingMs == this.remainingMs &&
          other.completed == this.completed);
}

class FeedingsCompanion extends UpdateCompanion<Feeding> {
  final Value<int> id;
  final Value<int> fishId;
  final Value<FeedColor> feedColor;
  final Value<FeedLevel> feedLevel;
  final Value<DateTime> fedAt;
  final Value<DateTime> readyAt;
  final Value<int?> remainingMs;
  final Value<bool> completed;
  const FeedingsCompanion({
    this.id = const Value.absent(),
    this.fishId = const Value.absent(),
    this.feedColor = const Value.absent(),
    this.feedLevel = const Value.absent(),
    this.fedAt = const Value.absent(),
    this.readyAt = const Value.absent(),
    this.remainingMs = const Value.absent(),
    this.completed = const Value.absent(),
  });
  FeedingsCompanion.insert({
    this.id = const Value.absent(),
    required int fishId,
    required FeedColor feedColor,
    required FeedLevel feedLevel,
    required DateTime fedAt,
    required DateTime readyAt,
    this.remainingMs = const Value.absent(),
    this.completed = const Value.absent(),
  }) : fishId = Value(fishId),
       feedColor = Value(feedColor),
       feedLevel = Value(feedLevel),
       fedAt = Value(fedAt),
       readyAt = Value(readyAt);
  static Insertable<Feeding> custom({
    Expression<int>? id,
    Expression<int>? fishId,
    Expression<String>? feedColor,
    Expression<String>? feedLevel,
    Expression<DateTime>? fedAt,
    Expression<DateTime>? readyAt,
    Expression<int>? remainingMs,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fishId != null) 'fish_id': fishId,
      if (feedColor != null) 'feed_color': feedColor,
      if (feedLevel != null) 'feed_level': feedLevel,
      if (fedAt != null) 'fed_at': fedAt,
      if (readyAt != null) 'ready_at': readyAt,
      if (remainingMs != null) 'remaining_ms': remainingMs,
      if (completed != null) 'completed': completed,
    });
  }

  FeedingsCompanion copyWith({
    Value<int>? id,
    Value<int>? fishId,
    Value<FeedColor>? feedColor,
    Value<FeedLevel>? feedLevel,
    Value<DateTime>? fedAt,
    Value<DateTime>? readyAt,
    Value<int?>? remainingMs,
    Value<bool>? completed,
  }) {
    return FeedingsCompanion(
      id: id ?? this.id,
      fishId: fishId ?? this.fishId,
      feedColor: feedColor ?? this.feedColor,
      feedLevel: feedLevel ?? this.feedLevel,
      fedAt: fedAt ?? this.fedAt,
      readyAt: readyAt ?? this.readyAt,
      remainingMs: remainingMs ?? this.remainingMs,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fishId.present) {
      map['fish_id'] = Variable<int>(fishId.value);
    }
    if (feedColor.present) {
      map['feed_color'] = Variable<String>(
        $FeedingsTable.$converterfeedColor.toSql(feedColor.value),
      );
    }
    if (feedLevel.present) {
      map['feed_level'] = Variable<String>(
        $FeedingsTable.$converterfeedLevel.toSql(feedLevel.value),
      );
    }
    if (fedAt.present) {
      map['fed_at'] = Variable<DateTime>(fedAt.value);
    }
    if (readyAt.present) {
      map['ready_at'] = Variable<DateTime>(readyAt.value);
    }
    if (remainingMs.present) {
      map['remaining_ms'] = Variable<int>(remainingMs.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FeedingsCompanion(')
          ..write('id: $id, ')
          ..write('fishId: $fishId, ')
          ..write('feedColor: $feedColor, ')
          ..write('feedLevel: $feedLevel, ')
          ..write('fedAt: $fedAt, ')
          ..write('readyAt: $readyAt, ')
          ..write('remainingMs: $remainingMs, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $DroppedCoinsTable extends DroppedCoins
    with TableInfo<$DroppedCoinsTable, DroppedCoin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DroppedCoinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _droppedAtMeta = const VerificationMeta(
    'droppedAt',
  );
  @override
  late final GeneratedColumn<DateTime> droppedAt = GeneratedColumn<DateTime>(
    'dropped_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount, x, droppedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dropped_coins';
  @override
  VerificationContext validateIntegrity(
    Insertable<DroppedCoin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('dropped_at')) {
      context.handle(
        _droppedAtMeta,
        droppedAt.isAcceptableOrUnknown(data['dropped_at']!, _droppedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_droppedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DroppedCoin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DroppedCoin(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x'],
      )!,
      droppedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dropped_at'],
      )!,
    );
  }

  @override
  $DroppedCoinsTable createAlias(String alias) {
    return $DroppedCoinsTable(attachedDatabase, alias);
  }
}

class DroppedCoin extends DataClass implements Insertable<DroppedCoin> {
  final int id;
  final int amount;

  /// Horizontal position, 0–1 of the tank width.
  final double x;
  final DateTime droppedAt;
  const DroppedCoin({
    required this.id,
    required this.amount,
    required this.x,
    required this.droppedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['x'] = Variable<double>(x);
    map['dropped_at'] = Variable<DateTime>(droppedAt);
    return map;
  }

  DroppedCoinsCompanion toCompanion(bool nullToAbsent) {
    return DroppedCoinsCompanion(
      id: Value(id),
      amount: Value(amount),
      x: Value(x),
      droppedAt: Value(droppedAt),
    );
  }

  factory DroppedCoin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DroppedCoin(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      x: serializer.fromJson<double>(json['x']),
      droppedAt: serializer.fromJson<DateTime>(json['droppedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'x': serializer.toJson<double>(x),
      'droppedAt': serializer.toJson<DateTime>(droppedAt),
    };
  }

  DroppedCoin copyWith({
    int? id,
    int? amount,
    double? x,
    DateTime? droppedAt,
  }) => DroppedCoin(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    x: x ?? this.x,
    droppedAt: droppedAt ?? this.droppedAt,
  );
  DroppedCoin copyWithCompanion(DroppedCoinsCompanion data) {
    return DroppedCoin(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      x: data.x.present ? data.x.value : this.x,
      droppedAt: data.droppedAt.present ? data.droppedAt.value : this.droppedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DroppedCoin(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('x: $x, ')
          ..write('droppedAt: $droppedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, x, droppedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DroppedCoin &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.x == this.x &&
          other.droppedAt == this.droppedAt);
}

class DroppedCoinsCompanion extends UpdateCompanion<DroppedCoin> {
  final Value<int> id;
  final Value<int> amount;
  final Value<double> x;
  final Value<DateTime> droppedAt;
  const DroppedCoinsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.x = const Value.absent(),
    this.droppedAt = const Value.absent(),
  });
  DroppedCoinsCompanion.insert({
    this.id = const Value.absent(),
    required int amount,
    required double x,
    required DateTime droppedAt,
  }) : amount = Value(amount),
       x = Value(x),
       droppedAt = Value(droppedAt);
  static Insertable<DroppedCoin> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<double>? x,
    Expression<DateTime>? droppedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (x != null) 'x': x,
      if (droppedAt != null) 'dropped_at': droppedAt,
    });
  }

  DroppedCoinsCompanion copyWith({
    Value<int>? id,
    Value<int>? amount,
    Value<double>? x,
    Value<DateTime>? droppedAt,
  }) {
    return DroppedCoinsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      x: x ?? this.x,
      droppedAt: droppedAt ?? this.droppedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (droppedAt.present) {
      map['dropped_at'] = Variable<DateTime>(droppedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DroppedCoinsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('x: $x, ')
          ..write('droppedAt: $droppedAt')
          ..write(')'))
        .toString();
  }
}

class $WalletTable extends Wallet with TableInfo<$WalletTable, WalletRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, coins];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalletRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalletRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
    );
  }

  @override
  $WalletTable createAlias(String alias) {
    return $WalletTable(attachedDatabase, alias);
  }
}

class WalletRow extends DataClass implements Insertable<WalletRow> {
  final int id;
  final int coins;
  const WalletRow({required this.id, required this.coins});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['coins'] = Variable<int>(coins);
    return map;
  }

  WalletCompanion toCompanion(bool nullToAbsent) {
    return WalletCompanion(id: Value(id), coins: Value(coins));
  }

  factory WalletRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletRow(
      id: serializer.fromJson<int>(json['id']),
      coins: serializer.fromJson<int>(json['coins']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'coins': serializer.toJson<int>(coins),
    };
  }

  WalletRow copyWith({int? id, int? coins}) =>
      WalletRow(id: id ?? this.id, coins: coins ?? this.coins);
  WalletRow copyWithCompanion(WalletCompanion data) {
    return WalletRow(
      id: data.id.present ? data.id.value : this.id,
      coins: data.coins.present ? data.coins.value : this.coins,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalletRow(')
          ..write('id: $id, ')
          ..write('coins: $coins')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, coins);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletRow && other.id == this.id && other.coins == this.coins);
}

class WalletCompanion extends UpdateCompanion<WalletRow> {
  final Value<int> id;
  final Value<int> coins;
  const WalletCompanion({
    this.id = const Value.absent(),
    this.coins = const Value.absent(),
  });
  WalletCompanion.insert({
    this.id = const Value.absent(),
    this.coins = const Value.absent(),
  });
  static Insertable<WalletRow> custom({
    Expression<int>? id,
    Expression<int>? coins,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coins != null) 'coins': coins,
    });
  }

  WalletCompanion copyWith({Value<int>? id, Value<int>? coins}) {
    return WalletCompanion(id: id ?? this.id, coins: coins ?? this.coins);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletCompanion(')
          ..write('id: $id, ')
          ..write('coins: $coins')
          ..write(')'))
        .toString();
  }
}

class $TanksTable extends Tanks with TableInfo<$TanksTable, Tank> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TanksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backgroundIdMeta = const VerificationMeta(
    'backgroundId',
  );
  @override
  late final GeneratedColumn<String> backgroundId = GeneratedColumn<String>(
    'background_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bg_default'),
  );
  static const VerificationMeta _floorIdMeta = const VerificationMeta(
    'floorId',
  );
  @override
  late final GeneratedColumn<String> floorId = GeneratedColumn<String>(
    'floor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('floor_sand'),
  );
  static const VerificationMeta _fishSlotsMeta = const VerificationMeta(
    'fishSlots',
  );
  @override
  late final GeneratedColumn<int> fishSlots = GeneratedColumn<int>(
    'fish_slots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _decoSlotsMeta = const VerificationMeta(
    'decoSlots',
  );
  @override
  late final GeneratedColumn<int> decoSlots = GeneratedColumn<int>(
    'deco_slots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    backgroundId,
    floorId,
    fishSlots,
    decoSlots,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tanks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tank> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('background_id')) {
      context.handle(
        _backgroundIdMeta,
        backgroundId.isAcceptableOrUnknown(
          data['background_id']!,
          _backgroundIdMeta,
        ),
      );
    }
    if (data.containsKey('floor_id')) {
      context.handle(
        _floorIdMeta,
        floorId.isAcceptableOrUnknown(data['floor_id']!, _floorIdMeta),
      );
    }
    if (data.containsKey('fish_slots')) {
      context.handle(
        _fishSlotsMeta,
        fishSlots.isAcceptableOrUnknown(data['fish_slots']!, _fishSlotsMeta),
      );
    }
    if (data.containsKey('deco_slots')) {
      context.handle(
        _decoSlotsMeta,
        decoSlots.isAcceptableOrUnknown(data['deco_slots']!, _decoSlotsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tank map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tank(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      backgroundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_id'],
      )!,
      floorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}floor_id'],
      )!,
      fishSlots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fish_slots'],
      )!,
      decoSlots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deco_slots'],
      )!,
    );
  }

  @override
  $TanksTable createAlias(String alias) {
    return $TanksTable(attachedDatabase, alias);
  }
}

class Tank extends DataClass implements Insertable<Tank> {
  final int id;
  final String backgroundId;
  final String floorId;
  final int fishSlots;
  final int decoSlots;
  const Tank({
    required this.id,
    required this.backgroundId,
    required this.floorId,
    required this.fishSlots,
    required this.decoSlots,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['background_id'] = Variable<String>(backgroundId);
    map['floor_id'] = Variable<String>(floorId);
    map['fish_slots'] = Variable<int>(fishSlots);
    map['deco_slots'] = Variable<int>(decoSlots);
    return map;
  }

  TanksCompanion toCompanion(bool nullToAbsent) {
    return TanksCompanion(
      id: Value(id),
      backgroundId: Value(backgroundId),
      floorId: Value(floorId),
      fishSlots: Value(fishSlots),
      decoSlots: Value(decoSlots),
    );
  }

  factory Tank.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tank(
      id: serializer.fromJson<int>(json['id']),
      backgroundId: serializer.fromJson<String>(json['backgroundId']),
      floorId: serializer.fromJson<String>(json['floorId']),
      fishSlots: serializer.fromJson<int>(json['fishSlots']),
      decoSlots: serializer.fromJson<int>(json['decoSlots']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'backgroundId': serializer.toJson<String>(backgroundId),
      'floorId': serializer.toJson<String>(floorId),
      'fishSlots': serializer.toJson<int>(fishSlots),
      'decoSlots': serializer.toJson<int>(decoSlots),
    };
  }

  Tank copyWith({
    int? id,
    String? backgroundId,
    String? floorId,
    int? fishSlots,
    int? decoSlots,
  }) => Tank(
    id: id ?? this.id,
    backgroundId: backgroundId ?? this.backgroundId,
    floorId: floorId ?? this.floorId,
    fishSlots: fishSlots ?? this.fishSlots,
    decoSlots: decoSlots ?? this.decoSlots,
  );
  Tank copyWithCompanion(TanksCompanion data) {
    return Tank(
      id: data.id.present ? data.id.value : this.id,
      backgroundId: data.backgroundId.present
          ? data.backgroundId.value
          : this.backgroundId,
      floorId: data.floorId.present ? data.floorId.value : this.floorId,
      fishSlots: data.fishSlots.present ? data.fishSlots.value : this.fishSlots,
      decoSlots: data.decoSlots.present ? data.decoSlots.value : this.decoSlots,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tank(')
          ..write('id: $id, ')
          ..write('backgroundId: $backgroundId, ')
          ..write('floorId: $floorId, ')
          ..write('fishSlots: $fishSlots, ')
          ..write('decoSlots: $decoSlots')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, backgroundId, floorId, fishSlots, decoSlots);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tank &&
          other.id == this.id &&
          other.backgroundId == this.backgroundId &&
          other.floorId == this.floorId &&
          other.fishSlots == this.fishSlots &&
          other.decoSlots == this.decoSlots);
}

class TanksCompanion extends UpdateCompanion<Tank> {
  final Value<int> id;
  final Value<String> backgroundId;
  final Value<String> floorId;
  final Value<int> fishSlots;
  final Value<int> decoSlots;
  const TanksCompanion({
    this.id = const Value.absent(),
    this.backgroundId = const Value.absent(),
    this.floorId = const Value.absent(),
    this.fishSlots = const Value.absent(),
    this.decoSlots = const Value.absent(),
  });
  TanksCompanion.insert({
    this.id = const Value.absent(),
    this.backgroundId = const Value.absent(),
    this.floorId = const Value.absent(),
    this.fishSlots = const Value.absent(),
    this.decoSlots = const Value.absent(),
  });
  static Insertable<Tank> custom({
    Expression<int>? id,
    Expression<String>? backgroundId,
    Expression<String>? floorId,
    Expression<int>? fishSlots,
    Expression<int>? decoSlots,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (backgroundId != null) 'background_id': backgroundId,
      if (floorId != null) 'floor_id': floorId,
      if (fishSlots != null) 'fish_slots': fishSlots,
      if (decoSlots != null) 'deco_slots': decoSlots,
    });
  }

  TanksCompanion copyWith({
    Value<int>? id,
    Value<String>? backgroundId,
    Value<String>? floorId,
    Value<int>? fishSlots,
    Value<int>? decoSlots,
  }) {
    return TanksCompanion(
      id: id ?? this.id,
      backgroundId: backgroundId ?? this.backgroundId,
      floorId: floorId ?? this.floorId,
      fishSlots: fishSlots ?? this.fishSlots,
      decoSlots: decoSlots ?? this.decoSlots,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (backgroundId.present) {
      map['background_id'] = Variable<String>(backgroundId.value);
    }
    if (floorId.present) {
      map['floor_id'] = Variable<String>(floorId.value);
    }
    if (fishSlots.present) {
      map['fish_slots'] = Variable<int>(fishSlots.value);
    }
    if (decoSlots.present) {
      map['deco_slots'] = Variable<int>(decoSlots.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TanksCompanion(')
          ..write('id: $id, ')
          ..write('backgroundId: $backgroundId, ')
          ..write('floorId: $floorId, ')
          ..write('fishSlots: $fishSlots, ')
          ..write('decoSlots: $decoSlots')
          ..write(')'))
        .toString();
  }
}

class $InventoryItemsTable extends InventoryItems
    with TableInfo<$InventoryItemsTable, InventoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [itemId, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  InventoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItem(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $InventoryItemsTable createAlias(String alias) {
    return $InventoryItemsTable(attachedDatabase, alias);
  }
}

class InventoryItem extends DataClass implements Insertable<InventoryItem> {
  final String itemId;
  final int quantity;
  const InventoryItem({required this.itemId, required this.quantity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<String>(itemId);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  InventoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemsCompanion(
      itemId: Value(itemId),
      quantity: Value(quantity),
    );
  }

  factory InventoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItem(
      itemId: serializer.fromJson<String>(json['itemId']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<String>(itemId),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  InventoryItem copyWith({String? itemId, int? quantity}) => InventoryItem(
    itemId: itemId ?? this.itemId,
    quantity: quantity ?? this.quantity,
  );
  InventoryItem copyWithCompanion(InventoryItemsCompanion data) {
    return InventoryItem(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItem(')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItem &&
          other.itemId == this.itemId &&
          other.quantity == this.quantity);
}

class InventoryItemsCompanion extends UpdateCompanion<InventoryItem> {
  final Value<String> itemId;
  final Value<int> quantity;
  final Value<int> rowid;
  const InventoryItemsCompanion({
    this.itemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemsCompanion.insert({
    required String itemId,
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId);
  static Insertable<InventoryItem> custom({
    Expression<String>? itemId,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemsCompanion copyWith({
    Value<String>? itemId,
    Value<int>? quantity,
    Value<int>? rowid,
  }) {
    return InventoryItemsCompanion(
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryItemsCompanion(')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlacementsTable extends Placements
    with TableInfo<$PlacementsTable, Placement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<double> x = GeneratedColumn<double>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<double> y = GeneratedColumn<double>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _layerMeta = const VerificationMeta('layer');
  @override
  late final GeneratedColumn<int> layer = GeneratedColumn<int>(
    'layer',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _flippedMeta = const VerificationMeta(
    'flipped',
  );
  @override
  late final GeneratedColumn<bool> flipped = GeneratedColumn<bool>(
    'flipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("flipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, itemId, x, y, layer, flipped];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'placements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Placement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('layer')) {
      context.handle(
        _layerMeta,
        layer.isAcceptableOrUnknown(data['layer']!, _layerMeta),
      );
    }
    if (data.containsKey('flipped')) {
      context.handle(
        _flippedMeta,
        flipped.isAcceptableOrUnknown(data['flipped']!, _flippedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Placement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Placement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y'],
      )!,
      layer: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}layer'],
      )!,
      flipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}flipped'],
      )!,
    );
  }

  @override
  $PlacementsTable createAlias(String alias) {
    return $PlacementsTable(attachedDatabase, alias);
  }
}

class Placement extends DataClass implements Insertable<Placement> {
  final int id;
  final String itemId;

  /// 0–1 proportional coordinates so layouts survive screen changes.
  final double x;
  final double y;
  final int layer;
  final bool flipped;
  const Placement({
    required this.id,
    required this.itemId,
    required this.x,
    required this.y,
    required this.layer,
    required this.flipped,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<String>(itemId);
    map['x'] = Variable<double>(x);
    map['y'] = Variable<double>(y);
    map['layer'] = Variable<int>(layer);
    map['flipped'] = Variable<bool>(flipped);
    return map;
  }

  PlacementsCompanion toCompanion(bool nullToAbsent) {
    return PlacementsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      x: Value(x),
      y: Value(y),
      layer: Value(layer),
      flipped: Value(flipped),
    );
  }

  factory Placement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Placement(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      x: serializer.fromJson<double>(json['x']),
      y: serializer.fromJson<double>(json['y']),
      layer: serializer.fromJson<int>(json['layer']),
      flipped: serializer.fromJson<bool>(json['flipped']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<String>(itemId),
      'x': serializer.toJson<double>(x),
      'y': serializer.toJson<double>(y),
      'layer': serializer.toJson<int>(layer),
      'flipped': serializer.toJson<bool>(flipped),
    };
  }

  Placement copyWith({
    int? id,
    String? itemId,
    double? x,
    double? y,
    int? layer,
    bool? flipped,
  }) => Placement(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    x: x ?? this.x,
    y: y ?? this.y,
    layer: layer ?? this.layer,
    flipped: flipped ?? this.flipped,
  );
  Placement copyWithCompanion(PlacementsCompanion data) {
    return Placement(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      layer: data.layer.present ? data.layer.value : this.layer,
      flipped: data.flipped.present ? data.flipped.value : this.flipped,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Placement(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('layer: $layer, ')
          ..write('flipped: $flipped')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, itemId, x, y, layer, flipped);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Placement &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.x == this.x &&
          other.y == this.y &&
          other.layer == this.layer &&
          other.flipped == this.flipped);
}

class PlacementsCompanion extends UpdateCompanion<Placement> {
  final Value<int> id;
  final Value<String> itemId;
  final Value<double> x;
  final Value<double> y;
  final Value<int> layer;
  final Value<bool> flipped;
  const PlacementsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.layer = const Value.absent(),
    this.flipped = const Value.absent(),
  });
  PlacementsCompanion.insert({
    this.id = const Value.absent(),
    required String itemId,
    required double x,
    required double y,
    this.layer = const Value.absent(),
    this.flipped = const Value.absent(),
  }) : itemId = Value(itemId),
       x = Value(x),
       y = Value(y);
  static Insertable<Placement> custom({
    Expression<int>? id,
    Expression<String>? itemId,
    Expression<double>? x,
    Expression<double>? y,
    Expression<int>? layer,
    Expression<bool>? flipped,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (layer != null) 'layer': layer,
      if (flipped != null) 'flipped': flipped,
    });
  }

  PlacementsCompanion copyWith({
    Value<int>? id,
    Value<String>? itemId,
    Value<double>? x,
    Value<double>? y,
    Value<int>? layer,
    Value<bool>? flipped,
  }) {
    return PlacementsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      x: x ?? this.x,
      y: y ?? this.y,
      layer: layer ?? this.layer,
      flipped: flipped ?? this.flipped,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (x.present) {
      map['x'] = Variable<double>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<double>(y.value);
    }
    if (layer.present) {
      map['layer'] = Variable<int>(layer.value);
    }
    if (flipped.present) {
      map['flipped'] = Variable<bool>(flipped.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacementsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('layer: $layer, ')
          ..write('flipped: $flipped')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, AppSettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('TWD'),
  );
  static const VerificationMeta _cycleStartDayMeta = const VerificationMeta(
    'cycleStartDay',
  );
  @override
  late final GeneratedColumn<int> cycleStartDay = GeneratedColumn<int>(
    'cycle_start_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reminderMinutesMeta = const VerificationMeta(
    'reminderMinutes',
  );
  @override
  late final GeneratedColumn<int> reminderMinutes = GeneratedColumn<int>(
    'reminder_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(21 * 60),
  );
  static const VerificationMeta _coinNotifyEnabledMeta = const VerificationMeta(
    'coinNotifyEnabled',
  );
  @override
  late final GeneratedColumn<bool> coinNotifyEnabled = GeneratedColumn<bool>(
    'coin_notify_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("coin_notify_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currency,
    cycleStartDay,
    reminderEnabled,
    reminderMinutes,
    coinNotifyEnabled,
    soundEnabled,
    lastBackupAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettings> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('cycle_start_day')) {
      context.handle(
        _cycleStartDayMeta,
        cycleStartDay.isAcceptableOrUnknown(
          data['cycle_start_day']!,
          _cycleStartDayMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_minutes')) {
      context.handle(
        _reminderMinutesMeta,
        reminderMinutes.isAcceptableOrUnknown(
          data['reminder_minutes']!,
          _reminderMinutesMeta,
        ),
      );
    }
    if (data.containsKey('coin_notify_enabled')) {
      context.handle(
        _coinNotifyEnabledMeta,
        coinNotifyEnabled.isAcceptableOrUnknown(
          data['coin_notify_enabled']!,
          _coinNotifyEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettings(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      cycleStartDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycle_start_day'],
      )!,
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      reminderMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minutes'],
      )!,
      coinNotifyEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}coin_notify_enabled'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class AppSettings extends DataClass implements Insertable<AppSettings> {
  final int id;
  final String currency;
  final int cycleStartDay;
  final bool reminderEnabled;

  /// Minutes after midnight; 21:00 by default.
  final int reminderMinutes;
  final bool coinNotifyEnabled;
  final bool soundEnabled;
  final DateTime? lastBackupAt;
  const AppSettings({
    required this.id,
    required this.currency,
    required this.cycleStartDay,
    required this.reminderEnabled,
    required this.reminderMinutes,
    required this.coinNotifyEnabled,
    required this.soundEnabled,
    this.lastBackupAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['currency'] = Variable<String>(currency);
    map['cycle_start_day'] = Variable<int>(cycleStartDay);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['reminder_minutes'] = Variable<int>(reminderMinutes);
    map['coin_notify_enabled'] = Variable<bool>(coinNotifyEnabled);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      currency: Value(currency),
      cycleStartDay: Value(cycleStartDay),
      reminderEnabled: Value(reminderEnabled),
      reminderMinutes: Value(reminderMinutes),
      coinNotifyEnabled: Value(coinNotifyEnabled),
      soundEnabled: Value(soundEnabled),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
    );
  }

  factory AppSettings.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettings(
      id: serializer.fromJson<int>(json['id']),
      currency: serializer.fromJson<String>(json['currency']),
      cycleStartDay: serializer.fromJson<int>(json['cycleStartDay']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderMinutes: serializer.fromJson<int>(json['reminderMinutes']),
      coinNotifyEnabled: serializer.fromJson<bool>(json['coinNotifyEnabled']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currency': serializer.toJson<String>(currency),
      'cycleStartDay': serializer.toJson<int>(cycleStartDay),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderMinutes': serializer.toJson<int>(reminderMinutes),
      'coinNotifyEnabled': serializer.toJson<bool>(coinNotifyEnabled),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
    };
  }

  AppSettings copyWith({
    int? id,
    String? currency,
    int? cycleStartDay,
    bool? reminderEnabled,
    int? reminderMinutes,
    bool? coinNotifyEnabled,
    bool? soundEnabled,
    Value<DateTime?> lastBackupAt = const Value.absent(),
  }) => AppSettings(
    id: id ?? this.id,
    currency: currency ?? this.currency,
    cycleStartDay: cycleStartDay ?? this.cycleStartDay,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
    coinNotifyEnabled: coinNotifyEnabled ?? this.coinNotifyEnabled,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
  );
  AppSettings copyWithCompanion(SettingsCompanion data) {
    return AppSettings(
      id: data.id.present ? data.id.value : this.id,
      currency: data.currency.present ? data.currency.value : this.currency,
      cycleStartDay: data.cycleStartDay.present
          ? data.cycleStartDay.value
          : this.cycleStartDay,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderMinutes: data.reminderMinutes.present
          ? data.reminderMinutes.value
          : this.reminderMinutes,
      coinNotifyEnabled: data.coinNotifyEnabled.present
          ? data.coinNotifyEnabled.value
          : this.coinNotifyEnabled,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettings(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('coinNotifyEnabled: $coinNotifyEnabled, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('lastBackupAt: $lastBackupAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currency,
    cycleStartDay,
    reminderEnabled,
    reminderMinutes,
    coinNotifyEnabled,
    soundEnabled,
    lastBackupAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettings &&
          other.id == this.id &&
          other.currency == this.currency &&
          other.cycleStartDay == this.cycleStartDay &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderMinutes == this.reminderMinutes &&
          other.coinNotifyEnabled == this.coinNotifyEnabled &&
          other.soundEnabled == this.soundEnabled &&
          other.lastBackupAt == this.lastBackupAt);
}

class SettingsCompanion extends UpdateCompanion<AppSettings> {
  final Value<int> id;
  final Value<String> currency;
  final Value<int> cycleStartDay;
  final Value<bool> reminderEnabled;
  final Value<int> reminderMinutes;
  final Value<bool> coinNotifyEnabled;
  final Value<bool> soundEnabled;
  final Value<DateTime?> lastBackupAt;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.cycleStartDay = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.coinNotifyEnabled = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.currency = const Value.absent(),
    this.cycleStartDay = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderMinutes = const Value.absent(),
    this.coinNotifyEnabled = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
  });
  static Insertable<AppSettings> custom({
    Expression<int>? id,
    Expression<String>? currency,
    Expression<int>? cycleStartDay,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderMinutes,
    Expression<bool>? coinNotifyEnabled,
    Expression<bool>? soundEnabled,
    Expression<DateTime>? lastBackupAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currency != null) 'currency': currency,
      if (cycleStartDay != null) 'cycle_start_day': cycleStartDay,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderMinutes != null) 'reminder_minutes': reminderMinutes,
      if (coinNotifyEnabled != null) 'coin_notify_enabled': coinNotifyEnabled,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? currency,
    Value<int>? cycleStartDay,
    Value<bool>? reminderEnabled,
    Value<int>? reminderMinutes,
    Value<bool>? coinNotifyEnabled,
    Value<bool>? soundEnabled,
    Value<DateTime?>? lastBackupAt,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      currency: currency ?? this.currency,
      cycleStartDay: cycleStartDay ?? this.cycleStartDay,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderMinutes: reminderMinutes ?? this.reminderMinutes,
      coinNotifyEnabled: coinNotifyEnabled ?? this.coinNotifyEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (cycleStartDay.present) {
      map['cycle_start_day'] = Variable<int>(cycleStartDay.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderMinutes.present) {
      map['reminder_minutes'] = Variable<int>(reminderMinutes.value);
    }
    if (coinNotifyEnabled.present) {
      map['coin_notify_enabled'] = Variable<bool>(coinNotifyEnabled.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('currency: $currency, ')
          ..write('cycleStartDay: $cycleStartDay, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderMinutes: $reminderMinutes, ')
          ..write('coinNotifyEnabled: $coinNotifyEnabled, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('lastBackupAt: $lastBackupAt')
          ..write(')'))
        .toString();
  }
}

class $TutorialProgressTable extends TutorialProgress
    with TableInfo<$TutorialProgressTable, TutorialState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TutorialProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stepMeta = const VerificationMeta('step');
  @override
  late final GeneratedColumn<int> step = GeneratedColumn<int>(
    'step',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _skippedMeta = const VerificationMeta(
    'skipped',
  );
  @override
  late final GeneratedColumn<bool> skipped = GeneratedColumn<bool>(
    'skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _starterFeedGrantedMeta =
      const VerificationMeta('starterFeedGranted');
  @override
  late final GeneratedColumn<bool> starterFeedGranted = GeneratedColumn<bool>(
    'starter_feed_granted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("starter_feed_granted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    step,
    completed,
    skipped,
    starterFeedGranted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tutorial_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<TutorialState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('step')) {
      context.handle(
        _stepMeta,
        step.isAcceptableOrUnknown(data['step']!, _stepMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('skipped')) {
      context.handle(
        _skippedMeta,
        skipped.isAcceptableOrUnknown(data['skipped']!, _skippedMeta),
      );
    }
    if (data.containsKey('starter_feed_granted')) {
      context.handle(
        _starterFeedGrantedMeta,
        starterFeedGranted.isAcceptableOrUnknown(
          data['starter_feed_granted']!,
          _starterFeedGrantedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TutorialState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TutorialState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      step: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      skipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}skipped'],
      )!,
      starterFeedGranted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}starter_feed_granted'],
      )!,
    );
  }

  @override
  $TutorialProgressTable createAlias(String alias) {
    return $TutorialProgressTable(attachedDatabase, alias);
  }
}

class TutorialState extends DataClass implements Insertable<TutorialState> {
  final int id;
  final int step;
  final bool completed;
  final bool skipped;
  final bool starterFeedGranted;
  const TutorialState({
    required this.id,
    required this.step,
    required this.completed,
    required this.skipped,
    required this.starterFeedGranted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['step'] = Variable<int>(step);
    map['completed'] = Variable<bool>(completed);
    map['skipped'] = Variable<bool>(skipped);
    map['starter_feed_granted'] = Variable<bool>(starterFeedGranted);
    return map;
  }

  TutorialProgressCompanion toCompanion(bool nullToAbsent) {
    return TutorialProgressCompanion(
      id: Value(id),
      step: Value(step),
      completed: Value(completed),
      skipped: Value(skipped),
      starterFeedGranted: Value(starterFeedGranted),
    );
  }

  factory TutorialState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TutorialState(
      id: serializer.fromJson<int>(json['id']),
      step: serializer.fromJson<int>(json['step']),
      completed: serializer.fromJson<bool>(json['completed']),
      skipped: serializer.fromJson<bool>(json['skipped']),
      starterFeedGranted: serializer.fromJson<bool>(json['starterFeedGranted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'step': serializer.toJson<int>(step),
      'completed': serializer.toJson<bool>(completed),
      'skipped': serializer.toJson<bool>(skipped),
      'starterFeedGranted': serializer.toJson<bool>(starterFeedGranted),
    };
  }

  TutorialState copyWith({
    int? id,
    int? step,
    bool? completed,
    bool? skipped,
    bool? starterFeedGranted,
  }) => TutorialState(
    id: id ?? this.id,
    step: step ?? this.step,
    completed: completed ?? this.completed,
    skipped: skipped ?? this.skipped,
    starterFeedGranted: starterFeedGranted ?? this.starterFeedGranted,
  );
  TutorialState copyWithCompanion(TutorialProgressCompanion data) {
    return TutorialState(
      id: data.id.present ? data.id.value : this.id,
      step: data.step.present ? data.step.value : this.step,
      completed: data.completed.present ? data.completed.value : this.completed,
      skipped: data.skipped.present ? data.skipped.value : this.skipped,
      starterFeedGranted: data.starterFeedGranted.present
          ? data.starterFeedGranted.value
          : this.starterFeedGranted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TutorialState(')
          ..write('id: $id, ')
          ..write('step: $step, ')
          ..write('completed: $completed, ')
          ..write('skipped: $skipped, ')
          ..write('starterFeedGranted: $starterFeedGranted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, step, completed, skipped, starterFeedGranted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TutorialState &&
          other.id == this.id &&
          other.step == this.step &&
          other.completed == this.completed &&
          other.skipped == this.skipped &&
          other.starterFeedGranted == this.starterFeedGranted);
}

class TutorialProgressCompanion extends UpdateCompanion<TutorialState> {
  final Value<int> id;
  final Value<int> step;
  final Value<bool> completed;
  final Value<bool> skipped;
  final Value<bool> starterFeedGranted;
  const TutorialProgressCompanion({
    this.id = const Value.absent(),
    this.step = const Value.absent(),
    this.completed = const Value.absent(),
    this.skipped = const Value.absent(),
    this.starterFeedGranted = const Value.absent(),
  });
  TutorialProgressCompanion.insert({
    this.id = const Value.absent(),
    this.step = const Value.absent(),
    this.completed = const Value.absent(),
    this.skipped = const Value.absent(),
    this.starterFeedGranted = const Value.absent(),
  });
  static Insertable<TutorialState> custom({
    Expression<int>? id,
    Expression<int>? step,
    Expression<bool>? completed,
    Expression<bool>? skipped,
    Expression<bool>? starterFeedGranted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (step != null) 'step': step,
      if (completed != null) 'completed': completed,
      if (skipped != null) 'skipped': skipped,
      if (starterFeedGranted != null)
        'starter_feed_granted': starterFeedGranted,
    });
  }

  TutorialProgressCompanion copyWith({
    Value<int>? id,
    Value<int>? step,
    Value<bool>? completed,
    Value<bool>? skipped,
    Value<bool>? starterFeedGranted,
  }) {
    return TutorialProgressCompanion(
      id: id ?? this.id,
      step: step ?? this.step,
      completed: completed ?? this.completed,
      skipped: skipped ?? this.skipped,
      starterFeedGranted: starterFeedGranted ?? this.starterFeedGranted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (step.present) {
      map['step'] = Variable<int>(step.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (skipped.present) {
      map['skipped'] = Variable<bool>(skipped.value);
    }
    if (starterFeedGranted.present) {
      map['starter_feed_granted'] = Variable<bool>(starterFeedGranted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TutorialProgressCompanion(')
          ..write('id: $id, ')
          ..write('step: $step, ')
          ..write('completed: $completed, ')
          ..write('skipped: $skipped, ')
          ..write('starterFeedGranted: $starterFeedGranted')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $FeedInventoryTable feedInventory = $FeedInventoryTable(this);
  late final $FishesTable fishes = $FishesTable(this);
  late final $FeedGrantsTable feedGrants = $FeedGrantsTable(this);
  late final $FeedingsTable feedings = $FeedingsTable(this);
  late final $DroppedCoinsTable droppedCoins = $DroppedCoinsTable(this);
  late final $WalletTable wallet = $WalletTable(this);
  late final $TanksTable tanks = $TanksTable(this);
  late final $InventoryItemsTable inventoryItems = $InventoryItemsTable(this);
  late final $PlacementsTable placements = $PlacementsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $TutorialProgressTable tutorialProgress = $TutorialProgressTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    transactions,
    feedInventory,
    fishes,
    feedGrants,
    feedings,
    droppedCoins,
    wallet,
    tanks,
    inventoryItems,
    placements,
    settings,
    tutorialProgress,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required TxType type,
  required FeedColor feedColor,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<TxType> type,
  Value<FeedColor> feedColor,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TxRecord>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'categories__id__transactions__category_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TxType, TxType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FeedColor, FeedColor, String> get feedColor =>
      $composableBuilder(
        column: $table.feedColor,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedColor => $composableBuilder(
    column: $table.feedColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedColor, String> get feedColor =>
      $composableBuilder(column: $table.feedColor, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<TxType> type = const Value.absent(),
                Value<FeedColor> feedColor = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                type: type,
                feedColor: feedColor,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required TxType type,
                required FeedColor feedColor,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                type: type,
                feedColor: feedColor,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      Category,
                      $CategoriesTable,
                      TxRecord
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required int amount,
      Value<String> currency,
      required TxType type,
      required String categoryId,
      required DateTime date,
      Value<String> note,
      Value<bool> feedGranted,
      Value<bool> isTutorial,
      required DateTime createdAt,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<int> amount,
      Value<String> currency,
      Value<TxType> type,
      Value<String> categoryId,
      Value<DateTime> date,
      Value<String> note,
      Value<bool> feedGranted,
      Value<bool> isTutorial,
      Value<DateTime> createdAt,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, TxRecord> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('transactions__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TxType, TxType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get feedGranted => $composableBuilder(
    column: $table.feedGranted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTutorial => $composableBuilder(
    column: $table.isTutorial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get feedGranted => $composableBuilder(
    column: $table.feedGranted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTutorial => $composableBuilder(
    column: $table.isTutorial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TxType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get feedGranted => $composableBuilder(
    column: $table.feedGranted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTutorial => $composableBuilder(
    column: $table.isTutorial,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          TxRecord,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TxRecord, $$TransactionsTableReferences),
          TxRecord,
          PrefetchHooks Function({bool categoryId})
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<TxType> type = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> feedGranted = const Value.absent(),
                Value<bool> isTutorial = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                amount: amount,
                currency: currency,
                type: type,
                categoryId: categoryId,
                date: date,
                note: note,
                feedGranted: feedGranted,
                isTutorial: isTutorial,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int amount,
                Value<String> currency = const Value.absent(),
                required TxType type,
                required String categoryId,
                required DateTime date,
                Value<String> note = const Value.absent(),
                Value<bool> feedGranted = const Value.absent(),
                Value<bool> isTutorial = const Value.absent(),
                required DateTime createdAt,
              }) => TransactionsCompanion.insert(
                id: id,
                amount: amount,
                currency: currency,
                type: type,
                categoryId: categoryId,
                date: date,
                note: note,
                feedGranted: feedGranted,
                isTutorial: isTutorial,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, TxRecord>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$TransactionsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$TransactionsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      TxRecord,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TxRecord, $$TransactionsTableReferences),
      TxRecord,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$FeedInventoryTableCreateCompanionBuilder =
    FeedInventoryCompanion Function({
      required FeedColor color,
      required FeedLevel level,
      Value<int> quantity,
      Value<int> rowid,
    });
typedef $$FeedInventoryTableUpdateCompanionBuilder =
    FeedInventoryCompanion Function({
      Value<FeedColor> color,
      Value<FeedLevel> level,
      Value<int> quantity,
      Value<int> rowid,
    });

class $$FeedInventoryTableFilterComposer
    extends Composer<_$AppDatabase, $FeedInventoryTable> {
  $$FeedInventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<FeedColor, FeedColor, String> get color =>
      $composableBuilder(
        column: $table.color,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FeedLevel, FeedLevel, String> get level =>
      $composableBuilder(
        column: $table.level,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedInventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedInventoryTable> {
  $$FeedInventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedInventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedInventoryTable> {
  $$FeedInventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<FeedColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedLevel, String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$FeedInventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedInventoryTable,
          FeedStock,
          $$FeedInventoryTableFilterComposer,
          $$FeedInventoryTableOrderingComposer,
          $$FeedInventoryTableAnnotationComposer,
          $$FeedInventoryTableCreateCompanionBuilder,
          $$FeedInventoryTableUpdateCompanionBuilder,
          (
            FeedStock,
            BaseReferences<_$AppDatabase, $FeedInventoryTable, FeedStock>,
          ),
          FeedStock,
          PrefetchHooks Function()
        > {
  $$FeedInventoryTableTableManager(_$AppDatabase db, $FeedInventoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedInventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedInventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedInventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<FeedColor> color = const Value.absent(),
                Value<FeedLevel> level = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedInventoryCompanion(
                color: color,
                level: level,
                quantity: quantity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required FeedColor color,
                required FeedLevel level,
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FeedInventoryCompanion.insert(
                color: color,
                level: level,
                quantity: quantity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedInventoryTable, FeedStock>(table),
                  BaseReferences<_$AppDatabase, $FeedInventoryTable, FeedStock>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedInventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedInventoryTable,
      FeedStock,
      $$FeedInventoryTableFilterComposer,
      $$FeedInventoryTableOrderingComposer,
      $$FeedInventoryTableAnnotationComposer,
      $$FeedInventoryTableCreateCompanionBuilder,
      $$FeedInventoryTableUpdateCompanionBuilder,
      (
        FeedStock,
        BaseReferences<_$AppDatabase, $FeedInventoryTable, FeedStock>,
      ),
      FeedStock,
      PrefetchHooks Function()
    >;
typedef $$FishesTableCreateCompanionBuilder = FishesCompanion Function({
  Value<int> id,
  required String speciesId,
  Value<bool> inTank,
  Value<double> satiety,
  required DateTime satietyAt,
  Value<bool> everPlaced,
  required DateTime createdAt,
});
typedef $$FishesTableUpdateCompanionBuilder = FishesCompanion Function({
  Value<int> id,
  Value<String> speciesId,
  Value<bool> inTank,
  Value<double> satiety,
  Value<DateTime> satietyAt,
  Value<bool> everPlaced,
  Value<DateTime> createdAt,
});

final class $$FishesTableReferences
    extends BaseReferences<_$AppDatabase, $FishesTable, Fish> {
  $$FishesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FeedingsTable, List<Feeding>> _feedingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.feedings,
    aliasName: 'fishes__id__feedings__fish_id',
  );

  $$FeedingsTableProcessedTableManager get feedingsRefs {
    final manager = $$FeedingsTableTableManager(
      $_db,
      $_db.feedings,
    ).filter((f) => f.fishId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_feedingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FishesTableFilterComposer
    extends Composer<_$AppDatabase, $FishesTable> {
  $$FishesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inTank => $composableBuilder(
    column: $table.inTank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get satiety => $composableBuilder(
    column: $table.satiety,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get satietyAt => $composableBuilder(
    column: $table.satietyAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get everPlaced => $composableBuilder(
    column: $table.everPlaced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> feedingsRefs(
    Expression<bool> Function($$FeedingsTableFilterComposer f) f,
  ) {
    final $$FeedingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedings,
      getReferencedColumn: (t) => t.fishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingsTableFilterComposer(
            $db: $db,
            $table: $db.feedings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FishesTableOrderingComposer
    extends Composer<_$AppDatabase, $FishesTable> {
  $$FishesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesId => $composableBuilder(
    column: $table.speciesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inTank => $composableBuilder(
    column: $table.inTank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get satiety => $composableBuilder(
    column: $table.satiety,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get satietyAt => $composableBuilder(
    column: $table.satietyAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get everPlaced => $composableBuilder(
    column: $table.everPlaced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FishesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FishesTable> {
  $$FishesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get speciesId =>
      $composableBuilder(column: $table.speciesId, builder: (column) => column);

  GeneratedColumn<bool> get inTank =>
      $composableBuilder(column: $table.inTank, builder: (column) => column);

  GeneratedColumn<double> get satiety =>
      $composableBuilder(column: $table.satiety, builder: (column) => column);

  GeneratedColumn<DateTime> get satietyAt =>
      $composableBuilder(column: $table.satietyAt, builder: (column) => column);

  GeneratedColumn<bool> get everPlaced => $composableBuilder(
    column: $table.everPlaced,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> feedingsRefs<T extends Object>(
    Expression<T> Function($$FeedingsTableAnnotationComposer a) f,
  ) {
    final $$FeedingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.feedings,
      getReferencedColumn: (t) => t.fishId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FeedingsTableAnnotationComposer(
            $db: $db,
            $table: $db.feedings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FishesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FishesTable,
          Fish,
          $$FishesTableFilterComposer,
          $$FishesTableOrderingComposer,
          $$FishesTableAnnotationComposer,
          $$FishesTableCreateCompanionBuilder,
          $$FishesTableUpdateCompanionBuilder,
          (Fish, $$FishesTableReferences),
          Fish,
          PrefetchHooks Function({bool feedingsRefs})
        > {
  $$FishesTableTableManager(_$AppDatabase db, $FishesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FishesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FishesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FishesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<bool> inTank = const Value.absent(),
                Value<double> satiety = const Value.absent(),
                Value<DateTime> satietyAt = const Value.absent(),
                Value<bool> everPlaced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FishesCompanion(
                id: id,
                speciesId: speciesId,
                inTank: inTank,
                satiety: satiety,
                satietyAt: satietyAt,
                everPlaced: everPlaced,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String speciesId,
                Value<bool> inTank = const Value.absent(),
                Value<double> satiety = const Value.absent(),
                required DateTime satietyAt,
                Value<bool> everPlaced = const Value.absent(),
                required DateTime createdAt,
              }) => FishesCompanion.insert(
                id: id,
                speciesId: speciesId,
                inTank: inTank,
                satiety: satiety,
                satietyAt: satietyAt,
                everPlaced: everPlaced,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FishesTable, Fish>(table),
                  $$FishesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({feedingsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (feedingsRefs) db.feedings],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (feedingsRefs)
                    await $_getPrefetchedData<Fish, $FishesTable, Feeding>(
                      currentTable: table,
                      referencedTable: $$FishesTableReferences
                          ._feedingsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$FishesTableReferences(db, table, p0).feedingsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.fishId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FishesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FishesTable,
      Fish,
      $$FishesTableFilterComposer,
      $$FishesTableOrderingComposer,
      $$FishesTableAnnotationComposer,
      $$FishesTableCreateCompanionBuilder,
      $$FishesTableUpdateCompanionBuilder,
      (Fish, $$FishesTableReferences),
      Fish,
      PrefetchHooks Function({bool feedingsRefs})
    >;
typedef $$FeedGrantsTableCreateCompanionBuilder = FeedGrantsCompanion Function({
  Value<int> id,
  Value<int?> txId,
  required FeedColor color,
  required FeedLevel level,
  required DateTime grantedAt,
});
typedef $$FeedGrantsTableUpdateCompanionBuilder = FeedGrantsCompanion Function({
  Value<int> id,
  Value<int?> txId,
  Value<FeedColor> color,
  Value<FeedLevel> level,
  Value<DateTime> grantedAt,
});

class $$FeedGrantsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedGrantsTable> {
  $$FeedGrantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get txId => $composableBuilder(
    column: $table.txId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeedColor, FeedColor, String> get color =>
      $composableBuilder(
        column: $table.color,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FeedLevel, FeedLevel, String> get level =>
      $composableBuilder(
        column: $table.level,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FeedGrantsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedGrantsTable> {
  $$FeedGrantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get txId => $composableBuilder(
    column: $table.txId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FeedGrantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedGrantsTable> {
  $$FeedGrantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get txId =>
      $composableBuilder(column: $table.txId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedColor, String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedLevel, String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);
}

class $$FeedGrantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedGrantsTable,
          FeedGrant,
          $$FeedGrantsTableFilterComposer,
          $$FeedGrantsTableOrderingComposer,
          $$FeedGrantsTableAnnotationComposer,
          $$FeedGrantsTableCreateCompanionBuilder,
          $$FeedGrantsTableUpdateCompanionBuilder,
          (
            FeedGrant,
            BaseReferences<_$AppDatabase, $FeedGrantsTable, FeedGrant>,
          ),
          FeedGrant,
          PrefetchHooks Function()
        > {
  $$FeedGrantsTableTableManager(_$AppDatabase db, $FeedGrantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedGrantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedGrantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedGrantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> txId = const Value.absent(),
                Value<FeedColor> color = const Value.absent(),
                Value<FeedLevel> level = const Value.absent(),
                Value<DateTime> grantedAt = const Value.absent(),
              }) => FeedGrantsCompanion(
                id: id,
                txId: txId,
                color: color,
                level: level,
                grantedAt: grantedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> txId = const Value.absent(),
                required FeedColor color,
                required FeedLevel level,
                required DateTime grantedAt,
              }) => FeedGrantsCompanion.insert(
                id: id,
                txId: txId,
                color: color,
                level: level,
                grantedAt: grantedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedGrantsTable, FeedGrant>(table),
                  BaseReferences<_$AppDatabase, $FeedGrantsTable, FeedGrant>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FeedGrantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedGrantsTable,
      FeedGrant,
      $$FeedGrantsTableFilterComposer,
      $$FeedGrantsTableOrderingComposer,
      $$FeedGrantsTableAnnotationComposer,
      $$FeedGrantsTableCreateCompanionBuilder,
      $$FeedGrantsTableUpdateCompanionBuilder,
      (FeedGrant, BaseReferences<_$AppDatabase, $FeedGrantsTable, FeedGrant>),
      FeedGrant,
      PrefetchHooks Function()
    >;
typedef $$FeedingsTableCreateCompanionBuilder = FeedingsCompanion Function({
  Value<int> id,
  required int fishId,
  required FeedColor feedColor,
  required FeedLevel feedLevel,
  required DateTime fedAt,
  required DateTime readyAt,
  Value<int?> remainingMs,
  Value<bool> completed,
});
typedef $$FeedingsTableUpdateCompanionBuilder = FeedingsCompanion Function({
  Value<int> id,
  Value<int> fishId,
  Value<FeedColor> feedColor,
  Value<FeedLevel> feedLevel,
  Value<DateTime> fedAt,
  Value<DateTime> readyAt,
  Value<int?> remainingMs,
  Value<bool> completed,
});

final class $$FeedingsTableReferences
    extends BaseReferences<_$AppDatabase, $FeedingsTable, Feeding> {
  $$FeedingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $FishesTable _fishIdTable(_$AppDatabase db) =>
      db.fishes.createAlias('feedings__fish_id__fishes__id');

  $$FishesTableProcessedTableManager get fishId {
    final $_column = $_itemColumn<int>('fish_id')!;

    final manager = $$FishesTableTableManager(
      $_db,
      $_db.fishes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fishIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FeedingsTableFilterComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<FeedColor, FeedColor, String> get feedColor =>
      $composableBuilder(
        column: $table.feedColor,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FeedLevel, FeedLevel, String> get feedLevel =>
      $composableBuilder(
        column: $table.feedLevel,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get fedAt => $composableBuilder(
    column: $table.fedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readyAt => $composableBuilder(
    column: $table.readyAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  $$FishesTableFilterComposer get fishId {
    final $$FishesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fishId,
      referencedTable: $db.fishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FishesTableFilterComposer(
            $db: $db,
            $table: $db.fishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingsTableOrderingComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedColor => $composableBuilder(
    column: $table.feedColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feedLevel => $composableBuilder(
    column: $table.feedLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fedAt => $composableBuilder(
    column: $table.fedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readyAt => $composableBuilder(
    column: $table.readyAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  $$FishesTableOrderingComposer get fishId {
    final $$FishesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fishId,
      referencedTable: $db.fishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FishesTableOrderingComposer(
            $db: $db,
            $table: $db.fishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FeedingsTable> {
  $$FeedingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedColor, String> get feedColor =>
      $composableBuilder(column: $table.feedColor, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FeedLevel, String> get feedLevel =>
      $composableBuilder(column: $table.feedLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get fedAt =>
      $composableBuilder(column: $table.fedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get readyAt =>
      $composableBuilder(column: $table.readyAt, builder: (column) => column);

  GeneratedColumn<int> get remainingMs => $composableBuilder(
    column: $table.remainingMs,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$FishesTableAnnotationComposer get fishId {
    final $$FishesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fishId,
      referencedTable: $db.fishes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FishesTableAnnotationComposer(
            $db: $db,
            $table: $db.fishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FeedingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FeedingsTable,
          Feeding,
          $$FeedingsTableFilterComposer,
          $$FeedingsTableOrderingComposer,
          $$FeedingsTableAnnotationComposer,
          $$FeedingsTableCreateCompanionBuilder,
          $$FeedingsTableUpdateCompanionBuilder,
          (Feeding, $$FeedingsTableReferences),
          Feeding,
          PrefetchHooks Function({bool fishId})
        > {
  $$FeedingsTableTableManager(_$AppDatabase db, $FeedingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FeedingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FeedingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FeedingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fishId = const Value.absent(),
                Value<FeedColor> feedColor = const Value.absent(),
                Value<FeedLevel> feedLevel = const Value.absent(),
                Value<DateTime> fedAt = const Value.absent(),
                Value<DateTime> readyAt = const Value.absent(),
                Value<int?> remainingMs = const Value.absent(),
                Value<bool> completed = const Value.absent(),
              }) => FeedingsCompanion(
                id: id,
                fishId: fishId,
                feedColor: feedColor,
                feedLevel: feedLevel,
                fedAt: fedAt,
                readyAt: readyAt,
                remainingMs: remainingMs,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fishId,
                required FeedColor feedColor,
                required FeedLevel feedLevel,
                required DateTime fedAt,
                required DateTime readyAt,
                Value<int?> remainingMs = const Value.absent(),
                Value<bool> completed = const Value.absent(),
              }) => FeedingsCompanion.insert(
                id: id,
                fishId: fishId,
                feedColor: feedColor,
                feedLevel: feedLevel,
                fedAt: fedAt,
                readyAt: readyAt,
                remainingMs: remainingMs,
                completed: completed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FeedingsTable, Feeding>(table),
                  $$FeedingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fishId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fishId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.fishId,
                        referencedTable: $$FeedingsTableReferences._fishIdTable(
                          db,
                        ),
                        referencedColumn: $$FeedingsTableReferences
                            ._fishIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FeedingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FeedingsTable,
      Feeding,
      $$FeedingsTableFilterComposer,
      $$FeedingsTableOrderingComposer,
      $$FeedingsTableAnnotationComposer,
      $$FeedingsTableCreateCompanionBuilder,
      $$FeedingsTableUpdateCompanionBuilder,
      (Feeding, $$FeedingsTableReferences),
      Feeding,
      PrefetchHooks Function({bool fishId})
    >;
typedef $$DroppedCoinsTableCreateCompanionBuilder =
    DroppedCoinsCompanion Function({
      Value<int> id,
      required int amount,
      required double x,
      required DateTime droppedAt,
    });
typedef $$DroppedCoinsTableUpdateCompanionBuilder =
    DroppedCoinsCompanion Function({
      Value<int> id,
      Value<int> amount,
      Value<double> x,
      Value<DateTime> droppedAt,
    });

class $$DroppedCoinsTableFilterComposer
    extends Composer<_$AppDatabase, $DroppedCoinsTable> {
  $$DroppedCoinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get droppedAt => $composableBuilder(
    column: $table.droppedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DroppedCoinsTableOrderingComposer
    extends Composer<_$AppDatabase, $DroppedCoinsTable> {
  $$DroppedCoinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get droppedAt => $composableBuilder(
    column: $table.droppedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DroppedCoinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DroppedCoinsTable> {
  $$DroppedCoinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<DateTime> get droppedAt =>
      $composableBuilder(column: $table.droppedAt, builder: (column) => column);
}

class $$DroppedCoinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DroppedCoinsTable,
          DroppedCoin,
          $$DroppedCoinsTableFilterComposer,
          $$DroppedCoinsTableOrderingComposer,
          $$DroppedCoinsTableAnnotationComposer,
          $$DroppedCoinsTableCreateCompanionBuilder,
          $$DroppedCoinsTableUpdateCompanionBuilder,
          (
            DroppedCoin,
            BaseReferences<_$AppDatabase, $DroppedCoinsTable, DroppedCoin>,
          ),
          DroppedCoin,
          PrefetchHooks Function()
        > {
  $$DroppedCoinsTableTableManager(_$AppDatabase db, $DroppedCoinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DroppedCoinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DroppedCoinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DroppedCoinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<double> x = const Value.absent(),
                Value<DateTime> droppedAt = const Value.absent(),
              }) => DroppedCoinsCompanion(
                id: id,
                amount: amount,
                x: x,
                droppedAt: droppedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int amount,
                required double x,
                required DateTime droppedAt,
              }) => DroppedCoinsCompanion.insert(
                id: id,
                amount: amount,
                x: x,
                droppedAt: droppedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DroppedCoinsTable, DroppedCoin>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $DroppedCoinsTable,
                    DroppedCoin
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DroppedCoinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DroppedCoinsTable,
      DroppedCoin,
      $$DroppedCoinsTableFilterComposer,
      $$DroppedCoinsTableOrderingComposer,
      $$DroppedCoinsTableAnnotationComposer,
      $$DroppedCoinsTableCreateCompanionBuilder,
      $$DroppedCoinsTableUpdateCompanionBuilder,
      (
        DroppedCoin,
        BaseReferences<_$AppDatabase, $DroppedCoinsTable, DroppedCoin>,
      ),
      DroppedCoin,
      PrefetchHooks Function()
    >;
typedef $$WalletTableCreateCompanionBuilder = WalletCompanion Function({
  Value<int> id,
  Value<int> coins,
});
typedef $$WalletTableUpdateCompanionBuilder = WalletCompanion Function({
  Value<int> id,
  Value<int> coins,
});

class $$WalletTableFilterComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalletTableOrderingComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalletTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalletTable> {
  $$WalletTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);
}

class $$WalletTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalletTable,
          WalletRow,
          $$WalletTableFilterComposer,
          $$WalletTableOrderingComposer,
          $$WalletTableAnnotationComposer,
          $$WalletTableCreateCompanionBuilder,
          $$WalletTableUpdateCompanionBuilder,
          (WalletRow, BaseReferences<_$AppDatabase, $WalletTable, WalletRow>),
          WalletRow,
          PrefetchHooks Function()
        > {
  $$WalletTableTableManager(_$AppDatabase db, $WalletTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalletTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalletTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalletTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> coins = const Value.absent(),
          }) => WalletCompanion(id: id, coins: coins),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> coins = const Value.absent(),
          }) => WalletCompanion.insert(id: id, coins: coins),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WalletTable, WalletRow>(table),
                  BaseReferences<_$AppDatabase, $WalletTable, WalletRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalletTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalletTable,
      WalletRow,
      $$WalletTableFilterComposer,
      $$WalletTableOrderingComposer,
      $$WalletTableAnnotationComposer,
      $$WalletTableCreateCompanionBuilder,
      $$WalletTableUpdateCompanionBuilder,
      (WalletRow, BaseReferences<_$AppDatabase, $WalletTable, WalletRow>),
      WalletRow,
      PrefetchHooks Function()
    >;
typedef $$TanksTableCreateCompanionBuilder = TanksCompanion Function({
  Value<int> id,
  Value<String> backgroundId,
  Value<String> floorId,
  Value<int> fishSlots,
  Value<int> decoSlots,
});
typedef $$TanksTableUpdateCompanionBuilder = TanksCompanion Function({
  Value<int> id,
  Value<String> backgroundId,
  Value<String> floorId,
  Value<int> fishSlots,
  Value<int> decoSlots,
});

class $$TanksTableFilterComposer extends Composer<_$AppDatabase, $TanksTable> {
  $$TanksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get floorId => $composableBuilder(
    column: $table.floorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fishSlots => $composableBuilder(
    column: $table.fishSlots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get decoSlots => $composableBuilder(
    column: $table.decoSlots,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TanksTableOrderingComposer
    extends Composer<_$AppDatabase, $TanksTable> {
  $$TanksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get floorId => $composableBuilder(
    column: $table.floorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fishSlots => $composableBuilder(
    column: $table.fishSlots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get decoSlots => $composableBuilder(
    column: $table.decoSlots,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TanksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TanksTable> {
  $$TanksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get floorId =>
      $composableBuilder(column: $table.floorId, builder: (column) => column);

  GeneratedColumn<int> get fishSlots =>
      $composableBuilder(column: $table.fishSlots, builder: (column) => column);

  GeneratedColumn<int> get decoSlots =>
      $composableBuilder(column: $table.decoSlots, builder: (column) => column);
}

class $$TanksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TanksTable,
          Tank,
          $$TanksTableFilterComposer,
          $$TanksTableOrderingComposer,
          $$TanksTableAnnotationComposer,
          $$TanksTableCreateCompanionBuilder,
          $$TanksTableUpdateCompanionBuilder,
          (Tank, BaseReferences<_$AppDatabase, $TanksTable, Tank>),
          Tank,
          PrefetchHooks Function()
        > {
  $$TanksTableTableManager(_$AppDatabase db, $TanksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TanksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TanksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TanksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> backgroundId = const Value.absent(),
                Value<String> floorId = const Value.absent(),
                Value<int> fishSlots = const Value.absent(),
                Value<int> decoSlots = const Value.absent(),
              }) => TanksCompanion(
                id: id,
                backgroundId: backgroundId,
                floorId: floorId,
                fishSlots: fishSlots,
                decoSlots: decoSlots,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> backgroundId = const Value.absent(),
                Value<String> floorId = const Value.absent(),
                Value<int> fishSlots = const Value.absent(),
                Value<int> decoSlots = const Value.absent(),
              }) => TanksCompanion.insert(
                id: id,
                backgroundId: backgroundId,
                floorId: floorId,
                fishSlots: fishSlots,
                decoSlots: decoSlots,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TanksTable, Tank>(table),
                  BaseReferences<_$AppDatabase, $TanksTable, Tank>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TanksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TanksTable,
      Tank,
      $$TanksTableFilterComposer,
      $$TanksTableOrderingComposer,
      $$TanksTableAnnotationComposer,
      $$TanksTableCreateCompanionBuilder,
      $$TanksTableUpdateCompanionBuilder,
      (Tank, BaseReferences<_$AppDatabase, $TanksTable, Tank>),
      Tank,
      PrefetchHooks Function()
    >;
typedef $$InventoryItemsTableCreateCompanionBuilder =
    InventoryItemsCompanion Function({
      required String itemId,
      Value<int> quantity,
      Value<int> rowid,
    });
typedef $$InventoryItemsTableUpdateCompanionBuilder =
    InventoryItemsCompanion Function({
      Value<String> itemId,
      Value<int> quantity,
      Value<int> rowid,
    });

class $$InventoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryItemsTable> {
  $$InventoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);
}

class $$InventoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryItemsTable,
          InventoryItem,
          $$InventoryItemsTableFilterComposer,
          $$InventoryItemsTableOrderingComposer,
          $$InventoryItemsTableAnnotationComposer,
          $$InventoryItemsTableCreateCompanionBuilder,
          $$InventoryItemsTableUpdateCompanionBuilder,
          (
            InventoryItem,
            BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
          ),
          InventoryItem,
          PrefetchHooks Function()
        > {
  $$InventoryItemsTableTableManager(
    _$AppDatabase db,
    $InventoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InventoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InventoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion(
                itemId: itemId,
                quantity: quantity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemId,
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemsCompanion.insert(
                itemId: itemId,
                quantity: quantity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InventoryItemsTable, InventoryItem>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $InventoryItemsTable,
                    InventoryItem
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryItemsTable,
      InventoryItem,
      $$InventoryItemsTableFilterComposer,
      $$InventoryItemsTableOrderingComposer,
      $$InventoryItemsTableAnnotationComposer,
      $$InventoryItemsTableCreateCompanionBuilder,
      $$InventoryItemsTableUpdateCompanionBuilder,
      (
        InventoryItem,
        BaseReferences<_$AppDatabase, $InventoryItemsTable, InventoryItem>,
      ),
      InventoryItem,
      PrefetchHooks Function()
    >;
typedef $$PlacementsTableCreateCompanionBuilder = PlacementsCompanion Function({
  Value<int> id,
  required String itemId,
  required double x,
  required double y,
  Value<int> layer,
  Value<bool> flipped,
});
typedef $$PlacementsTableUpdateCompanionBuilder = PlacementsCompanion Function({
  Value<int> id,
  Value<String> itemId,
  Value<double> x,
  Value<double> y,
  Value<int> layer,
  Value<bool> flipped,
});

class $$PlacementsTableFilterComposer
    extends Composer<_$AppDatabase, $PlacementsTable> {
  $$PlacementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get layer => $composableBuilder(
    column: $table.layer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get flipped => $composableBuilder(
    column: $table.flipped,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlacementsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacementsTable> {
  $$PlacementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get layer => $composableBuilder(
    column: $table.layer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get flipped => $composableBuilder(
    column: $table.flipped,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacementsTable> {
  $$PlacementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<double> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<double> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<int> get layer =>
      $composableBuilder(column: $table.layer, builder: (column) => column);

  GeneratedColumn<bool> get flipped =>
      $composableBuilder(column: $table.flipped, builder: (column) => column);
}

class $$PlacementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlacementsTable,
          Placement,
          $$PlacementsTableFilterComposer,
          $$PlacementsTableOrderingComposer,
          $$PlacementsTableAnnotationComposer,
          $$PlacementsTableCreateCompanionBuilder,
          $$PlacementsTableUpdateCompanionBuilder,
          (
            Placement,
            BaseReferences<_$AppDatabase, $PlacementsTable, Placement>,
          ),
          Placement,
          PrefetchHooks Function()
        > {
  $$PlacementsTableTableManager(_$AppDatabase db, $PlacementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<double> x = const Value.absent(),
                Value<double> y = const Value.absent(),
                Value<int> layer = const Value.absent(),
                Value<bool> flipped = const Value.absent(),
              }) => PlacementsCompanion(
                id: id,
                itemId: itemId,
                x: x,
                y: y,
                layer: layer,
                flipped: flipped,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String itemId,
                required double x,
                required double y,
                Value<int> layer = const Value.absent(),
                Value<bool> flipped = const Value.absent(),
              }) => PlacementsCompanion.insert(
                id: id,
                itemId: itemId,
                x: x,
                y: y,
                layer: layer,
                flipped: flipped,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PlacementsTable, Placement>(table),
                  BaseReferences<_$AppDatabase, $PlacementsTable, Placement>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlacementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlacementsTable,
      Placement,
      $$PlacementsTableFilterComposer,
      $$PlacementsTableOrderingComposer,
      $$PlacementsTableAnnotationComposer,
      $$PlacementsTableCreateCompanionBuilder,
      $$PlacementsTableUpdateCompanionBuilder,
      (Placement, BaseReferences<_$AppDatabase, $PlacementsTable, Placement>),
      Placement,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> currency,
  Value<int> cycleStartDay,
  Value<bool> reminderEnabled,
  Value<int> reminderMinutes,
  Value<bool> coinNotifyEnabled,
  Value<bool> soundEnabled,
  Value<DateTime?> lastBackupAt,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<int> id,
  Value<String> currency,
  Value<int> cycleStartDay,
  Value<bool> reminderEnabled,
  Value<int> reminderMinutes,
  Value<bool> coinNotifyEnabled,
  Value<bool> soundEnabled,
  Value<DateTime?> lastBackupAt,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get coinNotifyEnabled => $composableBuilder(
    column: $table.coinNotifyEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get coinNotifyEnabled => $composableBuilder(
    column: $table.coinNotifyEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<int> get cycleStartDay => $composableBuilder(
    column: $table.cycleStartDay,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinutes => $composableBuilder(
    column: $table.reminderMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get coinNotifyEnabled => $composableBuilder(
    column: $table.coinNotifyEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          AppSettings,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            AppSettings,
            BaseReferences<_$AppDatabase, $SettingsTable, AppSettings>,
          ),
          AppSettings,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> cycleStartDay = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderMinutes = const Value.absent(),
                Value<bool> coinNotifyEnabled = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                currency: currency,
                cycleStartDay: cycleStartDay,
                reminderEnabled: reminderEnabled,
                reminderMinutes: reminderMinutes,
                coinNotifyEnabled: coinNotifyEnabled,
                soundEnabled: soundEnabled,
                lastBackupAt: lastBackupAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<int> cycleStartDay = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int> reminderMinutes = const Value.absent(),
                Value<bool> coinNotifyEnabled = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                currency: currency,
                cycleStartDay: cycleStartDay,
                reminderEnabled: reminderEnabled,
                reminderMinutes: reminderMinutes,
                coinNotifyEnabled: coinNotifyEnabled,
                soundEnabled: soundEnabled,
                lastBackupAt: lastBackupAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, AppSettings>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, AppSettings>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      AppSettings,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (AppSettings, BaseReferences<_$AppDatabase, $SettingsTable, AppSettings>),
      AppSettings,
      PrefetchHooks Function()
    >;
typedef $$TutorialProgressTableCreateCompanionBuilder =
    TutorialProgressCompanion Function({
      Value<int> id,
      Value<int> step,
      Value<bool> completed,
      Value<bool> skipped,
      Value<bool> starterFeedGranted,
    });
typedef $$TutorialProgressTableUpdateCompanionBuilder =
    TutorialProgressCompanion Function({
      Value<int> id,
      Value<int> step,
      Value<bool> completed,
      Value<bool> skipped,
      Value<bool> starterFeedGranted,
    });

class $$TutorialProgressTableFilterComposer
    extends Composer<_$AppDatabase, $TutorialProgressTable> {
  $$TutorialProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get starterFeedGranted => $composableBuilder(
    column: $table.starterFeedGranted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TutorialProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $TutorialProgressTable> {
  $$TutorialProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get step => $composableBuilder(
    column: $table.step,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get starterFeedGranted => $composableBuilder(
    column: $table.starterFeedGranted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TutorialProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $TutorialProgressTable> {
  $$TutorialProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get step =>
      $composableBuilder(column: $table.step, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<bool> get skipped =>
      $composableBuilder(column: $table.skipped, builder: (column) => column);

  GeneratedColumn<bool> get starterFeedGranted => $composableBuilder(
    column: $table.starterFeedGranted,
    builder: (column) => column,
  );
}

class $$TutorialProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TutorialProgressTable,
          TutorialState,
          $$TutorialProgressTableFilterComposer,
          $$TutorialProgressTableOrderingComposer,
          $$TutorialProgressTableAnnotationComposer,
          $$TutorialProgressTableCreateCompanionBuilder,
          $$TutorialProgressTableUpdateCompanionBuilder,
          (
            TutorialState,
            BaseReferences<
              _$AppDatabase,
              $TutorialProgressTable,
              TutorialState
            >,
          ),
          TutorialState,
          PrefetchHooks Function()
        > {
  $$TutorialProgressTableTableManager(
    _$AppDatabase db,
    $TutorialProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TutorialProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TutorialProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TutorialProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> step = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<bool> starterFeedGranted = const Value.absent(),
              }) => TutorialProgressCompanion(
                id: id,
                step: step,
                completed: completed,
                skipped: skipped,
                starterFeedGranted: starterFeedGranted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> step = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<bool> starterFeedGranted = const Value.absent(),
              }) => TutorialProgressCompanion.insert(
                id: id,
                step: step,
                completed: completed,
                skipped: skipped,
                starterFeedGranted: starterFeedGranted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TutorialProgressTable, TutorialState>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TutorialProgressTable,
                    TutorialState
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TutorialProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TutorialProgressTable,
      TutorialState,
      $$TutorialProgressTableFilterComposer,
      $$TutorialProgressTableOrderingComposer,
      $$TutorialProgressTableAnnotationComposer,
      $$TutorialProgressTableCreateCompanionBuilder,
      $$TutorialProgressTableUpdateCompanionBuilder,
      (
        TutorialState,
        BaseReferences<_$AppDatabase, $TutorialProgressTable, TutorialState>,
      ),
      TutorialState,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$FeedInventoryTableTableManager get feedInventory =>
      $$FeedInventoryTableTableManager(_db, _db.feedInventory);
  $$FishesTableTableManager get fishes =>
      $$FishesTableTableManager(_db, _db.fishes);
  $$FeedGrantsTableTableManager get feedGrants =>
      $$FeedGrantsTableTableManager(_db, _db.feedGrants);
  $$FeedingsTableTableManager get feedings =>
      $$FeedingsTableTableManager(_db, _db.feedings);
  $$DroppedCoinsTableTableManager get droppedCoins =>
      $$DroppedCoinsTableTableManager(_db, _db.droppedCoins);
  $$WalletTableTableManager get wallet =>
      $$WalletTableTableManager(_db, _db.wallet);
  $$TanksTableTableManager get tanks =>
      $$TanksTableTableManager(_db, _db.tanks);
  $$InventoryItemsTableTableManager get inventoryItems =>
      $$InventoryItemsTableTableManager(_db, _db.inventoryItems);
  $$PlacementsTableTableManager get placements =>
      $$PlacementsTableTableManager(_db, _db.placements);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$TutorialProgressTableTableManager get tutorialProgress =>
      $$TutorialProgressTableTableManager(_db, _db.tutorialProgress);
}
