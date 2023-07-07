part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class StoreInitial extends StoreState {}

class SaveStoreState extends StoreState with AppEquatable {
  SaveStoreState({
    required this.storeEntity,
    required this.hasNewStore,
  });

  final StoreEntity storeEntity;
  final bool hasNewStore;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        hasNewStore,
      ];
}

class StoreLoadingState extends StoreState with AppEquatable {
  StoreLoadingState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
      ];
}

class StoreProcessingState extends StoreState with AppEquatable {
  StoreProcessingState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
      ];
}

class StoreFailedState extends StoreState with AppEquatable {
  StoreFailedState({
    required this.message,
  });

  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
      ];
}

class StoreExceptionState extends StoreState with AppEquatable {
  StoreExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
      ];
}

class DeleteStoreState extends StoreState with AppEquatable {
  DeleteStoreState({
    this.storeEntity,
    this.index = -1,
    this.storeID = '',
    this.storeEntities = const [],
  });

  final StoreEntity? storeEntity;
  final int index;
  final List<StoreEntity> storeEntities;
  final String storeID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        index,
        storeEntities,
        storeID,
      ];
}

class DeleteAllStoreState extends StoreState with AppEquatable {
  DeleteAllStoreState({this.storeEntities = const []});

  final List<StoreEntity> storeEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeEntities];
}

class GetAllStoreState extends StoreState with AppEquatable {
  GetAllStoreState({this.storeEntities = const []});

  final List<StoreEntity> storeEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntities,
      ];
}

class GetStoreState extends StoreState with AppEquatable {
  GetStoreState({
    this.storeEntity,
    this.index = -1,
    this.storeEntities = const [],
    this.storeID = '',
  });

  final StoreEntity? storeEntity;
  final int index;
  final List<StoreEntity> storeEntities;
  final String storeID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        index,
        storeEntities,
        storeID,
      ];
}
