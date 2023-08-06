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
    this.storeOwnDeliveryPartnerEntities = const [],
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final String driverID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeOwnDeliveryPartnerEntities,
        driverID,
      ];
}

class DeleteAllDriver extends StoreEvent with AppEquatable {
  DeleteAllDriver({this.storeOwnDeliveryPartnerEntity = const []});

  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeOwnDeliveryPartnerEntity];
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
    this.driverID = '',
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final String driverID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeOwnDeliveryPartnerEntities,
        driverID,
      ];
}

class BindDriverWithStores extends StoreEvent with AppEquatable {
  BindDriverWithStores({
    this.listOfStoreOwnDeliveryPartners = const [],
    this.listOfSelectedStoreOwnDeliveryPartners = const [],
    this.storeEntities = const [],
    this.storeStateStatus = StoreStateStage.none,
    this.message = '',
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
    this.listOfSelectedStoreEntities = const [],
  });

  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo> listOfSelectedStoreOwnDeliveryPartners;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;
  final StoreStateStage storeStateStatus;
  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        listOfSelectedStoreOwnDeliveryPartners,
        storeEntities,
        storeStateStatus,
        message,
        bindDriverToStoreStage,
        listOfSelectedStoreEntities,
      ];
}
