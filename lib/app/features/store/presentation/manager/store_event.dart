part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class SaveStore extends StoreEvent with AppEquatable {
  SaveStore({
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

class DeleteStore extends StoreEvent with AppEquatable {
  DeleteStore({
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

class DeleteAllStore extends StoreEvent with AppEquatable {
  DeleteAllStore({this.storeEntities = const []});

  final List<StoreEntity> storeEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeEntities];
}

class GetAllStore extends StoreEvent with AppEquatable {
  GetAllStore();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
}

class GetStore extends StoreEvent with AppEquatable {
  GetStore({
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
