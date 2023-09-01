import 'package:flutter/material.dart';
import 'package:homemakers_merchant/app/features/address/index.dart';
import 'package:homemakers_merchant/app/features/menu/index.dart';
import 'package:homemakers_merchant/app/features/notification/index.dart';
import 'package:homemakers_merchant/app/features/order/index.dart';
import 'package:homemakers_merchant/app/features/profile/index.dart';
import 'package:homemakers_merchant/app/features/rate_review/index.dart';
import 'package:homemakers_merchant/app/features/store/index.dart';
import 'package:homemakers_merchant/base/base_usecase.dart';
import 'package:homemakers_merchant/base/widget_view.dart';
import 'package:homemakers_merchant/bootup/injection_container.dart';
import 'package:homemakers_merchant/config/translation/extension/text_extension.dart';
import 'package:homemakers_merchant/config/translation/language_controller.dart';
import 'package:homemakers_merchant/core/extensions/app_extension.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:homemakers_merchant/core/local/database/base/repository_failure.dart';
import 'package:homemakers_merchant/shared/states/data_source_state.dart';
import 'package:homemakers_merchant/shared/widgets/universal/async_builder/async_builder.dart';
import 'package:homemakers_merchant/utils/app_log.dart';
import 'package:homemakers_merchant/utils/functional/functional.dart';
import 'package:sembast/timestamp.dart';

part 'package:homemakers_merchant/app/features/common/presentation/pages/all_store_dialog_widget.dart';
part 'package:homemakers_merchant/app/features/common/domain/repositories/common_repository.dart';

//Usecases
part 'package:homemakers_merchant/app/features/common/domain/use_cases/delete_all_from_localdb_usecase.dart';
part 'package:homemakers_merchant/app/features/common/domain/use_cases/get_current_user_profile_usecase.dart';
part 'package:homemakers_merchant/app/features/common/domain/use_cases/get_current_user_token_usecase.dart';

// Repository
part 'package:homemakers_merchant/app/features/common/data/repositories/common_repository_implement.dart';
