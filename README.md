# 📸 FrameBox

> "Every memory deserves a frame."

**FrameBox** is a mobile social network application prototype designed for photo sharing. The project simulates a real-world community experience, allowing users to browse profiles, explore photo albums, and interact with memories through comments and likes.

## 📱 About the Project

This application was developed using **Dart** and **Flutter** to demonstrate the implementation of complex UI/UX designs and the consumption of RESTful APIs. The goal was to build a fluid, responsive interface that handles asynchronous data to populate a social media environment.

### ✨ Key Features

* **User Discovery:** Browse a list of users with a clean interface, including search functionality.
* **Profile & Albums:** View specific user profiles and their associated photo albums.
* **Photo Gallery:** Interactive grid layout to display photos within albums.
* **Photo Details:** A dedicated view for individual photos, simulating social interactions like comments, likes, and descriptions.
* **Modern UI:** A polished, purple-themed interface focused on usability and visual hierarchy.

## 🛠️ Tech Stack

* **Language:** Dart
* **Framework:** Flutter
* **Architecture:** MVC 
* **Networking:** HTTP / Dio

## 🔗 APIs & Data Integration

To create a realistic experience with dynamic content, the application integrates two distinct public APIs:

1.  **[JSONPlaceholder](https://jsonplaceholder.typicode.com/):**
    * Acts as the backend service.
    * Provides the relational data structure for **Users**, **Albums**, **Photos**, and **Comments**.

2.  **[Pravatar](https://pravatar.cc/):**
    * Used to enhance the UI visual experience.
    * Since the main API does not provide user avatars, Pravatar is consumed to generate realistic profile pictures for the user list and headers.

## 🚀 Getting Started

Follow these steps to run the project locally:

**Prerequisites:** Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.

```bash
# 1. Clone this repository
git clone [https://github.com/your-username/framebox.git](https://github.com/your-username/framebox.git)

# 2. Go to the project directory
cd framebox

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
