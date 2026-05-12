# Release process

## 1. Sign the release build

The `release` build type in `android/app/build.gradle.kts` reads credentials
from `android/key.properties`. That file is **git-ignored** — generate it
locally before building.

### Generate an upload keystore (one-off)

```bash
keytool -genkey -v -keystore ~/diliow-upload.keystore \
  -alias diliow -keyalg RSA -keysize 2048 -validity 10000
```

Back up `~/diliow-upload.keystore` somewhere safe — if you lose it, you cannot
update the app on Play Store ever again.

### Configure `android/key.properties`

Copy `android/key.properties.example` to `android/key.properties` and fill in:

```
storePassword=<the password you chose>
keyPassword=<the password you chose>
keyAlias=diliow
storeFile=/absolute/path/to/diliow-upload.keystore
```

## 2. Build the AAB

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

If `android/key.properties` is missing the gradle config falls back to the
debug key, which is **not** accepted by Play Store — useful only for local
release testing.

## 3. Play Console submission checklist

- [ ] App title per locale: `Diliow — What to Do` (en), `Diliow: QueFaire` (fr)
- [ ] Short description (80 char) per locale
- [ ] Full description (4000 char) per locale
- [ ] 2+ phone screenshots per locale (real in-app content, no placeholders)
- [ ] Feature graphic 1024×500 PNG
- [ ] App icon 512×512 PNG → `assets/img/play_store_icon_512.png`
- [ ] Privacy policy URL → host `docs/privacy.html` on GitHub Pages
- [ ] Content rating questionnaire (no violence / user content / ads → 3+)
- [ ] Data safety form: declare zero data collection (everything local)
- [ ] Target audience: 13+
- [ ] Category: Tools (primary) / Lifestyle (secondary)
- [ ] Tags: utility, decision-maker, random, picker
- [ ] Closed testing track: ≥ 12 testers active for ≥ 14 days
