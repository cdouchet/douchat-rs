# api.api.AccountsApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-api.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**completeOnboarding**](AccountsApi.md#completeonboarding) | **PATCH** /onboarding/complete | Complete Onboarding
[**getUserByUid**](AccountsApi.md#getuserbyuid) | **GET** /accounts/id/{id} | 
[**getUserByUsername**](AccountsApi.md#getuserbyusername) | **GET** /accounts/username/{username} | 
[**me**](AccountsApi.md#me) | **GET** /me | 


# **completeOnboarding**
> String completeOnboarding()

Complete Onboarding

Complete Onboarding

### Example
```dart
import 'package:api/api.dart';

final api = Api().getAccountsApi();

try {
    final response = api.completeOnboarding();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->completeOnboarding: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserByUid**
> User getUserByUid(id)



### Example
```dart
import 'package:api/api.dart';

final api = Api().getAccountsApi();
final String id = id_example; // String | 

try {
    final response = api.getUserByUid(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->getUserByUid: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserByUsername**
> User getUserByUsername(username)



### Example
```dart
import 'package:api/api.dart';

final api = Api().getAccountsApi();
final String username = username_example; // String | 

try {
    final response = api.getUserByUsername(username);
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->getUserByUsername: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**|  | 

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **me**
> User me()



### Example
```dart
import 'package:api/api.dart';

final api = Api().getAccountsApi();

try {
    final response = api.me();
    print(response);
} catch on DioException (e) {
    print('Exception when calling AccountsApi->me: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

