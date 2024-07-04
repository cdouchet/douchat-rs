# api.api.DevicesApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-api.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appendDevice**](DevicesApi.md#appenddevice) | **PUT** /user/devices | Append Device
[**appendNotificationToken**](DevicesApi.md#appendnotificationtoken) | **PUT** /user/devices/token | Send Notification Token
[**getUserDevices**](DevicesApi.md#getuserdevices) | **GET** /user/devices | Get Devices


# **appendDevice**
> UserDevice appendDevice(appendUserDeviceForm)

Append Device

Append Device

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDevicesApi();
final AppendUserDeviceForm appendUserDeviceForm = ; // AppendUserDeviceForm | 

try {
    final response = api.appendDevice(appendUserDeviceForm);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DevicesApi->appendDevice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appendUserDeviceForm** | [**AppendUserDeviceForm**](AppendUserDeviceForm.md)|  | 

### Return type

[**UserDevice**](UserDevice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **appendNotificationToken**
> String appendNotificationToken(appendNotificationTokenForm)

Send Notification Token

Send Notification Token

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDevicesApi();
final AppendNotificationTokenForm appendNotificationTokenForm = ; // AppendNotificationTokenForm | 

try {
    final response = api.appendNotificationToken(appendNotificationTokenForm);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DevicesApi->appendNotificationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appendNotificationTokenForm** | [**AppendNotificationTokenForm**](AppendNotificationTokenForm.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserDevices**
> BuiltList<UserDevice> getUserDevices()

Get Devices

Get Devices

### Example
```dart
import 'package:api/api.dart';

final api = Api().getDevicesApi();

try {
    final response = api.getUserDevices();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DevicesApi->getUserDevices: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;UserDevice&gt;**](UserDevice.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

