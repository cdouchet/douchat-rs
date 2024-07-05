import 'package:app/components/shared/action_button.dart';
import 'package:app/modules/onboarding/steps/onboarding_picture.dart';
import 'package:app/utils/douchat_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingProfile extends StatelessWidget {
  final VoidCallback onTapAddButton;
  final VoidCallback onTap;
  FilePickerResult? pickerResult;
  OnboardingProfile({
    super.key,
    required this.onTapAddButton,
    required this.onTap,
    required this.pickerResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            GestureDetector(
              onTap: onTapAddButton,
              child: SizedBox(
                height: 150,
                width: 150,
                child: pickerResult == null
                    ? SvgPicture.asset(DouchatIcons.instance.addButton)
                    : OnboardingPicture(result: pickerResult!),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              pickerResult == null ? "Ajoutez une photo" : "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ActionButton(
            text: "Suivant",
            onTap: onTap,
            isLoading: false,
          ),
        ),
      ],
    );
  }
}
