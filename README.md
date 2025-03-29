# Chatting App

## Overview
This is a **fully responsive** real-time chat application built using Flutter and Firebase. It allows users to **register**, **sign in**, and **exchange messages** with real-time updates. The chat interface differentiates messages from the sender and receiver using different colors.

## Features
- **User Authentication:** Sign up and login functionality using Firebase Authentication.
- **Real-Time Messaging:** Users can send and receive messages instantly.
- **Message Display:** Messages appear in a chat bubble with different colors for sender and receiver.
- **Scroll Behavior:** When the keyboard opens, the chat scrolls down to display the latest messages.
- **Responsive UI:** Works seamlessly across all screen sizes.
- **Dark & Light Mode:** Users can switch between dark and light themes for a better user experience.

## Technologies Used
- **Flutter** (Dart) - UI framework
- **Firebase Authentication** - User authentication
- **Firebase Firestore** - Real-time message storage

## Installation & Setup
### Prerequisites
Ensure you have the following installed:
- Flutter SDK ([Download here](https://flutter.dev/docs/get-started/install))
- Dart
- Firebase account (for backend setup)

### Steps to Run the Project
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/chatting-app.git
   cd chatting-app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Set up Firebase:
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable **Authentication** (Email/Password sign-in method)
   - Set up **Cloud Firestore** for real-time messaging
   - Download `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and place it in the respective folder (`android/app` or `ios/Runner`)
4. Run the application:
   ```bash
   flutter run
   ```

## Project Structure
```
/lib
|-- components
|   |-- my_textfield.dart
|
|-- services
|   |-- auth
|   |   |-- auth_service.dart
|   |-- chat
|   |   |-- chat_service.dart
|
|-- screens
|   |-- chat_page.dart
|   |-- login_page.dart
|   |-- register_page.dart
|
|-- main.dart
```

## Code Highlights
### Message Sending Function
```dart
void sendMessage() async {
  if (textController.text.isNotEmpty) {
    await chatService.sendMessage(widget.revicerid, textController.text);
    textController.clear();
  }
}
```

### Auto Scrolling When Keyboard Opens
```dart
@override
void initState() {
  super.initState();
  _focusNode.addListener(() {
    if (_focusNode.hasFocus) {
      Future.delayed(Duration(milliseconds: 100), () => scrollDown());
    }
  });
}
```

## Future Improvements
- Adding **image and file sharing**.
- Implementing **group chat** functionality.
- Adding **user profile customization**.

## Contributions
Feel free to submit a pull request or open an issue if you find any bugs or have feature suggestions!

## License
This project is open-source under the MIT License.

