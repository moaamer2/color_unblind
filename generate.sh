# for build_runner
# flutter pub run build_runner build --delete-conflicting-outputs

# for localization 
    # generate `CodegenLoader` assets loader
# flutter pub run easy_localization:generate -S assets/translations -O lib/core/services/localization
    # generate `LocaleKeys`
flutter pub run easy_localization:generate -S assets/translation -O lib/core/services/localization -f keys -o locale_keys.g.dart