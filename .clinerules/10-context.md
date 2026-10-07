# AD265 environment & known gotchas (facts you can rely on)

The participant works in **VS Code on a Windows Cloud PC** with the MDK Extension, Cloud Foundry CLI (`cf`), and Node.js pre-installed. The entry point is: open VS Code → terminal → `git clone` → work in the MDK app.

## Landscape

- **CF API endpoint:** `https://api.cf.eu10-005.hana.ondemand.com`
- **CF org / space:** org `ad265`, space `dev`
- **Custom IdP origin key:** `tdct3ched1-platform`
- **Mobile Services app ID per participant:** `sap.mobile.ad265.XXX`
- The app uses SAP Mobile Services + a CAP backend for Incident Management, with offline sync and QR-code onboarding on the mobile device.

## Common things that block people (check these first)

1. **CF sign-in uses the wrong URL.** The MDK/CF sign-in dialog must use the **API** endpoint `https://api.cf.eu10-005.hana.ondemand.com` — *not* the app-domain `https://cfapps.eu10-005.hana.ondemand.com`. The app-domain URL has no auth endpoint and login fails.
2. **Wrong identity provider.** On "Choose your identity provider", use **Sign in with alternative identity provider** with origin key `tdct3ched1-platform`.
3. **Deploy / QR code entry point.** Deploy and the onboarding QR code come from the **MDK Page Editor toolbar** (top-right): a blue **Deploy** button and a **QR code** icon, shown whenever a `.page`/`.app` file is open. These are not accessible via the Command Palette or right-click menu.
4. **Empty org list when deploying.** If the org picker during Deploy is empty, the CLI target was not set by the login panel. Fix: run `cf target -o ad265 -s dev` in a VSCode terminal, then start Deploy again.
5. **Wrong app in the picker.** The Mobile Services app picker also lists `techEd` and `myapp.mdk.jitendra`. The participant must pick only their own `sap.mobile.ad265.XXX`.
6. **Incident list is empty after onboarding.** If sync fails with `No data provider exists for serviceName: IncidentManagement`, this is a **landscape/provisioning issue** (a destination named `techEd` instead of `IncidentManagement`), not something the participant can fix in code. Tell them to raise it with an instructor. After it is fixed on the server, a plain "Sync Changes" is not enough — they must **log out and re-onboard (rescan the QR code)**. Then the list loads (Computer Not Booting 30004, Printer Connectivity Problem 30006, TV Display Issue 30005).
7. **Passcode minimum is 8 characters** during onboarding.
