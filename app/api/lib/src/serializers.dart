//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:api/src/date_serializer.dart';
import 'package:api/src/model/date.dart';

import 'package:api/src/model/append_notification_token_form.dart';
import 'package:api/src/model/append_user_device_form.dart';
import 'package:api/src/model/apple_name.dart';
import 'package:api/src/model/apple_oauth_payload.dart';
import 'package:api/src/model/apple_user.dart';
import 'package:api/src/model/douchat_error.dart';
import 'package:api/src/model/google_o_auth_payload.dart';
import 'package:api/src/model/new_user.dart';
import 'package:api/src/model/path_id.dart';
import 'package:api/src/model/path_username.dart';
import 'package:api/src/model/user.dart';
import 'package:api/src/model/user_device.dart';
import 'package:api/src/model/username_update_form.dart';

part 'serializers.g.dart';

@SerializersFor([
  AppendNotificationTokenForm,
  AppendUserDeviceForm,
  AppleName,
  AppleOauthPayload,
  AppleUser,
  DouchatError,
  GoogleOAuthPayload,
  NewUser,
  PathId,
  PathUsername,
  User,
  UserDevice,
  UsernameUpdateForm,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(UserDevice)]),
        () => ListBuilder<UserDevice>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
