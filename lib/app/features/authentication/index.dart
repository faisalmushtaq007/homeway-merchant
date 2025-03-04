import 'package:firebase_auth/firebase_auth.dart';
import 'package:homemakers_merchant/app/features/authentication/common/constants.dart';
import 'package:homemakers_merchant/app/features/authentication/data/models/status/authentication_status_model.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/base/app_base.dart';
import 'package:homemakers_merchant/base/base_usecase.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/core/local/database/base/identifiable.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/core/network/http/base_api_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_request_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_error_model.dart';
import 'package:homemakers_merchant/core/network/http/base_response_model.dart';
import 'package:homemakers_merchant/core/network/http/failure/get_api_exception.dart';
import 'package:homemakers_merchant/core/service/connectivity_bloc/src/connectivity_bloc/connectivity_service.dart';
import 'package:homemakers_merchant/core/service/restApiClient/IRestApiManager.dart';
import 'package:homemakers_merchant/shared/states/api_result_state.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/shared/states/result_state.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';
import 'package:homeway_firebase/homeway_firebase.dart';
import 'package:network_manager/network_manager.dart';
import 'package:sembast/timestamp.dart';
import 'package:firebase_core/firebase_core.dart';

import 'presentation/manager/otp_verification/otp_verification_bloc.dart';
import 'presentation/manager/phone_number_verification_bloc.dart';

// Data
part 'package:homemakers_merchant/app/features/authentication/data/data_sources/authentication_data_source.dart';

part 'package:homemakers_merchant/app/features/authentication/data/data_sources/authentication_remote_data_source.dart';

// Entities
part 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_response_model.dart';

part 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_response_model.dart';

part 'package:homemakers_merchant/app/features/authentication/data/repositories/authentication_repository_impl.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/send_otp_entity.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/entities/phone_number_verification/verify_otp_entity.dart';

// Firebase
part 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/send_otp_firebase_response_model.dart';

part 'package:homemakers_merchant/app/features/authentication/data/models/phone_number_verification/verify_otp_firebase_response_model.dart';

// Repository
part 'package:homemakers_merchant/app/features/authentication/domain/repositories/authentication_repository.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/delete_all_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/delete_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/edit_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_all_appuser_pagination_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_all_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_current_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_userstatus_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_id_and_token_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_or_save_new_current_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/save_all_app_user_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/save_appuser_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/get_refreshtoken_usecase.dart';

// UseCases
part 'package:homemakers_merchant/app/features/authentication/domain/usecases/send_otp_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/verify_otp_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/send_firebase_otp_usecase.dart';

part 'package:homemakers_merchant/app/features/authentication/domain/usecases/verify_firebase_otp_usecase.dart';

// Injector
part 'package:homemakers_merchant/app/features/authentication/injector/authentication_injector.dart';
