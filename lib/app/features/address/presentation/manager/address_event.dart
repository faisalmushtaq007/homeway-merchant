part of 'address_bloc.dart';

abstract class AddressEvent with AppEquatable {}

class SaveAddress extends AddressEvent {
  SaveAddress({required this.addressEntity, required this.hasNewAddress, this.currentIndex = -1});

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

class RemoveAddressByID extends AddressEvent {
  RemoveAddressByID({
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
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity, index, addressEntities, addressID, hasRemove];
}

class RemoveAllAddress extends AddressEvent {
  RemoveAllAddress({
    this.addressEntities = const [],
    this.hasRemoveAll = true,
  });

  final List<AddressModel> addressEntities;
  final bool hasRemoveAll;

  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntities, hasRemoveAll];
}

class GetAddressByID extends AddressEvent {
  GetAddressByID({
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

class GetAllAddress extends AddressEvent {
  GetAllAddress({
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

class SelectAllAddress extends AddressEvent {
  SelectAllAddress({
    this.addressEntities = const [],
    this.selectedAddressEntities = const [],
  });
  final List<AddressModel> addressEntities;
  final List<AddressModel> selectedAddressEntities;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntities, selectedAddressEntities];
}

class SelectDefaultAddress extends AddressEvent {
  SelectDefaultAddress({
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

class ConfirmationOnDefaultAddress extends AddressEvent {
  ConfirmationOnDefaultAddress({
    this.addressEntity,
  });
  final AddressModel? addressEntity;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity];
}

class SelectCurrentAddress extends AddressEvent {
  SelectCurrentAddress({
    this.addressEntity,
  });
  final AddressModel? addressEntity;
  @override
  bool get cacheHash => true;

  @override
  List<Object?> get hashParameters => [addressEntity];
}
