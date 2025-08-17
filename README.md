# WhatsApp Task Flutter App

A pixel-perfect WhatsApp clone built with Flutter, featuring both light and dark modes, smooth animations, and production-quality UI/UX.

## 📱 Screenshots

### Dark Mode
<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/dark_calls_tab.png?raw=true" width="250" alt="Calls Tab - Dark Mode" />
        <br><b>Calls Tab</b>
      </td>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/dark_status_tab.png?raw=true" width="250" alt="Status Tab - Dark Mode" />
        <br><b>Status Tab</b>
      </td>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/dark_chats_tab.png?raw=true" width="250" alt="Chats Tab - Dark Mode" />
        <br><b>Chats Tab</b>
      </td>
    </tr>
  </table>
</div>

### Light Mode
<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/light_calls_tab.png?raw=true" width="250" alt="Calls Tab - Light Mode" />
        <br><b>Calls Tab</b>
      </td>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/light_status_tab.png?raw=true" width="250" alt="Status Tab - Light Mode" />
        <br><b>Status Tab</b>
      </td>
      <td align="center">
        <img src="https://github.com/MARCO-Developer/Whatsapp-task/blob/main/screenshot/light_chats_tab.png?raw=true" width="250" alt="Chats Tab - Light Mode" />
        <br><b>Chats Tab</b>
      </td>
    </tr>
  </table>
</div>

## ✨ Features

### Core Functionality
- **🏠 Home Screen**: Tab-based navigation with Status, Chats, and Calls tabs
- **💬 Chat Screen**: Individual conversation view with message bubbles
- **📸 Status/Stories**: Horizontal scrollable stories with viewing indicators
- **🎨 Theme Support**: Dynamic light/dark mode switching
- **📱 Responsive Design**: Adapts to different screen sizes

### 🎭 Animations & Microinteractions
1. **Animated Chat Tiles**: Staggered slide-in animation with fade effect
2. **Message Bubbles**: Scale and slide animations for incoming messages
3. **Story Items**: Elastic scale animation for story circles
4. **Chat Transition**: Smooth slide transition when opening chats
5. **FAB Animation**: Context-sensitive floating action button
6. **Send Button**: Scale feedback animation on message send

### 🎯 UI/UX Excellence
- **Pixel-Perfect Design**: Matches original WhatsApp colors, spacing, and typography
- **Material Design**: Follows Google's Material Design principles
- **WhatsApp Green**: Authentic color scheme (#25D366)
- **Dark Mode**: Complete dark theme implementation
- **Online Indicators**: Green dots for online status
- **Message Status**: Delivered/read indicators
- **Hero Animations**: Smooth avatar transitions between screens

## 🏗️ Architecture

### Design Pattern
- **BLoC Pattern**: State management using flutter_bloc
- **Clean Architecture**: Separation of presentation, domain, and data layers
- **Dependency Injection**: Service locator pattern with get_it

### Project Structure
```
lib/
├── core/
│   └── theme/
│       └── app_themes.dart          # Light & Dark themes
├── feature/
│   ├── domain/
│   │   └── entities/                # Business entities
│   │       ├── chat.dart
│   │       ├── message.dart
│   │       ├── story.dart
│   │       └── call.dart
│   └── presentation/
│       ├── bloc/                    # State management
│       │   ├── chat/
│       │   ├── story/
│       │   ├── call/
│       │   └── cubits/
│       ├── screens/                 # Main screens
│       │   ├── home_screen.dart
│       │   └── chat_screen.dart
│       └── widget/                  # Reusable widgets
│           ├── animated_chat_tile.dart
│           ├── animated_message_bubble.dart
│           ├── animated_story_item.dart
│           ├── chats_tab.dart
│           ├── status_tab.dart
│           ├── calls_tab.dart
│           └── home_fab.dart
├── injection_container.dart         # Dependency injection
└── main.dart                       # App entry point
```

## 🎨 Design Decisions

### Color Scheme
- **WhatsApp Green**: `#25D366` for primary actions and indicators
- **Dark Green**: `#005C4B` for sent message bubbles
- **Background Colors**: 
  - Light: `#E5DDD5` (chat background)
  - Dark: `#0B141A` (chat background)

### Typography
- **Primary Font**: System default (Roboto on Android, SF Pro on iOS)
- **Font Weights**: 
  - Regular (400) for body text
  - Medium (500) for names and titles
  - Bold (600) for emphasis

### Animation Philosophy
- **Duration**: 200-800ms for optimal user experience
- **Curves**: 
  - `Curves.easeOutBack` for playful entrance animations
  - `Curves.elasticOut` for story items
  - `Curves.easeInOutCubic` for transitions
- **Staggering**: Progressive delays (50-100ms) for list items

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MARCO-Developer/Whatsapp-task.git
   cd Whatsapp-task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3          # State management
  get_it: ^7.6.4                # Dependency injection
  equ
