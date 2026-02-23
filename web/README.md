Color Unblind - Web Version
Color Unblind is a specialized Flutter-based web application designed to assist individuals with color vision deficiencies. By leveraging computer vision and image processing, the platform provides tools for testing, image correction, and visual simulation.

- Core Features
Color Blindness Testing: Interactive diagnostic tests (such as Ishihara-style assessments) to help users identify specific types of color vision deficiency.

Image Processing & Correction: Users can upload images to apply real-time color correction filters or simulate how different types of color blindness perceive those images.

Live Video Assistance: Utilizing web camera streams to apply live color correction filters.

Cloud Integration: Secure image handling and storage powered by Supabase.

Multilingual Support: Fully localized interface supporting both English and Arabic.

Responsive Design: Optimized for various screen sizes and browsers using advanced UI scaling.

- Technical Stack
Frontend: Flutter Web (SDK ^3.9.0).

State Management: BLoC / Cubit for predictable UI state transitions.

Backend Services: Supabase for authentication and storage services.

Networking: Dio for robust API communication.

Dependency Injection: GetIt for modular and testable code architecture.

Internationalization: easy_localization for managing RTL and LTR languages.

- Folder Structure
lib/core/: Contains shared services like localization, internet state, and image conversion.

lib/module/: Core business logic, data models (e.g., color_blind_type.dart), and repositories.

lib/presentation/: The UI layer, including screens for testing and processing, along with shared widgets and styling.

assets/: Houses translation files, custom fonts (Montserrat, Impact), and graphic assets.

- Getting Started
Prerequisites
Flutter SDK (^3.9.0)

A modern web browser (Chrome, Firefox, or Edge recommended)

Installation
Clone the repository:


git clone https://github.com/moaamer2/color_unblind.git
cd color_unblind

Install dependencies:

flutter pub get


Run the application:

flutter run -d chrome

Building for Production

To generate a highly optimized web build:

flutter build web --release --web-renderer canvaskit
