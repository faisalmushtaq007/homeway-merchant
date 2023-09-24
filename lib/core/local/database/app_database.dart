import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class AppDatabase {
  // A private constructor. Allows us to create instances of AppDatabase
  // only from within the AppDatabase class itself.
  AppDatabase._();

  // Singleton instance
  static final AppDatabase _singleton = AppDatabase._();

  // Singleton accessor
  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database>? _dbOpenCompleter;

  bool isInitialized = false;
  StoreRef<int, Map<String, dynamic>> _user =
      StoreRef<int, Map<String, dynamic>>('user');
  StoreRef<int, Map<String, dynamic>> get user => _user;

  StoreRef<int, Map<String, dynamic>> _store =
      StoreRef<int, Map<String, dynamic>>('store');
  StoreRef<int, Map<String, dynamic>> get store => _store;

  StoreRef<int, Map<String, dynamic>> _menu =
      StoreRef<int, Map<String, dynamic>>('menu');
  StoreRef<int, Map<String, dynamic>> get menu => _menu;

  StoreRef<int, Map<String, dynamic>> _addons =
      StoreRef<int, Map<String, dynamic>>('addons');
  StoreRef<int, Map<String, dynamic>> get addons => _addons;

  StoreRef<int, Map<String, dynamic>> _driver =
      StoreRef<int, Map<String, dynamic>>('driver');
  StoreRef<int, Map<String, dynamic>> get driver => _driver;

  StoreRef<int, Map<String, dynamic>> _businessProfile =
      StoreRef<int, Map<String, dynamic>>('business_profile');
  StoreRef<int, Map<String, dynamic>> get businessProfile => _businessProfile;

  StoreRef<int, Map<String, dynamic>> _businessDocument =
      StoreRef<int, Map<String, dynamic>>('business_document');
  StoreRef<int, Map<String, dynamic>> get businessDocument => _businessDocument;

  StoreRef<int, Map<String, dynamic>> _paymentBank =
      StoreRef<int, Map<String, dynamic>>('payment_bank');
  StoreRef<int, Map<String, dynamic>> get paymentBank => _paymentBank;

  StoreRef<int, Map<String, dynamic>> _address =
      StoreRef<int, Map<String, dynamic>>('address');
  StoreRef<int, Map<String, dynamic>> get address => _address;

  StoreRef<int, Map<String, dynamic>> _notification =
      StoreRef<int, Map<String, dynamic>>('notification');
  StoreRef<int, Map<String, dynamic>> get notification => _notification;

  StoreRef<int, Map<String, dynamic>> _order =
      StoreRef<int, Map<String, dynamic>>('order');
  StoreRef<int, Map<String, dynamic>> get order => _order;

  StoreRef<int, Map<String, dynamic>> _rateAndReview =
      StoreRef<int, Map<String, dynamic>>('rateAndReview');
  StoreRef<int, Map<String, dynamic>> get rateAndReview => _rateAndReview;

  StoreRef<int, Map<String, dynamic>> _category =
      StoreRef<int, Map<String, dynamic>>('category');
  StoreRef<int, Map<String, dynamic>> get category => _category;
  //late RecordRef<int, Map<String, dynamic>> _record;

  //var factory = databaseFactoryWeb;
  // Database object accessor
  Future<Database> get database async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      // Calling _openDatabase will also complete the completer with database instance
      await _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter!.future;
  }

  Future<void> _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final appDocumentDir = await getApplicationDocumentsDirectory();
    // Path with the form: /platform-specific-directory/demo.db
    final dbPath = join(appDocumentDir.path, 'homewaymerchant.db');
    _user = StoreRef<int, Map<String, dynamic>>('user');
    _store = StoreRef<int, Map<String, dynamic>>('store');
    _menu = StoreRef<int, Map<String, dynamic>>('menu');
    _addons = StoreRef<int, Map<String, dynamic>>('addons');
    _driver = StoreRef<int, Map<String, dynamic>>('driver');
    _businessProfile = StoreRef<int, Map<String, dynamic>>('business_profile');
    _businessDocument =
        StoreRef<int, Map<String, dynamic>>('business_document');
    _paymentBank = StoreRef<int, Map<String, dynamic>>('payment_bank');
    _address = StoreRef<int, Map<String, dynamic>>('address');
    _notification = StoreRef<int, Map<String, dynamic>>('notification');
    _order = StoreRef<int, Map<String, dynamic>>('order');
    _rateAndReview = StoreRef<int, Map<String, dynamic>>('rateAndReview');
    _category = StoreRef<int, Map<String, dynamic>>('category');
    Database database;
    if (kIsWeb) {
      final factory = databaseFactoryWeb;
      database = await factory.openDatabase(dbPath);
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }
    isInitialized = true;
    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter?.complete(database);
  }
}
