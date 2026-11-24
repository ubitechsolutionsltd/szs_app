import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'language_select_a_lrt_dialog_model.dart';
export 'language_select_a_lrt_dialog_model.dart';

/// Language picker (Kiswahili / English). Marks the language that is actually active.
class LanguageSelectALrtDialogWidget extends StatelessWidget {
  const LanguageSelectALrtDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final current = FFLocalizations.of(context).languageCode;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;

    Widget option(String code, int index, String label) {
      final selected = current == code;
      return Semantics(
        button: true,
        selected: selected,
        label: label,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTokens.radiusInput),
          onTap: () {
            FFAppState().langIndex = index;
            setAppLanguage(context, code);
            Navigator.pop(context);
          },
          child: Container(
            constraints: const BoxConstraints(minHeight: 56),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusInput),
              color: selected ? accent.withValues(alpha: 0.12) : Colors.transparent,
              border: Border.all(color: selected ? accent : (dark ? AppTokens.darkBorder : AppTokens.border), width: selected ? 1.6 : 1),
            ),
            child: Row(children: [
              Expanded(
                child: Text(label,
                    style: TextStyle(
                        fontFamily: AppTokens.fontFamily,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: dark ? AppTokens.darkText : AppTokens.textPrimary)),
              ),
              if (selected) Icon(Icons.check_circle_rounded, color: accent),
            ]),
          ),
        ),
      );
    }

    return AppDialogCard(
      icon: Icons.translate_rounded,
      title: trs('6t5vctjg'),
      actions: [
        option('sw', 0, trs('fvirzxyl')),
        option('en', 1, trs('6s0s4jvz')),
        AppButton(label: trs('cancel'), kind: AppButtonKind.text, onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
