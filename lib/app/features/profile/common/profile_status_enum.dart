enum CurrentProfileStatus {
  phoneNumberVerified(
    statusID: 1,
    statusValue: 'PhoneNumber verified',
  ),
  basicProfileSaved(
    statusID: 2,
    statusValue: 'Basic profile saved',
  ),
  businessTypeSaved(
    statusID: 3,
    statusValue: 'Business type saved',
  ),
  paymentDetailSaved(
    statusID: 4,
    statusValue: 'Payment details saved',
  ),
  businessDocumentUploaded(
    statusID: 5,
    statusValue: 'Business document uploaded',
  ),
  oneStoreCreated(
    statusID: 6,
    statusValue: 'At least one store created',
  ),
  oneMenuCreated(
    statusID: 7,
    statusValue: 'At least one menu created',
  ),
  oneMenuMapWithOneStore(
    statusID: 8,
    statusValue: 'At least one menu mapped with one store',
  ),
  profileCompleted(
    statusID: 9,
    statusValue: 'user profile completed',
  ),
  none(
    statusID: 10,
    statusValue: 'none',
  );

  const CurrentProfileStatus({required this.statusValue, required this.statusID});

  final int statusID;
  final String statusValue;

  @override
  String toString() {
    return '$name:($statusID)';
  }
}
