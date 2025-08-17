# WhatsApp Clone Flutter App

A pixel-perfect WhatsApp clone built with Flutter, featuring both light and dark modes, smooth animations, and production-quality UI/UX.

## 📱 Screenshots

### Dark Mode
<div align="center">
  <img src="screenshots/dark_calls_tab.png" width="250" alt="Calls Tab - Dark Mode" />
  <img src="screenshots/dark_status_tab.png" width="250" alt="Status Tab - Dark Mode" />
  <img src="screenshots/dark_chats_tab.png" width="250" alt="Chats Tab - Dark Mode" />
</div>

### Light Mode
<div align="center">
  <img src="screenshots/light_calls_tab.png" width="250" alt="Calls Tab - Light Mode" />
  <img src="screenshots/light_status_tab.png" width="250" alt="Status Tab - Light Mode" />
  <img src="screenshots/light_chats_tab.png" width="250" alt="Chats Tab - Light Mode" />
</div>

## ✨ Features

### Core Functionality
- **Home Screen**: Tab-based navigation with Status, Chats, and Calls tabs
- **Chat Screen**: Individual conversation view with message bubbles
- **Status/Stories**: Horizontal scrollable stories with viewing indicators
- **Theme Support**: Dynamic light/dark mode switching
- **Responsive Design**: Adapts to different screen sizes

### Animations & Microinteractions
1. **Animated Chat Tiles**: Staggered slide-in animation with fade effect
2. **Message Bubbles**: Scale and slide animations for incoming messages
3. **Story Items**: Elastic scale animation for story circles
4. **Chat Transition**: Smooth slide transition when opening chats
5. **FAB Animation**: Context-sensitive floating action button
6. **Send Button**: Scale feedback animation on message send

### UI/UX Excellence
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

### Layout Principles
- **Consistent Spacing**: 8px, 16px, 24px grid system
- **Touch Targets**: Minimum 44px for accessibility
- **Visual Hierarchy**: Clear information hierarchy with proper contrast
- **Safe Areas**: Proper handling of device notches and bottom bars

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/whatsapp-clone-flutter.git
   cd whatsapp-clone-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build for Release

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS and Xcode)
flutter build ios --release
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3          # State management
  get_it: ^7.6.4                # Dependency injection
  equatable: ^2.0.5             # Value comparison

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0         # Code analysis
  flutter_native_splash: ^2.3.5  # Splash screen
```

## 🔧 Configuration

### Theme Switching
The app automatically detects system theme preference and allows manual switching:

```dart
// Toggle theme
context.read<ThemeCubit>().toggleTheme();
```

### Adding New Features
1. Create new entity in `domain/entities/`
2. Add corresponding BLoC in `presentation/bloc/`
3. Create UI widgets in `presentation/widget/`
4. Register dependencies in `injection_container.dart`

## 🎯 Quality Assurance

### Code Quality
- **Linting**: Strict Flutter lints enabled
- **Architecture**: Clean separation of concerns
- **Performance**: Optimized ListView builders and animations
- **Memory Management**: Proper disposal of controllers and streams

### Testing Strategy
- **Unit Tests**: Business logic validation
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end user flows

### Performance Optimization
- **Lazy Loading**: Lists load items on demand
- **Animation Controllers**: Properly disposed to prevent memory leaks
- **Hero Animations**: Smooth transitions between screens
- **Efficient Rebuilds**: BLoC pattern minimizes unnecessary rebuilds

## 🎨 Microinteractions Details

### 1. Chat Tile Animation
- **Entry**: Staggered slide-in from right with 50ms delays
- **Fade**: Progressive opacity animation
- **Tap**: Reverse animation before navigation

### 2. Message Bubbles
- **Slide**: Different directions for sent/received messages
- **Scale**: Elastic entrance animation
- **Status**: Color-coded delivery indicators

## 🌙 Dark Mode Implementation

Complete dark theme support with:
- **Automatic Detection**: Follows system preference
- **Manual Toggle**: User can override system setting
- **Consistent Colors**: All components adapt properly
- **Accessibility**: Maintains proper contrast ratios

## 🔮 Future Enhancements

- [ ] Voice messages with waveform visualization
- [ ] Image/video sharing capabilities
- [ ] Push notifications integration
- [ ] Real-time messaging with WebSocket
- [ ] Story creation and sharing
- [ ] Video/voice calling interface
- [ ] Chat encryption indicators
- [ ] Message search functionality
- [ ] Group chat management
- [ ] Contact integration

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **WhatsApp**: For the original design inspiration
- **Flutter Team**: For the amazing framework
- **Material Design**: For design guidelines
- **Community**: For open-source packages and resources

## 📧 Contact

**Developer**: [Your Name]
- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)

---

<div align="center">
  <p>⭐ Star this repo if you find it helpful!</p>
  <p>Made with ❤️ and Flutter</p>
</div>