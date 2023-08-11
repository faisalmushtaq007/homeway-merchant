import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:homemakers_merchant/app/features/profile/common/profile_status_enum.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/utils/app_equatable/app_equatable.dart';

part 'business_profile_event.dart';
part 'business_profile_state.dart';

class BusinessProfileBloc extends Bloc<BusinessProfileEvent, BusinessProfileState> {
  BusinessProfileBloc() : super(BusinessProfileInitial()) {
    on<SaveBusinessProfile>(_saveBusinessProfile);
    on<SaveBusinessType>(_saveBusinessType);
    on<GetBusinessType>(_getBusinessType);
    on<GetBusinessProfile>(_getBusinessProfile);
    on<DeleteBusinessProfile>(_deleteBusinessProfile);
    on<NavigateToAddressPage>(_navigateToAddressPage);
  }

  FutureOr<void> _saveBusinessProfile(SaveBusinessProfile event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _saveBusinessType(SaveBusinessType event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _getBusinessType(GetBusinessType event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _getBusinessProfile(GetBusinessProfile event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _deleteBusinessProfile(DeleteBusinessProfile event, Emitter<BusinessProfileState> emit) async {}

  FutureOr<void> _navigateToAddressPage(NavigateToAddressPage event, Emitter<BusinessProfileState> emit) async {}
}
