# api.api.OAuthApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-api.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appleAuth**](OAuthApi.md#appleauth) | **POST** /login/apple | 
[**googleAuth**](OAuthApi.md#googleauth) | **GET** /login/google | 


# **appleAuth**
> User appleAuth(appleOauthPayload)



### Example
```dart
import 'package:api/api.dart';

final api = Api().getOAuthApi();
final AppleOauthPayload appleOauthPayload = ; // AppleOauthPayload | 

try {
    final response = api.appleAuth(appleOauthPayload);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OAuthApi->appleAuth: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **appleOauthPayload** | [**AppleOauthPayload**](AppleOauthPayload.md)|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **googleAuth**
> User googleAuth(code, scope, authuser, state, deviceId)



### Example
```dart
import 'package:api/api.dart';

final api = Api().getOAuthApi();
final String code = code_example; // String | 
final String scope = scope_example; // String | 
final String authuser = authuser_example; // String | 
final String state = state_example; // String | 
final String deviceId = deviceId_example; // String | 

try {
    final response = api.googleAuth(code, scope, authuser, state, deviceId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OAuthApi->googleAuth: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 
 **scope** | **String**|  | 
 **authuser** | **String**|  | 
 **state** | **String**|  | 
 **deviceId** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

