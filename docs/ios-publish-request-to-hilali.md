# Ombi kwa Hilali (Account Holder) / Request to Hilali

Amani is now Admin in App Store Connect for "Hilali Alexander Ruhundwa", but your team does not appear in the
Apple *developer portal* for his Apple ID. So the three signing items below must be done by you (the Account Holder)
at https://developer.apple.com/account/resources (Certificates, Identifiers & Profiles).

## Kiswahili
Habari Hilali. Tafadhali fanya yafuatayo kwenye https://developer.apple.com/account (ukiwa umeingia na iCloud yako):
1. **Identifiers → (+) → App IDs → App → Continue**
   - Description: `Simulizi za Sauti`
   - Bundle ID (Explicit): `com.simulizi.ruhundwa.ios`
   - Capabilities: washa **In-App Purchase** tu. Kisha Register.
2. **Certificates → (+) → Apple Distribution → Continue** → pakia faili `ios-distribution.csr` (nitakutumia) → Continue → **Download** faili la `.cer` na unitumie.
3. **Profiles → (+) → App Store Connect (Distribution) → Continue** → chagua App ID `com.simulizi.ruhundwa.ios` → chagua cheti ulichounda → Profile name: `Simulizi za Sauti AppStore` → Generate → **Download** `.mobileprovision` na unitumie.
4. (Hiari) **App Store Connect → Users and Access → Integrations → App Store Connect API → Team Keys → (+)**, role **App Manager**, pakua `.p8` na unitumie na Issuer ID + Key ID (ili tupakie build bila nenosiri).

## English
Hi Hilali. Please do this at https://developer.apple.com/account while signed in with your iCloud account:
1. **Identifiers → (+) → App IDs → App → Continue**: Description `Simulizi za Sauti`, Bundle ID (Explicit) `com.simulizi.ruhundwa.ios`, enable **In-App Purchase** only, Register.
2. **Certificates → (+) → Apple Distribution → Continue** → upload `ios-distribution.csr` (I will send it) → **Download** the `.cer` and send it back.
3. **Profiles → (+) → App Store Connect (Distribution)** → select App ID `com.simulizi.ruhundwa.ios` → select the certificate from step 2 → name `Simulizi za Sauti AppStore` → Generate → **Download** the `.mobileprovision` and send it back.
4. (Optional) **App Store Connect → Users and Access → Integrations → App Store Connect API → Team Keys → (+)**, role App Manager, download the `.p8`, and send it with the Issuer ID and Key ID so builds can be uploaded without a password.

Files to send Hilali: `~/Desktop/ios-distribution.csr` (it only contains a public request; the private key stays on Amani's Mac).
