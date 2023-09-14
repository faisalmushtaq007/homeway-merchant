part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class SaveAddress extends AddressEvent {
  const SaveAddress({required this.addressEntity, required this.hasNewAddress, this.currentIndex = -1});

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

class RemoveAddressByID extends AddressEvent {
  const RemoveAddressByID({
    this.addressEntity,
    this.index = -1,
    this.addressID = -1,
    this.addressEntities = const [],
    this.hasRemove = true,
  });

  final AddressModel? addressEntity;
  final int index;
  final List<AddressModel> addressEntities;
  final int addressID;
  final bool hasRemove;

  @override
  List<Object?> get props => [addressEntity, index, addressEntities, addressID, hasRemove];
}

class RemoveAllAddress extends AddressEvent {
  const RemoveAllAddress({
    this.addressEntities = const [],
    this.hasRemoveAll = true,
  });

  final List<AddressModel> addressEntities;
  final bool hasRemoveAll;

  @override
  List<Object?> get props => [addressEntities, hasRemoveAll];
}

class GetAddressByID extends AddressEvent {
  const GetAddressByID({
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

class GetAllAddress extends AddressEvent {
  const GetAllAddress({
    this.searchItem = '',
    this.pageSize = 10,
    this.pageKey = 0,
  });

  final int pageKey;
  final int pageSize;
  final String searchItem;

  @override
  List<Object?> get props => [pageKey, pageSize, searchItem];
}

class SelectAllAddress extends AddressEvent {
  const SelectAllAddress({
    this.addressEntities = const [],
    this.selectedAddressEntities = const [],
  });

  final List<AddressModel> addressEntities;
  final List<AddressModel> selectedAddressEntities;

  @override
  List<Object?> get props => [addressEntities, selectedAddressEntities];
}

class SelectDefaultAddress extends AddressEvent {
  const SelectDefaultAddress({
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

class ConfirmationOnDefaultAddress extends AddressEvent {
  const ConfirmationOnDefaultAddress({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  List<Object?> get props => [addressEntity];
}

class SelectCurrentAddress extends AddressEvent {
  const SelectCurrentAddress({
    this.addressEntity,
  });

  final AddressModel? addressEntity;

  @override
  List<Object?> get props => [addressEntity];
}

class GetAllAddressPaginationEvent extends AddressEvent {
  const GetAllAddressPaginationEvent({
    this.pageKey = 1,
    this.searchText,
    this.pageSize = 10,
    this.endTimeStamp,
    this.filter,
    this.sorting,
    this.startTimeStamp,
  });

  final int pageKey;
  final int pageSize;
  final String? searchText;
  final String? filter;
  final String? sorting;
  final Timestamp? startTimeStamp;
  final Timestamp? endTimeStamp;

  @override
  List<Object?> get props => [
        pageKey,
        searchText,
        pageSize,
        endTimeStamp,
        filter,
        sorting,
        startTimeStamp,
      ];
}
