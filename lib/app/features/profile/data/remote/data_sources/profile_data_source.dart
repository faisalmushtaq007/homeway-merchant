part of 'package:homemakers_merchant/app/features/profile/index.dart';

abstract interface class ProfileDataSource {
  Future<ApiResultState<BusinessProfileEntity>> saveBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<BusinessProfileEntity>> editBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    required int businessProfileID,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteBusinessProfile({
    required int businessProfileID,
    BusinessProfileEntity? businessProfileEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteAllBusinessProfile({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<BusinessProfileEntity>> getBusinessProfile({
    required int businessProfileID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<List<BusinessProfileEntity>>> getAllBusinessProfile({
    AppUserEntity? appUserEntity,
  });

  // BusinessType
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<bool>> deleteBusinessType({
    required int businessTypeID,
    BusinessTypeEntity? businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<bool>> deleteAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType({
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
    BusinessTypeEntity? businessTypeEntity,
  });

  Future<ApiResultState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  });

  Future<ApiResultState<BusinessDocumentUploadedEntity>> saveBusinessDocument({
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<BusinessDocumentUploadedEntity>> editBusinessDocument({
    required int documentID,
    required BusinessDocumentUploadedEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
    int? appUserID,
  });

  Future<ApiResultState<bool>> deleteBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  });

  Future<ApiResultState<bool>> deleteAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<BusinessDocumentUploadedEntity>> getBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    BusinessDocumentUploadedEntity? businessDocumentUploadedEntity,
  });

  Future<ApiResultState<List<BusinessDocumentUploadedEntity>>> getAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<PaymentBankEntity>> savePaymentBank({
    required PaymentBankEntity paymentBankEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<PaymentBankEntity>> editPaymentBank({
    required PaymentBankEntity paymentBankEntity,
    required int paymentBankID,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deletePaymentBank({
    required int paymentBankID,
    PaymentBankEntity? paymentBankEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<bool>> deleteAllPaymentBank({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<PaymentBankEntity>> getPaymentBank({
    required int paymentBankID,
    AppUserEntity? appUserEntity,
    PaymentBankEntity? paymentBankEntity,
  });

  Future<ApiResultState<List<PaymentBankEntity>>> getAllPaymentBank({
    AppUserEntity? appUserEntity,
  });
}
