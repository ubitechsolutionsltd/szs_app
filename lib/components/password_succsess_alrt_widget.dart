import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'password_succsess_alrt_model.dart';
export 'password_succsess_alrt_model.dart';

/// Shown after a password change.
class PasswordSuccsessAlrtWidget extends StatelessWidget {
  const PasswordSuccsessAlrtWidget({
    super.key,
    required this.onTapLogin,
  });

  final Future Function()? onTapLogin;

  @override
  Widget build(BuildContext context) {
    return AppDialogCard(
      imageAsset: 'assets/images/password_changes_img.png',
      title: trs('9cdr0td1'),
      message: trs('m714g4la'),
      actions: [
        AppButton(
          label: trs('bh30kghu'),
          onPressed: () async {
            await onTapLogin?.call();
          },
        ),
      ],
    );
  }
}
