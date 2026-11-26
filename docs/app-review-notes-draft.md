# Apple rejection (Guideline 2.1 — Information Needed) — what to do

Apple has **not** rejected the app for a bug; it wants more information pasted into **App Store Connect →
your app → App Review → Notes**, plus a screen recording. Below is draft text for the Notes field (check it,
especially the bracketed [CONFIRM] parts, before pasting) and what the recording needs to show.

**I cannot make the recording myself** — it has no physical device, and Apple explicitly requires one ("captured
on a physical device, running the latest operating system"); a simulator recording will likely be rejected again.
Record it on an iPhone with QuickTime (Mac: plug the iPhone in, open QuickTime Player → File → New Movie
Recording → select the iPhone as the camera) or the iPhone's own screen-recording control.

## Recording script (2–4 minutes, continuous, no cuts)
1. Launch the app from the Home Screen (don't resume from the app switcher).
2. Onboarding → Home screen.
3. Sign in with the demo account below.
4. Open a story, play a **free** episode for a few seconds.
5. Open a **locked** episode, show the unlock card, and unlock it (the demo account should have enough coins —
   top it up first if not, so the recording doesn't stall on a real payment).
6. Show the Downloads tab (episodes grouped by story) and Search.
7. Settings → show the sign-out option. [If you add account deletion before resubmitting — see below — show
   that too.]

## Draft text for the Notes field

---

**1. Demo account**
Email: `[CONFIRM — e.g. ayman@gmail.com]`
Password: `[CONFIRM]`
(One account type only; no admin/staff account exists in the app.)

**2. Purpose and audience**
Simulizi za Sauti ("Audio Stories") is a Swahili-language audio storytelling app for Swahili-speaking
listeners, primarily in Tanzania and East Africa. It solves the lack of a dedicated place to listen to
serialized Swahili fiction (romance, mystery, detective, horror) read aloud, with offline listening for areas
with unreliable data connectivity. Readers get entertainment in their own language; authors get a way to
publish and be paid for audio adaptations of their stories.

**3. Setting up and using the app**
No account is required to browse and play the first episode(s) of each story. To save favourites, download
episodes, or unlock paid episodes, create an account (email/password or Google) or use the demo account above.
Paid episodes are unlocked with in-app "coins" purchased via mobile money (see below).

**4. External services used**
- Firebase Authentication and Firebase Cloud Messaging (Google) — sign-in and push notifications.
- Google Sign-In — optional social login.
- Selcom (a Tanzanian mobile-money payment processor) — purchasing coins used to unlock episodes.
- The operator's own backend API (szs.co.tz) — story catalogue, episodes, user accounts and audio streaming.

**5. Regional differences**
The app's content and language (Swahili/English) are the same in every region. [CONFIRM: Selcom mobile-money
top-ups currently work with Tanzanian mobile-money numbers; if a user outside Tanzania cannot complete a
purchase, say so here, e.g. "Coin purchases currently require a Tanzanian mobile-money number; browsing and
free episodes work everywhere."]

**6. Rights to third-party material**
The audio stories, cover art and author names belong to their respective Swahili authors, who have agreed to
have their work published through this app. [CONFIRM: if you hold written agreements/licences with the
authors, say so here; Apple may ask to see them.]

---

## Before you resubmit: two real risks, not covered by this rejection yet

**A. Account deletion (very likely to be the next rejection, guideline 5.1.1(v))**
Apple's own checklist above says: *"Account deletion is required in apps that support account creation."* This
app lets people create an account but has **no way to delete one**, in the app or on the website. I checked the
code and the backend API list — there is no delete-account endpoint at all today. I have not built anything
fake to paper over this. It needs:
1. A backend endpoint to delete (or at least permanently disable + erase) a user's account and data.
2. An in-app "Delete account" action (e.g. in Settings) that calls it after a confirmation step.

I've drafted the backend request below; tell me once the endpoint exists and I'll build the in-app side.

**B. In-App Purchase for coins (guideline 3.1.1)**
Coins are bought through Selcom (real-world mobile money), not Apple's In-App Purchase. Apple generally
requires digital content/features unlocked inside an iOS app to be sold through Apple's own In-App Purchase,
not a third-party payment processor. This review did not cite 3.1.1 yet, but it is listed in their "Prevent
Common Issues" section and is a common second-round rejection for apps like this. Options, roughly in order of
effort: (1) add Apple In-App Purchase as the payment path on iOS only, keeping Selcom for Android; (2) argue the
"reader app" exception (Apple sometimes allows this for apps primarily about previously-purchased/physical-world
content, but coin-funded unlocks rarely qualify); (3) accept the risk and address it if/when Apple flags it.
This is a product decision — tell me which way you want to go and I will act on it.

---

## Backend request: account deletion endpoint

> Tunahitaji njia ya kufuta akaunti ya mtumiaji (required by Apple App Store, guideline 5.1.1). Tafadhali
> ongezeni:
> 1. **Endpoint**: km. `POST /public/api/delete_account` ikichukua `user_id` (na token ya uthibitisho), ikifuta
>    au kuzima kabisa akaunti na taarifa zake binafsi (jina, barua pepe, namba ya simu), huku zikiacha rekodi
>    zisizo na utambulisho binafsi zinazohitajika kisheria/kihasibu (km. malipo yaliyokamilika) bila jina.
> 2. Baada ya kufutwa, token ya mtumiaji huyo isiendelee kufanya kazi (logout ya kulazimishwa).
> 3. Jibu wazi la mafanikio/kushindwa (status + message), kama API nyingine zilizopo.
>
> (English: We need an account-deletion endpoint, e.g. `POST /public/api/delete_account` taking `user_id` +
> auth token, which deletes or fully anonymises the account's personal data — name, email, phone — while
> keeping any records required for legal/accounting reasons without personal identifiers. The user's token
> should stop working afterwards. Please return the same success/failure shape as your other endpoints.)
