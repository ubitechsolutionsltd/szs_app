import '/custom_code/ui/app_components.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'custom_center_app_bar_model.dart';
export 'custom_center_app_bar_model.dart';

/// Page header used across the app: blue gradient with waves, white title, optional back arrow and
/// optional "more" button.
///
/// Note the original FlutterFlow flag: `backIcon: false` is what SHOWS the back arrow.
class CustomCenterAppBarWidget extends StatelessWidget {
  const CustomCenterAppBarWidget({
    super.key,
    this.title,
    required this.backIcon,
    required this.addIcon,
    required this.onTapAdd,
  });

  final String? title;
  final bool? backIcon;
  final bool? addIcon;
  final Future Function()? onTapAdd;

  @override
  Widget build(BuildContext context) {
    return GradientHeader(
      title: title ?? trs('no_name'),
      onBack: backIcon == false ? () => context.safePop() : null,
      trailing: addIcon == true
          ? Material(
              color: Colors.white.withValues(alpha: 0.2),
              shape: const CircleBorder(),
              child: IconButton(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
                onPressed: () async => await onTapAdd?.call(),
              ),
            )
          : null,
    );
  }
}
