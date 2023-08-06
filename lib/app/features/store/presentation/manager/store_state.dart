part of 'store_bloc.dart';

abstract class StoreState with AppEquatable {}

class StoreInitial extends StoreState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SaveStoreState extends StoreState {
  SaveStoreState({
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

class StoreLoadingState extends StoreState {
  StoreLoadingState({
    required this.isLoading,
    required this.message,
    this.storeStateStage = StoreStateStage.none,
  });

  final bool isLoading;
  final String message;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        storeStateStage,
      ];
}

class StoreProcessingState extends StoreState {
  StoreProcessingState({
    required this.isProcessing,
    required this.message,
    this.storeStateStage = StoreStateStage.none,
  });

  final bool isProcessing;
  final String message;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        storeStateStage,
      ];
}

class StoreFailedState extends StoreState {
  StoreFailedState({
    required this.message,
    this.storeStateStage = StoreStateStage.none,
  });

  final String message;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        storeStateStage,
      ];
}

class StoreExceptionState extends StoreState {
  StoreExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.storeStateStage = StoreStateStage.none,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        storeStateStage,
      ];
}

class DeleteStoreState extends StoreState {
  DeleteStoreState({
    this.storeEntity,
    this.index = -1,
    this.storeID = '',
    this.storeEntities = const [],
    this.hasDelete = false,
  });

  final StoreEntity? storeEntity;
  final int index;
  final List<StoreEntity> storeEntities;
  final String storeID;
  final bool hasDelete;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        index,
        storeEntities,
        storeID,
        hasDelete,
      ];
}

class DeleteAllStoreState extends StoreState {
  DeleteAllStoreState({
    this.storeEntities = const [],
    this.hasDeleteAll = false,
  });

  final List<StoreEntity> storeEntities;
  final bool hasDeleteAll;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [storeEntities, hasDeleteAll];
}

class GetAllStoreState extends StoreState {
  GetAllStoreState({
    this.storeEntities = const [],
    this.storeStateStage = StoreStateStage.getAllStore,
  });

  final List<StoreEntity> storeEntities;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntities,
        storeStateStage,
      ];
}

class GetEmptyStoreState extends StoreState {
  GetEmptyStoreState({
    this.storeEntities = const [],
    this.message = '',
    this.storeStateStage = StoreStateStage.none,
  });

  final List<StoreEntity> storeEntities;
  final String message;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntities,
        message,
        storeStateStage,
      ];
}

class GetStoreState extends StoreState {
  GetStoreState({
    this.storeEntity,
    this.index = -1,
    this.storeEntities = const [],
    this.storeID = '',
    this.storeStateStage = StoreStateStage.none,
  });

  final StoreEntity? storeEntity;
  final int index;
  final List<StoreEntity> storeEntities;
  final String storeID;
  final StoreStateStage storeStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeEntity,
        index,
        storeEntities,
        storeID,
        storeStateStage,
      ];
}

// Driver
class SaveDriverState extends StoreState {
  SaveDriverState({
    required this.storeOwnDeliveryPartnerEntity,
    required this.hasNewDriver,
    this.driverStateStage = DriverStateStage.saveDriver,
    this.currentIndex = -1,
  });

  final StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
  final bool hasNewDriver;
  final DriverStateStage driverStateStage;
  final int currentIndex;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        hasNewDriver,
        driverStateStage,
        currentIndex,
      ];
}

class NavigateToNewDriverGreetingPageState extends StoreState {
  NavigateToNewDriverGreetingPageState({
    required this.storeOwnDeliveryPartnerEntity,
    required this.hasNewDriver,
    this.driverStateStage = DriverStateStage.saveDriver,
  });

  final StoreOwnDeliveryPartnersInfo storeOwnDeliveryPartnerEntity;
  final bool hasNewDriver;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        hasNewDriver,
        driverStateStage,
      ];
}

