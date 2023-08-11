part of 'package:homemakers_merchant/app/features/profile/index.dart';

class ProfileRemoteDataSource implements ProfileDataSource {
  @override
  Future<ApiResultState<bool>> deleteAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllBusinessType({AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement deleteAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO: implement deleteAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessDocument(
      {required int appUserID, AppUserEntity? appUserEntity, BusinessDocumentUploadedEntity? businessDocumentUploadedEntity}) {
    // TODO: implement deleteBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessProfile(
      {required int businessProfileID, BusinessProfileEntity? businessProfileEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement deleteBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessType(
      {required int businessTypeID, BusinessTypeEntity? businessTypeEntity, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement deleteBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deletePaymentBank({required int paymentBankID, PaymentBankEntity? paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement deletePaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessDocumentUploadedEntity>> editBusinessDocument(
      {AppUserEntity? appUserEntity, required int appUserID, required BusinessDocumentUploadedEntity businessDocumentUploadedEntity}) {
    // TODO: implement editBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> editBusinessProfile(
      {required BusinessProfileEntity businessProfileEntity, required int businessProfileID, AppUserEntity? appUserEntity}) {
    // TODO: implement editBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType(
      {required BusinessTypeEntity businessTypeEntity,
      required int businessTypeID,
      AppUserEntity? appUserEntity,
      BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement editBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> editPaymentBank(
      {required PaymentBankEntity paymentBankEntity, required int paymentBankID, AppUserEntity? appUserEntity}) {
    // TODO: implement editPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<BusinessDocumentUploadedEntity>>> getAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<BusinessProfileEntity>>> getAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType(
      {AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement getAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<PaymentBankEntity>>> getAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO: implement getAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessDocumentUploadedEntity>> getBusinessDocument(
      {required int appUserID, AppUserEntity? appUserEntity, BusinessDocumentUploadedEntity? businessDocumentUploadedEntity}) {
    // TODO: implement getBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> getBusinessProfile(
      {required int businessProfileID, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement getBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType(
      {required int businessTypeID, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity, BusinessTypeEntity? businessTypeEntity}) {
    // TODO: implement getBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> getPaymentBank({required int paymentBankID, AppUserEntity? appUserEntity, PaymentBankEntity? paymentBankEntity}) {
    // TODO: implement getPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessDocumentUploadedEntity>> saveBusinessDocument(
      {AppUserEntity? appUserEntity, required BusinessDocumentUploadedEntity businessDocumentUploadedEntity}) {
    // TODO: implement saveBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> saveBusinessProfile({required BusinessProfileEntity businessProfileEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement saveBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType(
      {required BusinessTypeEntity businessTypeEntity, AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO: implement saveBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> savePaymentBank({required PaymentBankEntity paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO: implement savePaymentBank
    throw UnimplementedError();
  }
}
