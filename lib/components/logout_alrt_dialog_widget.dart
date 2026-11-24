import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'logout_alrt_dialog_model.dart';
export 'logout_alrt_dialog_model.dart';

/// "Log out?" confirmation.
class LogoutAlrtDialogWidget extends StatelessWidget {
  const LogoutAlrtDialogWidget({
    super.key,
    required this.onTapLogout,
  });

  final Future Function()? onTapLogout;

  @override
  Widget build(BuildContext context) {
    return AppDialogCard(
      icon: Icons.logout_rounded,
      danger: true,
      title: trs('rxu0qsy2'),
      message: trs('dcr851fh'),
      actions: [
        AppButton(
          label: trs('j6diwfc7'),
          onPressed: () async {
            await onTapLogout?.call();
          },
        ),
        AppButton(
          label: trs('xuntpavf'),
          kind: AppButtonKind.secondary,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
