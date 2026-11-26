import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'password_success_alrt_dialog_model.dart';
export 'password_success_alrt_dialog_model.dart';

/// Shown after a password reset.
class PasswordSuccessAlrtDialogWidget extends StatelessWidget {
  const PasswordSuccessAlrtDialogWidget({
    super.key,
    required this.onTapLogin,
  });

  final Future Function()? onTapLogin;

  @override
  Widget build(BuildContext context) {
    return AppDialogCard(
      imageAsset: 'assets/images/password_changes_img.png',
      title: trs('enh71z8b'),
      message: trs('r0h1adas'),
      actions: [
        AppButton(
          label: trs('5pfvtb4m'),
          onPressed: () async {
            await onTapLogin?.call();
          },
        ),
      ],
    );
  }
}
