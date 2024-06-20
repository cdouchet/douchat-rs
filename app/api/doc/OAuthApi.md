# api.api.OAuthApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-test.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**appleAuth**](OAuthApi.md#appleauth) | **POST** /login/apple | 


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

