# Where the exercise material is — read on demand, reveal gradually

For each exercise, the `.coach/` folder holds two references. Read them **on demand** only — when you have reached the coaching stage (the participant explicitly asks, or is clearly stuck). Never open them on the first hint; that spoils the staged coaching.

- **`.coach/exN.md`** — the exercise's **step-by-step instructions** (the participant's README, images stripped). This is the authoritative **method**: which control, which property, the exact Page Editor / Object Browser steps, in order. Use it to give precise, correct steps instead of guessing the UI (don't invent click-paths — read the real ones here).
- **`.coach/exN.diff`** — the **end-result** patch (the solved code). Use it to verify, or at the final stage to show the concrete change. Translate it into editor actions (see the persona rule); it is a reference, not something to `git apply`.

Rule of thumb: `.coach/exN.md` for *how to do it*, `.coach/exN.diff` for *what the result is*. Explain in your own words, one step at a time; paste raw diff lines only when actually showing the solution.

## Per exercise

- **Exercise 1 — Run the starting application on your device.** No code change (deploy + device onboarding only), so there is no patch. Coach from the steps in `.coach/ex1.md` and the environment gotchas in `10-context.md`.
- **Exercise 2 — Enhance the Incident detail page.** On `Incident_Detail.page` only: add a **Profile Header** section showing customer info (name, city/country, phone/email/message), wired via the page's design-time `QueryOptions: $expand=customer`. Full patch: **`.coach/ex2.diff`**.
- **Exercise 3 — Modify an incident record.** On `Incident_Edit.page`: add form controls (status list picker, device-ID field, image attachment, inline signature) and a **Save** action-bar item. Save chains two OData actions — `Incident_UpdateEntity.action` (status + device ID) then `Incident_UploadStream.action` (image + signature) — plus three rules: `EditOptionVisibility.js` (show/hide image+signature by status), `Incident_ValidateEdit.js` (validate before save), and `StatusChangeProtocol.js` (at `Rules/StatusChangeProtocol.js`, not `Rules/Incident/`). It also binds the **Edit** action-bar item's `Visible` on `Incident_Detail.page` to `EditOptionVisibility.js`. Full patch: **`.coach/ex3.diff`**.
- **Exercise 4 — Enhance the app using GenAI (i18n).** Generate translation files for seven languages (`i18n_de/es/fr/it/ja/pt/zh.properties`) via Joule, then localize the Incidents list caption on `Incident_List.page` with the `$(L,'Incidents')` formatter. Full patch: **`.coach/ex4.diff`**.

## Notes / caveats

- `.coach/exN.diff` are generated from the reference MDKApp solution checkpoints (tags `base`, `ex2-solution`, `ex3-solution`, `ex4-solution`) via `.gen-coach.sh` — scoped to exactly what that exercise changes; editor noise and incidental tweaks are excluded. A reference, not something to `git apply`.
- `.coach/exN.md` are the exercise instructions, synced from the AD265 instructions repo via `.gen-readmes.sh` (images stripped). They are the method/steps source. Both are generated — do not hand-edit; re-run the generators instead.
