part of 'address_bloc.dart';

abstract class AddressState with AppEquatable {}

class AddressInitial extends AddressState {
  @override
  bool get cacheHash => false;

  @override
  List<Object?> get hashParameters => [];
}

class SaveAddressState extends AddressState {
  SaveAddressState({required this.addressEntity, required this.hasNewAddress, this.currentIndex = -1});

  final AddressModel addressEntity;
  final bool hasNewAddress;
  final int currentIndex;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addressEntity,
        hasNewAddress,
        currentIndex,
      ];
}

class RemoveAddressByIDState extends AddressState {
  RemoveAddressByIDState({
    this.addressEntity,
    this.index = -1,
    this.addressID = -1,
    this.addressEntities = const [],
    this.hasRemove = false,
  });

  final AddressModel? addressEntity;
  final int index;
  final List<AddressModel> addressEntities;
  final int addressID;
  final bool hasRemove;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity, index, addressEntities, addressID, hasRemove];
}

class RemoveAllAddressState extends AddressState {
  RemoveAllAddressState({
    this.addressEntities = const [],
    this.hasRemoveAll = false,
  });

  final List<AddressModel> addressEntities;
  final bool hasRemoveAll;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntities, hasRemoveAll];
}

class GetAddressByIDState extends AddressState {
  GetAddressByIDState({
    this.addressEntity,
    this.index = -1,
    this.addressEntities = const [],
    this.addressID = -1,
    this.addressStatus = AddressStatus.none,
  });

  final AddressModel? addressEntity;
  final int index;
  final List<AddressModel> addressEntities;
  final int addressID;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addressEntity,
        index,
        addressEntities,
        addressID,
        addressStatus,
      ];
}

class GetAllAddressState extends AddressState {
  GetAllAddressState({
    this.addressEntities = const [],
    this.addressStatus = AddressStatus.none,
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 1,
  });

  final List<AddressModel> addressEntities;
  final AddressStatus addressStatus;
  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  List<Object?> get hashParameters => [addressEntities, addressStatus, pageKey, pageSize, searchItem];

  @override
  bool get cacheHash => true;
}

class SelectAllAddressState extends AddressState {
  SelectAllAddressState({this.addressEntities = const []});

  final List<AddressModel> addressEntities;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntities];
}

class SelectDefaultAddressState extends AddressState {
  SelectDefaultAddressState({
    this.addressEntity,
    this.index = -1,
    this.addressEntities = const [],
    this.addressID = -1,
  });

  final AddressModel? addressEntity;
  final int index;
  final List<AddressModel> addressEntities;
  final int addressID;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addressEntity,
        index,
        addressEntities,
        addressID,
      ];
}

class ConfirmationOnDefaultAddressState extends AddressState {
  ConfirmationOnDefaultAddressState({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity];
}

class SelectCurrentAddressState extends AddressState {
  SelectCurrentAddressState({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity];
}

class AddressLoadingState extends AddressState {
  AddressLoadingState({
    required this.message,
    this.isLoading = true,
    this.addressStatus = AddressStatus.none,
  });

  final bool isLoading;
  final String message;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isLoading,
        message,
        addressStatus,
      ];
}

class AddressProcessingState extends AddressState {
  AddressProcessingState({
    required this.message,
    this.isProcessing = true,
    this.addressStatus = AddressStatus.none,
  });

  final bool isProcessing;
  final String message;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        isProcessing,
        message,
        addressStatus,
      ];
}

class AddressFailedState extends AddressState {
  AddressFailedState({
    required this.message,
    this.addressStatus = AddressStatus.none,
  });

  final String message;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        message,
        addressStatus,
      ];
}

class AddressExceptionState extends AddressState {
  AddressExceptionState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.addressStatus = AddressStatus.none,
  });

  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [message, stackTrace, exception, addressStatus];
}

class AddressEmptyState extends AddressState {
  AddressEmptyState({
    this.addressEntities = const [],
    this.message = '',
    this.addressStatus = AddressStatus.none,
  });

  final List<AddressModel> addressEntities;
  final String message;
  final AddressStatus addressStatus;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [
        addressEntities,
        message,
        addressStatus,
      ];
}

// Get All Address state
class GetAllAddressPaginationState extends AddressState {
  GetAllAddressPaginationState({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
    this.addressStatus = AddressStatus.getAllAddressPagination,
    this.addressEntities = const [],
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;
  final AddressStatus addressStatus;
  final List<AddressModel> addressEntities;

  @override
  List<Object?> get hashParameters => [
        addressStatus,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
        addressEntities,
      ];

  @override
  bool get cacheHash => false;
}

class GetAllLoadingAddressPaginationState extends AddressState {
  GetAllLoadingAddressPaginationState({
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

class GetAllProcessingAddressPaginationState extends AddressState {
  GetAllProcessingAddressPaginationState({
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

class GetAllFailedAddressPaginationState extends AddressState {
  GetAllFailedAddressPaginationState({
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

class GetAllExceptionAddressPaginationState extends AddressState {
  GetAllExceptionAddressPaginationState({
    required this.message,
    this.stackTrace,
    this.exception,
    this.addressStatus = AddressStatus.getAllAddressPagination,
  });

  final AddressStatus addressStatus;
  final String message;
  final StackTrace? stackTrace;
  final Exception? exception;

  @override
  List<Object?> get hashParameters => [
        message,
        stackTrace,
        exception,
        addressStatus,
      ];
  @override
  bool get cacheHash => false;
}

class GetAllEmptyAddressPaginationState extends AddressState {
  GetAllEmptyAddressPaginationState({
    this.addressEntities = const [],
    this.message = '',
    this.addressStatus = AddressStatus.getAllAddressPagination,
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final List<AddressModel> addressEntities;
  final String message;
  final AddressStatus addressStatus;
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
        addressEntities,
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
  @override
  bool get cacheHash => false;
}
