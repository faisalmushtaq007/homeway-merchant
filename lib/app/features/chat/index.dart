import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/chat_ui/chat_ui.dart';
import 'package:homemakers_merchant/app/features/chat/presentation/pages/login.dart';
import 'package:homemakers_merchant/app/features/onboarding/presentation/pages/splash_page.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/dart_extensions.dart';
import 'package:homemakers_merchant/core/extensions/global_extensions/src/object.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:homemakers_merchant/app/features/chat/domain/entities/chat_types_entity.dart' as types;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:path/path.dart' as path;

part 'package:homemakers_merchant/app/features/chat/data/remote/data_sources/firebase_chat_core.dart';
part 'package:homemakers_merchant/app/features/chat/data/remote/data_sources/firebase_chat_core_config.dart';
part 'package:homemakers_merchant/app/features/chat/data/remote/data_sources/util.dart';
part 'package:homemakers_merchant/app/features/chat/presentation/pages/chat.dart';
part 'package:homemakers_merchant/app/features/chat/presentation/pages/register.dart';
part 'package:homemakers_merchant/app/features/chat/presentation/pages/rooms.dart';
part 'package:homemakers_merchant/app/features/chat/presentation/pages/users.dart';
part 'package:homemakers_merchant/app/features/chat/presentation/pages/util.dart';
