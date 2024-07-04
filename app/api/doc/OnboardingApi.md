# api.api.OnboardingApi

## Load the API package
```dart
import 'package:api/api.dart';
```

All URIs are relative to *https://douchat-api.doggo-saloon.net*

Method | HTTP request | Description
------------- | ------------- | -------------
[**updateUsername**](OnboardingApi.md#updateusername) | **PATCH** /username | Update Username


# **updateUsername**
> String updateUsername(usernameUpdateForm)

Update Username

Update Username

### Example
```dart
import 'package:api/api.dart';

final api = Api().getOnboardingApi();
final UsernameUpdateForm usernameUpdateForm = ; // UsernameUpdateForm | 

try {
    final response = api.updateUsername(usernameUpdateForm);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OnboardingApi->updateUsername: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **usernameUpdateForm** | [**UsernameUpdateForm**](UsernameUpdateForm.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

