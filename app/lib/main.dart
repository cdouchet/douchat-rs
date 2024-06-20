import 'dart:io';

import 'package:app/providers/user_provider.dart';
import 'package:app/router.dart';
import 'package:app/themes/light.dart';
import 'package:app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

late Directory applicationDocumentsDirectory;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  applicationDocumentsDirectory = await getApplicationDocumentsDirectory();
  await dotenv.load();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const Douchat());
}

class Douchat extends StatelessWidget {
  const Douchat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        theme: lightThemeData,
        routes: DouchatRouter.instance.buildRoutes(),
        initialRoute: LoginView.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
