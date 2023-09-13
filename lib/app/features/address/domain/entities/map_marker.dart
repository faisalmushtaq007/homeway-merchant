part of 'package:homemakers_merchant/app/features/address/index.dart';
class MapMarker {

  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
    required this.rating,
  });

  factory MapMarker.fromMap(Map<String, dynamic> map) {
    return MapMarker(
      image: map['image'] as String,
      title: map['title'] as String,
      address: map['address'] as String,
      location: map['location'] as latlng2.LatLng,
      rating: map['rating'] as int,
    );
  }
  final String? image;
  final String? title;
  final String? address;
  final latlng2.LatLng? location;
  final int? rating;

  MapMarker copyWith({
    String? image,
    String? title,
    String? address,
    latlng2.LatLng? location,
    int? rating,
  }) {
    return MapMarker(
      image: image ?? this.image,
      title: title ?? this.title,
      address: address ?? this.address,
      location: location ?? this.location,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.image,
      'title': this.title,
      'address': this.address,
      'location': this.location,
      'rating': this.rating,
    };
  }
}