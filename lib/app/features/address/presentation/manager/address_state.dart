part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
}

class AddressInitial extends AddressState {
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get props => [];
}

class SaveAddressState extends AddressState {
  const SaveAddressState({required this.addressEntity, required this.hasNewAddress, this.currentIndex = -1});

  final AddressModel addressEntity;
  final bool hasNewAddress;
  final int currentIndex;

  @override
  List<Object?> get props => [
        addressEntity,
        hasNewAddress,
        currentIndex,
      ];
}

class RemoveAddressByIDState extends AddressState {
  const RemoveAddressByIDState({
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
  List<Object?> get props => [addressEntity, index, addressEntities, addressID, hasRemove];
}

class RemoveAllAddressState extends AddressState {
  const RemoveAllAddressState({
    this.addressEntities = const [],
    this.hasRemoveAll = false,
  });

  final List<AddressModel> addressEntities;
  final bool hasRemoveAll;

  @override
  List<Object?> get props => [addressEntities, hasRemoveAll];
}

class GetAddressByIDState extends AddressState {
  const GetAddressByIDState({
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
  List<Object?> get props => [
        addressEntity,
        index,
        addressEntities,
        addressID,
        addressStatus,
      ];
}

class GetAllAddressState extends AddressState {
  const GetAllAddressState({
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
  List<Object?> get props => [addressEntities, addressStatus, pageKey, pageSize, searchItem];
}

class SelectAllAddressState extends AddressState {
  const SelectAllAddressState({this.addressEntities = const []});

  final List<AddressModel> addressEntities;

  @override
  List<Object?> get props => [addressEntities];
}

class SelectDefaultAddressState extends AddressState {
  const SelectDefaultAddressState({
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
  List<Object?> get props => [
        addressEntity,
        index,
        addressEntities,
        addressID,
      ];
}

class ConfirmationOnDefaultAddressState extends AddressState {
  const ConfirmationOnDefaultAddressState({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  List<Object?> get props => [addressEntity];
}

class SelectCurrentAddressState extends AddressState {
  const SelectCurrentAddressState({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  List<Object?> get props => [addressEntity];
}

class AddressLoadingState extends AddressState {
  const AddressLoadingState({
    required this.message,
    this.isLoading = true,
    this.addressStatus = AddressStatus.none,
  });

  final bool isLoading;
  final String message;
  final AddressStatus addressStatus;

  @override
  List<Object?> get props => [
        isLoading,
        message,
        addressStatus,
      ];
}

class AddressProcessingState extends AddressState {
  const AddressProcessingState({
    required this.message,
    this.isProcessing = true,
    this.addressStatus = AddressStatus.none,
  });

  final bool isProcessing;
  final String message;
  final AddressStatus addressStatus;

  @override
  List<Object?> get props => [
        isProcessing,
        message,
        addressStatus,
      ];
}

class AddressFailedState extends AddressState {
  const AddressFailedState({
    required this.message,
    this.addressStatus = AddressStatus.none,
  });

  final String message;
  final AddressStatus addressStatus;

  @override
  List<Object?> get props => [
        message,
        addressStatus,
      ];
}

class AddressExceptionState extends AddressState {
  const AddressExceptionState({
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
  List<Object?> get props => [message, stackTrace, exception, addressStatus];
}

class AddressEmptyState extends AddressState {
  const AddressEmptyState({
    this.addressEntities = const [],
    this.message = '',
    this.addressStatus = AddressStatus.none,
  });

  final List<AddressModel> addressEntities;
  final String message;
  final AddressStatus addressStatus;

  @override
  List<Object?> get props => [
        addressEntities,
        message,
        addressStatus,
      ];
}

// Get All Address state
class GetAllAddressPaginationState extends AddressState {
  const GetAllAddressPaginationState({
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
  List<Object?> get props => [
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
}

class GetAllLoadingAddressPaginationState extends AddressState {
  const GetAllLoadingAddressPaginationState({
    required this.isLoading,
    required this.message,
  });

  final bool isLoading;
  final String message;

  @override
  List<Object?> get props => [
        isLoading,
        message,
      ];
}

class GetAllProcessingAddressPaginationState extends AddressState {
  const GetAllProcessingAddressPaginationState({
    required this.isProcessing,
    required this.message,
  });

  final bool isProcessing;
  final String message;

  @override
  List<Object?> get props => [
        isProcessing,
        message,
      ];
}

class GetAllFailedAddressPaginationState extends AddressState {
  const GetAllFailedAddressPaginationState({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => [
        message,
      ];
}

class GetAllExceptionAddressPaginationState extends AddressState {
  const GetAllExceptionAddressPaginationState({
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
  List<Object?> get props => [
        message,
        stackTrace,
        exception,
        addressStatus,
      ];
}

class GetAllEmptyAddressPaginationState extends AddressState {
  const GetAllEmptyAddressPaginationState({
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
  List<Object?> get props => [
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
}
