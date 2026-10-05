# Where the solutions are — read the patch on demand, reveal gradually

The full solution for an exercise is a **patch file** in the `coach/` folder of this workspace. Read it only when you have reached the final coaching stage (the participant explicitly asks for the solution, or is clearly still blocked). Do not open it on the first hint — that is what spoils the staged coaching.

Explain the change in your own words, one step at a time; paste raw diff lines only when actually showing the solution.

## Per exercise

- **Exercise 1 — Run the starting application on your device.** No code change (deploy + device onboarding only). There is no patch; coach from the exercise README and the environment gotchas in `10-context.md`.
- **Exercise 2 — Enhance the Incident detail page.** On `Incident_Detail.page` only: add a **Profile Header** section showing customer info (name, city/country, phone/email/message), wired via the page's design-time `QueryOptions: $expand=customer`. Full patch: **`coach/ex2.diff`**.
- **Exercise 3 — Modify an incident record.** On `Incident_Edit.page`: add form controls (status list picker, device-ID field, image attachment, inline signature) and a **Save** action-bar item. Save chains two OData actions — `Incident_UpdateEntity.action` (status + device ID) then `Incident_UploadStream.action` (image + signature) — plus three rules: `EditOptionVisibility.js` (show/hide image+signature by status), `Incident_ValidateEdit.js` (validate before save), and `StatusChangeProtocol.js` (at `Rules/StatusChangeProtocol.js`, not `Rules/Incident/`). It also binds the **Edit** action-bar item's `Visible` on `Incident_Detail.page` to `EditOptionVisibility.js`. Full patch: **`coach/ex3.diff`**.
- **Exercise 4 — Enhance the app using GenAI (i18n).** Generate translation files for seven languages (`i18n_de/es/fr/it/ja/pt/zh.properties`) via Joule, then localize the Incidents list caption on `Incident_List.page` with the `$(L,'Incidents')` formatter. Full patch: **`coach/ex4.diff`**.

## Notes / caveats for these patches

- The patches are generated from the reference MDKApp solution checkpoints (tags `base`, `ex2-solution`, `ex3-solution`, `ex4-solution`) via `gen-coach.sh` — a coaching reference, not something to `git apply` into the participant's project. Each diff is scoped to exactly what that exercise's README documents (editor noise and incidental tweaks are intentionally excluded).
