import 'dart:async';

import 'package:app/components/login/login_button.dart';
import 'package:app/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:video_player/video_player.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String routeName = "login";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late VideoPlayerController controller =
      VideoPlayerController.asset("assets/videos/flip.mp4")
        ..initialize().then((value) => setState(() {}))
        ..setLooping(true)
        ..setVolume(0)
        ..play();
  late StreamSubscription<String> loginAppLinksSubscription;

  @override
  void initState() {
    super.initState();
    loginAppLinksSubscription = context.read<LoginProvider>().listenAppLinks(context);
  }

  @override
  void dispose() {
    loginAppLinksSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.value.size.width,
                    height: controller.value.size.height,
                    child: VideoPlayer(controller),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Clair.",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontSize: 42,
                                        letterSpacing: 4,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connexion",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 34, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: LoginButton(
                                loginButtonType: LoginButtonType.google,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: LoginButton(
                                loginButtonType: LoginButtonType.apple,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchUrlString(
                                    "https://www.pexels.com/video/woman-having-a-coversation-on-her-smartphone-4053228/");
                              },
                              child: const Text("@Katrin Bolovtsova"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
