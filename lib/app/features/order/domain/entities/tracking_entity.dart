part of 'package:homemakers_merchant/app/features/order/index.dart';

class TrackingInfo {
  TrackingInfo({
    this.tracking,
    this.pickup,
    this.estimatedDeliverDateTime,
    this.delivery,
    this.driver,
  });

  TrackingInfo.fromJson(Map<String, dynamic> json)
      : tracking = (json['tracking'] as Map<String, dynamic>?) != null ? Tracking.fromJson(json['tracking'] as Map<String, dynamic>) : null,
        pickup = (json['pickup'] as Map<String, dynamic>?) != null ? PickupEntity.fromJson(json['pickup'] as Map<String, dynamic>) : null,
        estimatedDeliverDateTime = json['estimated_deliver_date_time'] as int?,
        delivery = (json['delivery'] as Map<String, dynamic>?) != null ? DeliveryEntity.fromJson(json['delivery'] as Map<String, dynamic>) : null,
        driver = (json['driver'] as Map<String, dynamic>?) != null ? DeliveryDriver.fromJson(json['driver'] as Map<String, dynamic>) : null;
  final Tracking? tracking;
  final PickupEntity? pickup;
  final int? estimatedDeliverDateTime;
  final DeliveryEntity? delivery;
  final DeliveryDriver? driver;

  Map<String, dynamic> toJson() => {
        'tracking': tracking?.toJson(),
        'pickup': pickup?.toJson(),
        'estimated_deliver_date_time': estimatedDeliverDateTime,
        'delivery': delivery?.toJson(),
        'driver': driver?.toJson(),
      };
}

class Tracking {
  Tracking({
    this.trackingId,
    this.trackingNumber,
    this.eventHistory,
    this.tackingTitle,
    this.status,
  });

  Tracking.fromJson(Map<String, dynamic> json)
      : trackingId = json['tracking_id'] as String?,
        trackingNumber = json['tracking_number'] as String?,
        eventHistory = (json['event_history'] as List?)?.map((dynamic e) => EventHistory.fromJson(e as Map<String, dynamic>)).toList(),
        tackingTitle = json['tacking_title'] as String?,
        status = json['status'] as String?;
  final String? trackingId;
  final String? trackingNumber;
  final List<EventHistory>? eventHistory;
  final String? tackingTitle;
  final String? status;

  Map<String, dynamic> toJson() => {
        'tracking_id': trackingId,
        'tracking_number': trackingNumber,
        'event_history': eventHistory?.map((e) => e.toJson()).toList(),
        'tacking_title': tackingTitle,
        'status': status,
      };
}

class EventHistory {
  EventHistory({
    this.eventCode,
    this.eventTime,
    this.status,
    this.eventMessage,
    this.eventLocation,
    this.eventSummary,
  });

  EventHistory.fromJson(Map<String, dynamic> json)
      : eventCode = json['event_code'] as String?,
        eventTime = json['event_time'] as int?,
        status = json['status'] as int?,
        eventMessage = json['event_message'] as String?,
        eventLocation = (json['event_location'] as Map<String, dynamic>?) != null ? AddressBean.fromJson(json['event_location'] as Map<String, dynamic>) : null,
        eventSummary = json['event_summary'] as String?;
  final String? eventCode;
  final int? eventTime;
  final int? status;
  final String? eventMessage;
  final AddressBean? eventLocation;
  final String? eventSummary;

  Map<String, dynamic> toJson() => {
        'event_code': eventCode,
        'event_time': eventTime,
        'status': status,
        'event_message': eventMessage,
        'event_location': eventLocation?.toJson(),
        'event_summary': eventSummary,
      };
}

