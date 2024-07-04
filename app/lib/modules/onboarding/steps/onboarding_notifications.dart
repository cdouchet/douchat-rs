import 'package:app/components/shared/action_button.dart';
import 'package:app/utils/douchat_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingNotifications extends StatefulWidget {
  final VoidCallback onTapActivate;
  final VoidCallback onTapLater;
  const OnboardingNotifications({
    super.key,
    required this.onTapActivate,
    required this.onTapLater,
  });

  @override
  State<OnboardingNotifications> createState() =>
      _OnboardingNotificationsState();
}

class _OnboardingNotificationsState extends State<OnboardingNotifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            SvgPicture.asset(DouchatIcons.instance.chatBubble),
            const SizedBox(height: 10),
            Text(
              "Activez les notifications pour être informé(e) de tous vos nouveaux messages",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            ActionButton(text: "Activer", onTap: widget.onTapActivate, isLoading: false,),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: widget.onTapLater,
              child: Text("Plus tard", style: Theme.of(context).textTheme.displayMedium),
            ),
          ],
        )
      ],
    );
  }
}
