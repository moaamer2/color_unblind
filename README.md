# colors_blind

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Color Blindness Aid App & Web

A comprehensive application and website to assist people with color blindness. 
Features include: 
- Color blindness testing
- Real-time color correction
- Image/Video correction
- Generating corrected images

## Project Structure

- `Models/` → Simulation and correction models (Pix2Pix, Daltonization)
- `android/` → Android app version
- `ios/` → iOS app version
- `web/` → Web version of the app
- `lib/` → Shared code and utilities
- `assets/` → Images, icons, and resources

## Getting Started

1. Train or download the pre-trained models from `Models/`.
2. Run the application on your preferred platform (Android, iOS, Web).
3. Follow platform-specific instructions in each folder's README.

## Notes

- Models are stored on Google Drive for easy access.
- Requires Python, PyTorch, and relevant libraries for model training.
- Flutter is used for mobile and web apps.
