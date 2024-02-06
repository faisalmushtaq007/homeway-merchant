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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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
  bool get cacheHash => false;

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

class UnBindDriverWithStoresState extends StoreState {
  UnBindDriverWithStoresState({
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
  bool get cacheHash => false;

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

class BindProcessingState extends StoreState {
  BindProcessingState({
    required this.isProcessing,
    required this.message,
    this.bindDriverToStoreStage = BindingStage.none,
  });

  final bool isProcessing;
  final String message;
  final BindingStage bindDriverToStoreStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        bindDriverToStoreStage,
      ];
}

class BindExceptionState extends StoreState {
  BindExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.bindDriverToStoreStage = BindingStage.none,
  });

  final String message;
  final BindingStage bindDriverToStoreStage;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        bindDriverToStoreStage,
      ];
}

class BindLoadingState extends StoreState {
  BindLoadingState({
    required this.isLoading,
    required this.message,
    this.bindDriverToStoreStage = BindingStage.none,
  });

  final bool isLoading;
  final String message;
  final BindingStage bindDriverToStoreStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        bindDriverToStoreStage,
      ];
}

class BindEmptyState extends StoreState {
  BindEmptyState({
    required this.isEmpty,
    required this.message,
    this.bindDriverToStoreStage = BindingStage.none,
    this.storeOwnDeliveryPartnerEntities = const [],
  });

  final bool isEmpty;
  final String message;
  final BindingStage bindDriverToStoreStage;
  final List<StoreOwnDeliveryPartnersInfo> storeOwnDeliveryPartnerEntities;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        isEmpty,
        message,
        bindDriverToStoreStage,
        storeOwnDeliveryPartnerEntities,
      ];
}

class BindFailedState extends StoreState {
  BindFailedState({
    required this.message,
    this.bindDriverToStoreStage = BindingStage.none,
  });

  final String message;
  final BindingStage bindDriverToStoreStage;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        message,
        bindDriverToStoreStage,
      ];
}

class BindDriverWithUserState extends StoreState {
  BindDriverWithUserState({
    required this.appUserEntity,
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
  final AppUserEntity appUserEntity;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        listOfSelectedStoreOwnDeliveryPartners,
        storeStateStatus,
        message,
        bindingStage,
        appUserEntity,
      ];
}

class BindStoreWithUserState extends StoreState {
  BindStoreWithUserState({
    required this.appUserEntity,
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
  final AppUserEntity appUserEntity;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        storeEntities,
        listOfSelectedStoreEntities,
        storeStateStatus,
        message,
        bindingStage,
        appUserEntity,
      ];
}

class ReturnToStorePageState extends StoreState {
  ReturnToStorePageState({
    this.message = '',
    this.listOfStoreOwnDeliveryPartners =
        const <StoreOwnDeliveryPartnersInfo>[],
  });
  final String message;
  final List<StoreOwnDeliveryPartnersInfo> listOfStoreOwnDeliveryPartners;

  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        message,
      ];
}

class SelectDriversForStoresState extends StoreState {
  SelectDriversForStoresState(
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
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [
        listOfStoreOwnDeliveryPartners,
        listOfSelectedStoreOwnDeliveryPartners,
        selectItemUseCase,
        message,
      ];
}

// Get All Store Pagination State
class GetAllStorePaginationState extends StoreState {
  GetAllStorePaginationState({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.storeStateStage = StoreStateStage.getAllStoresPagination,
    this.storeEntities = const [],
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;
  final StoreStateStage storeStateStage;
  final List<StoreEntity> storeEntities;

  @override
  List<Object?> get hashParameters => [
        storeStateStage,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        storeEntities,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllLoadingStorePaginationState extends StoreState {
  GetAllLoadingStorePaginationState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllProcessingStorePaginationState extends StoreState {
  GetAllProcessingStorePaginationState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllFailedStorePaginationState extends StoreState {
  GetAllFailedStorePaginationState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get hashParameters => [
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllExceptionStorePaginationState extends StoreState {
  GetAllExceptionStorePaginationState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.storeStateStage = StoreStateStage.getAllStoresPagination,
  });

  final StoreStateStage storeStateStage;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        storeStateStage,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllEmptyStorePaginationState extends StoreState {
  GetAllEmptyStorePaginationState({
    this.storeEntities = const [],
    this.message = '',
    this.storeStateStage = StoreStateStage.getAllStoresPagination,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final List<StoreEntity> storeEntities;
  final String message;
  final StoreStateStage storeStateStage;
  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get hashParameters => [
        message,
        storeEntities,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        storeStateStage,
      ];

  @override
  bool get cacheHash => false;
}

// Get All Drivers Pagination
class GetAllDriversPaginationState extends StoreState {
  GetAllDriversPaginationState({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.driverStateStage = DriverStateStage.getAllDriversPagination,
    this.driverEntities = const [],
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;
  final DriverStateStage driverStateStage;
  final List<StoreOwnDeliveryPartnersInfo> driverEntities;

  @override
  List<Object?> get hashParameters => [
        driverStateStage,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        driverEntities,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllLoadingDriversPaginationState extends StoreState {
  GetAllLoadingDriversPaginationState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllProcessingDriversPaginationState extends StoreState {
  GetAllProcessingDriversPaginationState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllFailedDriversPaginationState extends StoreState {
  GetAllFailedDriversPaginationState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get hashParameters => [
        message,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllExceptionDriversPaginationState extends StoreState {
  GetAllExceptionDriversPaginationState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.driverStateStage = DriverStateStage.getAllDriversPagination,
  });

  final DriverStateStage driverStateStage;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        driverStateStage,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllEmptyDriversPaginationState extends StoreState {
  GetAllEmptyDriversPaginationState({
    this.driverEntities = const [],
    this.message = '',
    this.driverStateStage = DriverStateStage.getAllDriversPagination,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final List<StoreOwnDeliveryPartnersInfo> driverEntities;
  final String message;
  final DriverStateStage driverStateStage;
  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get hashParameters => [
        message,
        driverEntities,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        driverStateStage,
      ];

  @override
  bool get cacheHash => false;
}
