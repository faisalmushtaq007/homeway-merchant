part of 'store_bloc.dart';

abstract class StoreEvent {}

class SaveStore extends StoreEvent with AppEquatable {
  SaveStore({
    required this.storeEntity,
    required this.hasNewStore,
    this.currentIndex = -1,
  });

  final StoreEntity storeEntity;
  final bool hasNewStore;
  final int currentIndex;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        hasNewStore,
        currentIndex,
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

// Driver
class SaveDriver extends StoreEvent with AppEquatable {
  SaveDriver({
    required this.storeOwnDeliveryPartnerEntity,
    required this.haveNewDriver,
    this.currentIndex = -1,
  });

  final StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
  final bool haveNewDriver;
  final int currentIndex;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        haveNewDriver,
        currentIndex,
      ];
}

class DeleteDriver extends StoreEvent with AppEquatable {
  DeleteDriver({
    this.storeOwnDeliveryPartnerEntity,
    this.index = -1,
    this.driverID = '',
    this.storeEntities = const [],
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeEntities;
  final String driverID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeEntities,
        driverID,
      ];
}

class DeleteAllDriver extends StoreEvent with AppEquatable {
  DeleteAllDriver({this.storeEntities = const []});

  final List<StoreOwnDeliveryPartnersInfo> storeEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeEntities];
}

class GetAllDriver extends StoreEvent with AppEquatable {
  GetAllDriver();

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [];
}

class GetDriver extends StoreEvent with AppEquatable {
  GetDriver({
    this.storeOwnDeliveryPartnerEntity,
    this.index = -1,
    this.storeOwnDeliveryPartnerEntities = const [],
    this.storeID = '',
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final String storeID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeOwnDeliveryPartnerEntities,
        storeID,
      ];
}
