part of 'store_bloc.dart';

abstract class StoreEvent with AppEquatable {}

class SaveStore extends StoreEvent {
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

class DeleteStore extends StoreEvent {
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

class DeleteAllStore extends StoreEvent {
  DeleteAllStore({this.storeEntities = const []});

  final List<StoreEntity> storeEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeEntities];
}

class GetAllStore extends StoreEvent {
  GetAllStore({
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });
  final int pageKey;
  final int pageSize;
  final String searchItem;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        pageKey,
        pageSize,
        searchItem,
      ];
}

class GetStore extends StoreEvent {
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
class SaveDriver extends StoreEvent {
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

class DeleteDriver extends StoreEvent {
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

class DeleteAllDriver extends StoreEvent {
  DeleteAllDriver({this.storeOwnDeliveryPartnerEntity = const []});

  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeOwnDeliveryPartnerEntity];
}

class GetAllDriver extends StoreEvent {
  GetAllDriver({
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [pageKey, pageSize, searchItem];
}

class GetDriver extends StoreEvent {
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

class BindDriverWithStores extends StoreEvent {
  BindDriverWithStores({
    this.listOfStoreOwnDeliveryPartners = const [],
    this.listOfSelectedStoreOwnDeliveryPartners = const [],
    this.storeEntities = const [],
    this.storeStateStatus = StoreStateStage.none,
    this.message = '',
    this.bindDriverToStoreStage = BindingStage.none,
    this.listOfSelectedStoreEntities = const [],
  });

  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo>
      listOfSelectedStoreOwnDeliveryPartners;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;
  final StoreStateStage storeStateStatus;
  final String message;
  final BindingStage bindDriverToStoreStage;

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

class UnBindDriverWithStores extends StoreEvent {
  UnBindDriverWithStores({
    this.listOfStoreOwnDeliveryPartners = const [],
    this.listOfSelectedStoreOwnDeliveryPartners = const [],
    this.storeEntities = const [],
    this.storeStateStatus = StoreStateStage.none,
    this.message = '',
    this.bindDriverToStoreStage = BindingStage.none,
    this.listOfSelectedStoreEntities = const [],
  });

  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo>
      listOfSelectedStoreOwnDeliveryPartners;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;
  final StoreStateStage storeStateStatus;
  final String message;
  final BindingStage bindDriverToStoreStage;

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

class BindDriverWithUser extends StoreEvent {
  BindDriverWithUser({
    this.listOfStoreOwnDeliveryPartners = const [],
    this.listOfSelectedStoreOwnDeliveryPartners = const [],
    this.storeStateStatus = StoreStateStage.none,
    this.message = '',
    this.bindingStage = BindingStage.none,
  });

  final StoreStateStage storeStateStatus;
  final String message;
  final BindingStage bindingStage;
  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo>
      listOfSelectedStoreOwnDeliveryPartners;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        listOfSelectedStoreOwnDeliveryPartners,
        storeStateStatus,
        message,
        bindingStage,
      ];
}

class BindStoreWithUser extends StoreEvent {
  BindStoreWithUser({
    this.storeEntities = const [],
    this.listOfSelectedStoreEntities = const [],
    this.storeStateStatus = StoreStateStage.none,
    this.message = '',
    this.bindingStage = BindingStage.none,
  });

  final StoreStateStage storeStateStatus;
  final String message;
  final BindingStage bindingStage;
  final List<StoreEntity> storeEntities;
  final List<StoreEntity> listOfSelectedStoreEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntities,
        listOfSelectedStoreEntities,
        storeStateStatus,
        message,
        bindingStage,
      ];
}

class ReturnToStorePage extends StoreEvent {
  ReturnToStorePage({
    this.message = '',
    this.listOfStoreOwnDeliveryPartners =
        const <StoreOwnDeliveryPartnersInfo>[],
  });
  final String message;
  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        message,
      ];
}

class SelectDriversForStores extends StoreEvent {
  SelectDriversForStores(
      {this.listOfStoreOwnDeliveryPartners = const [],
      this.listOfSelectedStoreOwnDeliveryPartners = const [],
      this.message = '',
      this.selectItemUseCase = SelectItemUseCase.bindingWithOther});

  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;
  final List<StoreOwnDeliveryPartnersInfo>
      listOfSelectedStoreOwnDeliveryPartners;

  final String message;
  final SelectItemUseCase selectItemUseCase;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        listOfSelectedStoreOwnDeliveryPartners,
        selectItemUseCase,
        message,
      ];
}
