import '/custom_code/ui/app_components.dart';
import '/custom_code/ui/app_tokens.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package_payment_success_model.dart';
export 'package_payment_success_model.dart';

/// "Complete your payment" card: amount, the Selcom pay number (copyable) and the pay / later buttons.
/// Opaque and readable on top of the package list.
class PackagePaymentSuccessWidget extends StatelessWidget {
  const PackagePaymentSuccessWidget({
    super.key,
    required this.amount,
    required this.lipanumber,
    required this.paymentlink,
  });

  final String? amount;
  final String? lipanumber;
  final String? paymentlink;

  String get _amountText {
    final value = double.tryParse(amount ?? '');
    if (value == null) return amount ?? '';
    final whole = value.round().toString();
    final grouped = whole.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return 'TZS $grouped';
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final accent = dark ? AppTokens.darkAccent : AppTokens.brandPrimary;
    final text = dark ? AppTokens.darkText : AppTokens.textPrimary;
    final muted = dark ? AppTokens.darkTextSecondary : AppTokens.textSecondary;
    final number = lipanumber ?? '';

    return AppDialogCard(
      icon: Icons.payments_rounded,
      title: trs('complete_payment'),
      message: trs('pay_hint'),
      actions: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTokens.radiusInput + 2),
            color: accent.withValues(alpha: 0.10),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(trs('dcwrzltf'), style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 12.5, fontWeight: FontWeight.w700, letterSpacing: 0.6)),
            Row(children: [
              Expanded(
                child: SelectableText(number,
                    style: TextStyle(fontFamily: AppTokens.fontFamily, color: text, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 1)),
              ),
              IconButton(
                tooltip: trs('copy_number'),
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                icon: Icon(Icons.copy_rounded, color: accent),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: number));
                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(trs('copied'))));
                },
              ),
            ]),
            const SizedBox(height: 4),
            Text(trs('amount_label'), style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 12.5)),
            Text(_amountText, style: TextStyle(fontFamily: AppTokens.fontFamily, color: accent, fontSize: 22, fontWeight: FontWeight.w800)),
          ]),
        ),
        Text(trs('eznefvfn'), textAlign: TextAlign.center, style: TextStyle(fontFamily: AppTokens.fontFamily, color: muted, fontSize: 13)),
        AppButton(
          label: trs('fx01qmw3'),
          icon: Icons.open_in_new_rounded,
          onPressed: () async {
            await launchURL(paymentlink ?? '');
          },
        ),
        AppButton(label: trs('retxuu9v'), kind: AppButtonKind.secondary, onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
