import 'package:app/modules/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension OnboardingStepSubtitle on OnboardingStep {
  String subtitle() {
    switch (this) {
      case OnboardingStep.username:
        return "Qui êtes-vous ?";
      case OnboardingStep.notifications:
        return "Notifications";
      case OnboardingStep.profile:
        return "Profil";
    }
  }
}

class OnboardingSubtitle extends StatelessWidget {
  final OnboardingStep step;
  const OnboardingSubtitle({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          step.subtitle(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
