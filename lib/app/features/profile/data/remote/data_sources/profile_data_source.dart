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

  Future<ApiResultState<NewBusinessDocumentEntity>> saveBusinessDocument({
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<NewBusinessDocumentEntity>> editBusinessDocument({
    required int documentID,
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
    int? appUserID,
  });

  Future<ApiResultState<bool>> deleteBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  });

  Future<ApiResultState<bool>> deleteAllBusinessDocument({
    AppUserEntity? appUserEntity,
  });

  Future<ApiResultState<NewBusinessDocumentEntity>> getBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  });

  Future<ApiResultState<List<NewBusinessDocumentEntity>>> getAllBusinessDocument({
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
  // Save all and Get all with pagination
  Future<ApiResultState<List<PaymentBankEntity>>> saveAllPaymentBanks({
    required List<PaymentBankEntity> paymentBanks,
    bool hasUpdateAll = false,
  });

  Future<ApiResultState<List<PaymentBankEntity>>> getAllPaymentBanksPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });

  Future<ApiResultState<List<BusinessProfileEntity>>> saveAllBusinessProfiles({
    required List<BusinessProfileEntity> businessProfiles,
    bool hasUpdateAll = false,
  });

  Future<ApiResultState<List<BusinessProfileEntity>>> getAllBusinessProfilePagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
  Future<ApiResultState<List<NewBusinessDocumentEntity>>> saveAllBusinessDocuments({
    required List<NewBusinessDocumentEntity> newBusinessDocuments,
    bool hasUpdateAll = false,
  });

  Future<ApiResultState<List<NewBusinessDocumentEntity>>> getAllBusinessDocumentsPagination({
    int pageKey = 0,
    int pageSize = 10,
    String? searchText,
    Map<String, dynamic> extras = const <String, dynamic>{},
    String? filtering,
    String? sorting,
    Timestamp? startTime,
    Timestamp? endTime,
  });
}