class DeleteDriverState extends StoreState {
  DeleteDriverState({
    this.storeOwnDeliveryPartnerEntity,
    this.index = -1,
    this.driverID = '',
    this.storeOwnDeliveryPartnerEntities = const [],
    this.driverStateStage = DriverStateStage.deleteDriver,
    this.hasDelete = true,
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final String driverID;
  final DriverStateStage driverStateStage;
  final bool hasDelete;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeOwnDeliveryPartnerEntities,
        driverID,
        driverStateStage,
        hasDelete,
      ];
}

class DeleteAllDriverState extends StoreState {
  DeleteAllDriverState({
    this.storeOwnDeliveryPartnerEntities = const [],
    this.driverStateStage = DriverStateStage.deleteAllDriver,
    this.hasDeleteAll = false,
    this.message = '',
  });

  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final DriverStateStage driverStateStage;
  final bool hasDeleteAll;
  final String message;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntities,
        driverStateStage,
        hasDeleteAll,
        message,
      ];
}

class GetAllDriverState extends StoreState {
  GetAllDriverState({
    this.storeOwnDeliveryPartnerEntities = const [],
    this.driverStateStage = DriverStateStage.none,
  });

  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntities,
        driverStateStage,
      ];
}

class GetDriverState extends StoreState {
  GetDriverState({
    this.storeOwnDeliveryPartnerEntity,
    this.index = -1,
    this.storeOwnDeliveryPartnerEntities = const [],
    this.driverID = '',
    this.driverStateStage = DriverStateStage.none,
  });

  final StoreOwnDeliveryPartnersInfo? storeOwnDeliveryPartnerEntity;
  final int index;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;
  final String driverID;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        storeOwnDeliveryPartnerEntity,
        index,
        storeOwnDeliveryPartnerEntities,
        driverID,
        driverStateStage,
      ];
}

class DriverLoadingState extends StoreState {
  DriverLoadingState({
    required this.isLoading,
    required this.message,
    this.driverStateStage = DriverStateStage.none,
  });

  final bool isLoading;
  final String message;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        driverStateStage,
      ];
}

class DriverProcessingState extends StoreState {
  DriverProcessingState({
    required this.isProcessing,
    required this.message,
    this.driverStateStage = DriverStateStage.none,
  });

  final bool isProcessing;
  final String message;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        driverStateStage,
      ];
}

class DriverFailedState extends StoreState {
  DriverFailedState({
    required this.message,
    this.driverStateStage = DriverStateStage.none,
  });

  final String message;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        driverStateStage,
      ];
}

class DriverExceptionState extends StoreState {
  DriverExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.driverStateStage = DriverStateStage.none,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;
  final DriverStateStage driverStateStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        driverStateStage,
      ];
}

class DriverEmptyState extends StoreState {
  DriverEmptyState({
    required this.isEmpty,
    required this.message,
    this.driverStateStage = DriverStateStage.none,
    this.storeOwnDeliveryPartnerEntities = const [],
  });

  final bool isEmpty;
  final String message;
  final DriverStateStage driverStateStage;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isEmpty,
        message,
        driverStateStage,
        storeOwnDeliveryPartnerEntities,
      ];
}

class BindDriverWithStoresState extends StoreState {
  BindDriverWithStoresState({
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

class BindDriverWithStoresProcessingState extends StoreState {
  BindDriverWithStoresProcessingState({
    required this.isProcessing,
    required this.message,
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
  });

  final bool isProcessing;
  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        bindDriverToStoreStage,
      ];
}

class BindDriverWithStoresExceptionState extends StoreState {
  BindDriverWithStoresExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
  });

  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        bindDriverToStoreStage,
      ];
}

class BindDriverWithStoresLoadingState extends StoreState {
  BindDriverWithStoresLoadingState({
    required this.isLoading,
    required this.message,
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
  });

  final bool isLoading;
  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        bindDriverToStoreStage,
      ];
}

class BindDriverWithStoresEmptyState extends StoreState {
  BindDriverWithStoresEmptyState({
    required this.isEmpty,
    required this.message,
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
    this.storeOwnDeliveryPartnerEntities = const [],
  });

  final bool isEmpty;
  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isEmpty,
        message,
        bindDriverToStoreStage,
        storeOwnDeliveryPartnerEntities,
      ];
}

class BindDriverWithStoresFailedState extends StoreState {
  BindDriverWithStoresFailedState({
    required this.message,
    this.bindDriverToStoreStage = BindDriverToStoreStage.none,
  });

  final String message;
  final BindDriverToStoreStage bindDriverToStoreStage;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        bindDriverToStoreStage,
      ];
}
