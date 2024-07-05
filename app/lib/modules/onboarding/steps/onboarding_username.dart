import 'package:app/components/shared/action_button.dart';
import 'package:app/components/shared/text_input.dart';
import 'package:flutter/cupertino.dart';

class OnboardingUsername extends StatefulWidget {
  final TextEditingController usernameController;
  final VoidCallback onTap;
  bool isLoading;
  OnboardingUsername({
    super.key,
    required this.usernameController,
    required this.onTap,
    required this.isLoading,
  });

  @override
  State<OnboardingUsername> createState() => _OnboardingUsernameState();
}

class _OnboardingUsernameState extends State<OnboardingUsername> {
  bool isDisabled = true;

  void usernameListener() {
    setState(() {
      if (widget.usernameController.text.isEmpty) {
        isDisabled = true;
        return;
      }
      isDisabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.usernameController.addListener(usernameListener);
  }

  @override
  void dispose() {
    widget.usernameController.removeListener(usernameListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: DouchatTextInput(
            controller: widget.usernameController,
            hintText: "Pierre Dupont",
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ActionButton(
            text: "Suivant",
            onTap: widget.onTap,
            isDisabled: isDisabled,
            isLoading: widget.isLoading,
          ),
        ),
      ],
    );
  }
}
