import 'package:app/components/shared/action_button.dart';
import 'package:app/utils/douchat_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingProfile extends StatelessWidget {
  final VoidCallback onTapAddButton;
  final VoidCallback onTap;
  const OnboardingProfile(
      {super.key, required this.onTapAddButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            GestureDetector(
                onTap: onTapAddButton,
                child: SvgPicture.asset(DouchatIcons.instance.addButton)),
            const SizedBox(height: 10),
            Text(
              "Ajoutez une photo",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        const Spacer(),
        ActionButton(
          text: "Suivant",
          onTap: onTap,
          isLoading: false,
        ),
      ],
    );
  }
}
