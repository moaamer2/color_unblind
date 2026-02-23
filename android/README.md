# Color Unblind - Android 


This directory serves as the **native Android host** for the Color Unblind application. It manages platform-specific configurations, hardware permissions, and the integration of the machine learning model required for real-time color processing.

---

##  Project Configuration

| Specification | Details |
| :--- | :--- |
| **Package Name** | `com.example.colors_blind` |
| **Min SDK** | `21` (Android 5.0) |
| **Target SDK** | `35` (Android 15) |
| **Build System** | Gradle with Kotlin DSL (`.kts`) |

---

##  Key Components

* ** AI Model**: The `color.tflite` model is stored in the assets folder and provides the core logic for identifying and correcting colors.
* ** Permissions**: Configured to handle high-level hardware access, specifically for camera and internet functionality.
* ** Native Splash**: Implements specialized splash screen support for Android 12+ (API 31).

---

##  Folder Structure

```text
android/
├── app/
│   ├── src/main/
│   │   ├── AndroidManifest.xml  # App metadata and permissions
│   │   ├── assets/              # Machine learning (color.tflite) model
│   │   ├── kotlin/              # Android entry point (MainActivity)
│   │   └── res/                 # App icons and splash screen resources
│   └── build.gradle.kts         # App-level build configuration
├── gradle/                      # Gradle wrapper files
└── build.gradle.kts             # Project-level build configuration
