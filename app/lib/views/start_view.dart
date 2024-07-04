import 'package:app/api/api.dart';
import 'package:app/helpers/device_info.dart';
import 'package:app/modules/home/home_wrapper.dart';
import 'package:app/modules/onboarding/onboarding.dart';
import 'package:app/providers/login_provider.dart';
import 'package:app/providers/user_provider.dart';
import 'package:app/router.dart';
import 'package:app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  static const String routeName = "start";

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  void initState() {
    super.initState();
    // Removes authentication cookies
    // cookieManager.cookieJar.deleteAll();
    api.getAccountsApi().me().then((res) {
      if (res.statusCode == 200) {
        context.read<UserProvider>().changeUser(res.data!);
        DeviceInfo.instance.getDeviceForm().then((form) {
          api.getDevicesApi().appendDevice(appendUserDeviceForm: form);
        }).catchError((err, st) {
          print("Error sending device info");
          print(err);
          print(st);
        });
        print("User: ");
        print(res.data);
        if (!res.data!.onboardingCompleted) {
          DouchatRouter.instance
              .push(context, routeName: OnboardingView.routeName);
          return;
        }
        DouchatRouter.instance.push(context, routeName: HomeWrapper.routeName);
      }
    }).catchError((err, st) {
      print("Error getting /me:");
      print(err);
      print(st);
      DouchatRouter.instance.push(context, routeName: LoginView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
    );
  }
}
