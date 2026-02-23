#  Color Unblind - Web Version



**Color Unblind** is a specialized Flutter-based web application designed to assist individuals with color vision deficiencies. By leveraging computer vision and advanced image processing, the platform provides essential tools for diagnostic testing, real-time image correction, and visual simulation.

---

##  Core Features

* ** Image Processing & Correction**: Upload images to apply real-time correction filters or simulate how different types of color blindness perceive specific visuals.
* ** Live Video Assistance**: Real-time camera stream processing using web camera feeds to apply corrective filters on the fly.
* ** Cloud Integration**: Robust and secure image handling and data storage powered by the **Supabase** ecosystem.
* ** Multilingual Support**: A fully localized interface offering seamless support for both **English** and **Arabic**.
* ** Responsive Design**: A UI optimized for a wide variety of screen sizes and browsers using advanced scaling techniques.

---

##  Technical Stack

The application is built with a modern, modular architecture to ensure scalability and performance:

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Frontend** | **Flutter Web** (SDK ^3.9.0) | Multi-platform UI framework. |
| **State Management** | **BLoC / Cubit** | Predictable state transitions and logic separation. |
| **Backend** | **Supabase** | Authentication and cloud storage. |
| **Networking** | **Dio** | Powerful HTTP client for API communication. |
| **DI** | **GetIt** | Service locator for dependency injection. |
| **Localization** | **Easy Localization** | Managing RTL/LTR support and translations. |

---

## 📂 Folder Structure

The project follows a clean architecture pattern to separate concerns:

```text
lib/
├── core/         # Shared services (Localization, Internet state, Image conversion)
├── module/       # Business logic, Repositories, and Data models
├── presentation/ # UI Layer (Screens, Widgets, and Styling)
└── assets/       # Translation files, Custom fonts, and Images
