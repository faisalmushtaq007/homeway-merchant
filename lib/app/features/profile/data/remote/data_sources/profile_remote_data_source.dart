part of 'package:homemakers_merchant/app/features/profile/index.dart';

class ProfileRemoteDataSource implements ProfileDataSource {
  final client = serviceLocator<INetworkManager<BaseResponseErrorModel>>();
  @override
  Future<ApiResultState<bool>> deleteAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement deleteAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement deleteAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllBusinessType({AppUserEntity? appUserEntity, BusinessProfileEntity? businessProfileEntity}) {
    // TODO(prasant): implement deleteAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement deleteAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  }) {
    // TODO(prasant): implement deleteBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessProfile({
    required int businessProfileID,
    BusinessProfileEntity? businessProfileEntity,
    AppUserEntity? appUserEntity,
  }) {
    // TODO(prasant): implement deleteBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deleteBusinessType({
    required int businessTypeID,
    BusinessTypeEntity? businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement deleteBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<bool>> deletePaymentBank({required int paymentBankID, PaymentBankEntity? paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement deletePaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NewBusinessDocumentEntity>> editBusinessDocument({
    required int documentID,
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
    int? appUserID,
  }) {
    // TODO(prasant): implement editBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> editBusinessProfile({
    required BusinessProfileEntity businessProfileEntity,
    required int businessProfileID,
    AppUserEntity? appUserEntity,
  }) {
    // TODO(prasant): implement editBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> editBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement editBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> editPaymentBank({
    required PaymentBankEntity paymentBankEntity,
    required int paymentBankID,
    AppUserEntity? appUserEntity,
  }) {
    // TODO(prasant): implement editPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<NewBusinessDocumentEntity>>> getAllBusinessDocument({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement getAllBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<BusinessProfileEntity>>> getAllBusinessProfile({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement getAllBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, List<BusinessTypeEntity>)>> getAllBusinessType({
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement getAllBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<List<PaymentBankEntity>>> getAllPaymentBank({AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement getAllPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NewBusinessDocumentEntity>> getBusinessDocument({
    required int documentID,
    int? appUserID,
    AppUserEntity? appUserEntity,
    NewBusinessDocumentEntity? businessDocumentUploadedEntity,
  }) {
    // TODO(prasant): implement getBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> getBusinessProfile({
    required int businessProfileID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement getBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> getBusinessType({
    required int businessTypeID,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
    BusinessTypeEntity? businessTypeEntity,
  }) {
    // TODO(prasant): implement getBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> getPaymentBank({required int paymentBankID, AppUserEntity? appUserEntity, PaymentBankEntity? paymentBankEntity}) {
    // TODO(prasant): implement getPaymentBank
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<NewBusinessDocumentEntity>> saveBusinessDocument({
    required NewBusinessDocumentEntity businessDocumentUploadedEntity,
    AppUserEntity? appUserEntity,
  }) {
    // TODO(prasant): implement saveBusinessDocument
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<BusinessProfileEntity>> saveBusinessProfile({required BusinessProfileEntity businessProfileEntity, AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement saveBusinessProfile
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<(BusinessProfileEntity, BusinessTypeEntity)>> saveBusinessType({
    required BusinessTypeEntity businessTypeEntity,
    AppUserEntity? appUserEntity,
    BusinessProfileEntity? businessProfileEntity,
  }) {
    // TODO(prasant): implement saveBusinessType
    throw UnimplementedError();
  }

  @override
  Future<ApiResultState<PaymentBankEntity>> savePaymentBank({required PaymentBankEntity paymentBankEntity, AppUserEntity? appUserEntity}) {
    // TODO(prasant): implement savePaymentBank
    throw UnimplementedError();
  }
}