class EventLocation {
  EventLocation({
    this.flatnumber,
    this.floor,
    this.landmark,
    this.area,
    this.street,
    this.city,
    this.district,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  EventLocation.fromJson(Map<String, dynamic> json)
      : flatnumber = json['flatnumber'] as int?,
        floor = json['floor'] as int?,
        landmark = json['landmark'] as String?,
        area = json['area'] as String?,
        street = json['street'] as String?,
        city = json['city'] as String?,
        district = json['district'] as String?,
        state = json['state'] as String?,
        country = json['country'] as String?,
        latitude = json['latitude'] as double?,
        longitude = json['longitude'] as double?;
  final int? flatnumber;
  final int? floor;
  final String? landmark;
  final String? area;
  final String? street;
  final String? city;
  final String? district;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() => {
        'flatnumber': flatnumber,
        'floor': floor,
        'landmark': landmark,
        'area': area,
        'street': street,
        'city': city,
        'district': district,
        'state': state,
        'country': country,
        'latitude': latitude,
        'longitude': longitude,
      };
}

class PickupEntity {
  PickupEntity({
    this.pickupID,
    this.pickupUserFullname,
    this.pickupUserMobileNumber,
    this.pickupUserAddress,
    this.pickupOrderId,
  });

  PickupEntity.fromJson(Map<String, dynamic> json)
      : pickupID = json['pickupID'] as String?,
        pickupUserFullname = json['pickup_user_fullname'] as String?,
        pickupUserMobileNumber = json['pickup_user_mobile_number'] as String?,
        pickupUserAddress =
            (json['pickup_user_address'] as Map<String, dynamic>?) != null ? AddressBean.fromJson(json['pickup_user_address'] as Map<String, dynamic>) : null,
        pickupOrderId = json['pickup_order_id'] as int?;
  final String? pickupID;
  final String? pickupUserFullname;
  final String? pickupUserMobileNumber;
  final AddressBean? pickupUserAddress;
  final int? pickupOrderId;

  Map<String, dynamic> toJson() => {
        'pickupID': pickupID,
        'pickup_user_fullname': pickupUserFullname,
        'pickup_user_mobile_number': pickupUserMobileNumber,
        'pickup_user_address': pickupUserAddress?.toJson(),
        'pickup_order_id': pickupOrderId,
      };
}

class DeliveryEntity {
  DeliveryEntity({
    this.deliveryID,
    this.deliveryUserFullname,
    this.deliveryUserMobileNumber,
    this.deliveryUserAddress,
    this.deliveryOrderId,
  });

  DeliveryEntity.fromJson(Map<String, dynamic> json)
      : deliveryID = json['deliveryID'] as String?,
        deliveryUserFullname = json['delivery_user_fullname'] as String?,
        deliveryUserMobileNumber = json['delivery_user_mobile_number'] as String?,
        deliveryUserAddress = (json['delivery_user_address'] as Map<String, dynamic>?) != null
            ? AddressBean.fromJson(json['delivery_user_address'] as Map<String, dynamic>)
            : null,
        deliveryOrderId = json['delivery_order_id'] as int?;
  final String? deliveryID;
  final String? deliveryUserFullname;
  final String? deliveryUserMobileNumber;
  final AddressBean? deliveryUserAddress;
  final int? deliveryOrderId;

  Map<String, dynamic> toJson() => {
        'deliveryID': deliveryID,
        'delivery_user_fullname': deliveryUserFullname,
        'delivery_user_mobile_number': deliveryUserMobileNumber,
        'delivery_user_address': deliveryUserAddress?.toJson(),
        'delivery_order_id': deliveryOrderId,
      };
}

class DeliveryDriver {
  DeliveryDriver({
    this.driverID,
    this.driverName,
    this.driverContactNumber,
    this.driverAddress,
    this.driverImage,
  });

  DeliveryDriver.fromJson(Map<String, dynamic> json)
      : driverID = json['driverID'] as int?,
        driverName = json['driverName'] as String?,
        driverContactNumber = json['driver_contact_number'] as String?,
        driverAddress = (json['driver_address'] as Map<String, dynamic>?) != null ? AddressBean.fromJson(json['driver_address'] as Map<String, dynamic>) : null,
        driverImage = json['driver_image'] as String?;
  final int? driverID;
  final String? driverName;
  final String? driverContactNumber;
  final AddressBean? driverAddress;
  final String? driverImage;

  Map<String, dynamic> toJson() => {
        'driverID': driverID,
        'driverName': driverName,
        'driver_contact_number': driverContactNumber,
        'driver_address': driverAddress?.toJson(),
        'driver_image': driverImage,
      };
}
