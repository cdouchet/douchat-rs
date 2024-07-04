# api.api.LoginApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-api.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**refreshAccessToken**](LoginApi.md#refreshaccesstoken) | **GET** /token/refresh | 


# **refreshAccessToken**
> refreshAccessToken()



### Example
```dart
import 'package:api/api.dart';

final api = Api().getLoginApi();

try {
    api.refreshAccessToken();
} catch on DioException (e) {
    print('Exception when calling LoginApi->refreshAccessToken: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

