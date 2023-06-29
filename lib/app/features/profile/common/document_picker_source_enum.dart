import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum DocumentPickerSource {
  camera(
    pickerSourceID: 1,
    documentPickerName: 'Camera',
    icon: Icon(Icons.camera),
  ),
  gallery(
    pickerSourceID: 2,
    documentPickerName: 'Gallery',
    icon: Icon(Icons.image),
  ),
  folder(
    pickerSourceID: 3,
    documentPickerName: 'Folder',
    icon: Icon(Icons.perm_media),
  ),
  none(
    pickerSourceID: 4,
    icon: Icon(Icons.close),
    documentPickerName: 'None',
  ),
  ;

  const DocumentPickerSource(
      {required this.documentPickerName,
      required this.pickerSourceID,
      required this.icon});

  final int pickerSourceID;
  final String documentPickerName;
  final Icon icon;

  @override
  String toString() {
    return '$name:($pickerSourceID)';
  }
}

enum DocumentPickerSourceStatus {
  none,
  startPickup,
  pickedUp,
  notPickedUp,
  pickingUp,
  error,
  ;

  @override
  String toString() {
    return name;
  }
}
