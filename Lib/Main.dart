name: Build APK
on:
  workflow_dispatch:
  push:
    branches: [main]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - name: Build
        run: |
          mkdir /tmp/app && cd /tmp/app
          flutter create --platforms=android le-capricieux_paint
          cd le-capricieux_paint
          cp $GITHUB_WORKSPACE/lib/main.dart lib/main.dart
          flutter pub add shared_preferences
          flutter build apk --release
      - uses: actions/upload-artifact@v4
        with:
          name: le-capricieux_paint-apk
          path: /tmp/app/le-capricieux_paint/build/app/outputs/flutter-apk/app-release.apk
