import 'package:api/api.dart';
import 'package:app/api/api.dart';
import 'package:app/components/shared/text_input.dart';
import 'package:app/modules/onboarding/steps/onboarding_notifications.dart';
import 'package:app/modules/onboarding/steps/onboarding_profile.dart';
import 'package:app/modules/onboarding/steps/onboarding_subtitle.dart';
import 'package:app/modules/onboarding/steps/onboarding_username.dart';
import 'package:app/utils/clair_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum OnboardingStep {
  username,
  notifications,
  profile,
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  static const String routeName = "onboarding";

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController usernameController = TextEditingController();
  bool usernameLoading = false;

  OnboardingStep _getStepFromIndex(int index) {
    switch (index) {
      case 0:
        return OnboardingStep.username;
      case 1:
        return OnboardingStep.notifications;
      case 2:
        return OnboardingStep.profile;
      default:
        return OnboardingStep.username;
    }
  }

  Future<void> _saveUsername() async {
    FocusScope.of(context).unfocus();
    var form = UsernameUpdateFormBuilder();
    final username = usernameController.text.trim();
    if (username.isEmpty) {
      showCustomSnackbar(context: context, text: "Votre nom d'utilisateur ne peut pas être vide");
      return;
    }
    form.username = username;
    try {
      setState(() => usernameLoading = true);
      final result = await api.getOnboardingApi().updateUsername(
        usernameUpdateForm: form.build(),
      );
      setState(() => usernameLoading = false);
      print("Update username result:");
      print(result.data);
    } catch (e) {
      showCustomSnackbar(context: context, text: "Une erreur est survenue");
    }
    _nextStep();
  }

  void _nextStep() {
    int goToPage;
    if (pageController.page == (OnboardingStep.values.length - 1)) {
      goToPage = 0;
    } else {
      goToPage = pageController.page!.toInt() + 1;
    }
    pageController
        .animateToPage(goToPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic)
        .then((_) => setState(() {}));
  }

  Future<void> onTapAddButton() async {
    final FilePicker picker = FilePicker.platform;
    final result = await picker.pickFiles(
      allowCompression: false,
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) {
      return;
    }
  }

  Widget _getContentFromStep(OnboardingStep step) {
    switch (step) {
      case OnboardingStep.username:
        return OnboardingUsername(
          usernameController: usernameController,
          isLoading: usernameLoading,
          onTap: () => _saveUsername(),
        );
      case OnboardingStep.notifications:
        return OnboardingNotifications(
            onTapActivate: () async {
              try {
                final status = await Permission.notification.status;
                print("Notifications status: ");
                if (status.isPermanentlyDenied) {
                  await openAppSettings();
                  return;
                }
                if (status.isGranted == false) {
                  print("Requesting notification permission");
                  final status = await Permission.notification.request();
                  if (status.isGranted) {
                    // TODO: Send FCM token to backend
                  }
                }
              } catch (e) {
                print(
                    "Something went wrong when requesting notifications permission:");
                print(e);
              }
              _nextStep();
            },
            onTapLater: () => _nextStep());
      case OnboardingStep.profile:
        return OnboardingProfile(onTapAddButton: onTapAddButton, onTap: () => _nextStep());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Bienvenue",
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 70),
                OnboardingSubtitle(
                  step: _getStepFromIndex(
                    !pageController.hasClients
                        ? 0
                        : pageController.page!.floor(),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: OnboardingStep.values.length,
                    itemBuilder: (context, index) {
                      final step = _getStepFromIndex(index);
                      return _getContentFromStep(step);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
