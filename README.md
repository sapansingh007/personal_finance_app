# Personal Finance Dashboard App

A comprehensive Personal Finance Dashboard app built with Flutter that displays a user's financial summary and recent transactions using mocked/local data only.

## Features

### Core Features
- **User Authentication**: Login screen with form validation and demo credentials
- **Financial Dashboard**: Overview of balance, income, expenses, and recent transactions
- **Transaction Management**: Browse, search, and filter transactions by type and date range
- **Transaction Details**: View detailed information for individual transactions
- **Data Visualization**: Weekly overview bar chart showing spending patterns

### Enhanced Features
- **Light/Dark Mode**: Complete theme support with persistent user preferences
- **Shimmer Loading**: Beautiful skeleton loading effects during data fetching
- **Smooth Animations**: Card tap animations and navigation transitions
- **Static Charts**: Simple bar chart for weekly financial overview
- **Responsive Design**: Optimized for mobile devices with proper overflow handling

## Setup Instructions

### Prerequisites
- Flutter SDK (>=3.9.0)
- Dart SDK (>=3.9.0)
- Android Studio or VS Code with Flutter extensions
- Android device/emulator for testing

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd personal_finance_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For connected device
   flutter run -d <device-id>
   
   # For emulator
   flutter run
   ```

4. **Demo Credentials**
   - **Email**: `user@example.com`
   - **Password**: `password123`

### Build for Production

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release
```

## Technical Architecture

### Framework & Libraries

#### Core Framework
- **Flutter 3.9.0+**: Cross-platform UI framework
- **Dart 3.9.0+**: Programming language

#### State Management & Navigation
- **GetX 4.6.6**: 
  - State management with reactive variables (Obx)
  - Navigation and routing
  - Dependency injection
  - Internationalization support

#### Data Persistence
- **SharedPreferences 2.2.2**: 
  - Theme preference storage
  - User settings persistence

#### UI Components
- **Material Design 3**: Modern design system
- **Custom Widgets**: Reusable components for cards, buttons, tiles

### Project Structure

```
lib/
├── core/                          # Core utilities and shared components
│   ├── controllers/              # GetX controllers
│   │   └── theme_controller.dart # Theme management
│   ├── theme/                    # App theming
│   │   ├── app_colors.dart       # Light/dark color palettes
│   │   ├── app_text_styles.dart  # Typography definitions
│   │   └── app_theme.dart       # Theme configurations
│   ├── utils/                    # Utility functions
│   │   ├── mock_data.dart        # Sample data
│   │   └── validators.dart       # Form validation
│   └── widgets/                  # Reusable UI components
│       ├── animated_card.dart    # Animated card widget
│       ├── empty_state.dart      # Empty state displays
│       ├── loading_view.dart     # Loading indicators with shimmer
│       ├── primary_button.dart   # Custom buttons
│       ├── simple_bar_chart.dart # Chart widget
│       ├── summary_card.dart     # Financial summary cards
│       └── transaction_tile.dart # Transaction list items
├── models/                       # Data models
│   ├── summary_model.dart        # Financial summary data
│   └── transaction_model.dart    # Transaction data structure
├── modules/                      # Feature modules
│   ├── dashboard/                # Dashboard screen
│   ├── login/                    # Authentication screen
│   ├── transaction_detail/      # Transaction details screen
│   └── transactions/             # Transaction list screen
├── routes/                       # Navigation configuration
│   └── app_routes.dart           # Route definitions
└── main.dart                     # App entry point
```

## Design System

### Color Palette
- **Primary**: Indigo (#4F46E5)
- **Secondary**: Emerald (#10B981)
- **Semantic**: Success, Warning, Error colors
- **Neutral**: Surface, background, text colors
- **Dark Theme**: Complete dark mode color scheme

### Typography
- **Headlines**: Roboto font with varying weights
- **Body**: Consistent text sizing for readability
- **Labels**: Smaller text for form fields and captions

### Components
- **Cards**: Rounded corners with elevation
- **Buttons**: Primary and secondary variants
- **Forms**: Material Design 3 text fields
- **Navigation**: Bottom navigation and app bars

## Data Management

### Mock Data Strategy
- **Local Data Only**: No external API calls or network dependencies
- **Realistic Samples**: 50+ transactions with varied categories
- **Dynamic Calculations**: Real-time balance and summary computations
- **Category Distribution**: Food, Transport, Shopping, Entertainment, etc.

### Data Models
- **Transaction Model**: Complete transaction structure with validation
- **Summary Model**: Financial overview with calculated properties
- **Enum Types**: Transaction types and categories for type safety

## Assumptions & Trade-offs

### Assumptions Made
1. **Offline-First**: App works completely offline with local data
2. **Single User**: Designed for individual use, no multi-user support
3. **Mock Data**: Uses predefined data instead of real financial APIs
4. **Mobile-First**: Optimized for mobile devices, tablet support secondary
5. **Demo Credentials**: Fixed login credentials for demonstration

### Technical Trade-offs
1. **GetX vs Provider**: Chose GetX for simplicity and built-in navigation
2. **SharedPreferences vs SQLite**: Simple key-value storage for theme settings
3. **Custom Charts vs Chart Library**: Built simple bar chart for lightweight implementation
4. **Mock Data vs API**: Faster development, no external dependencies
5. **Single Page Architecture**: Streamlined navigation with GetX routing

## Future Improvements

### With More Time, I Would Enhance:

#### 1. **Data Persistence**
- **SQLite Integration**: Replace mock data with local database
- **Data Import/Export**: CSV import/export functionality
- **Backup & Sync**: Cloud backup and multi-device sync

#### 2. **Advanced Features**
- **Budget Management**: Set and track spending limits
- **Bill Reminders**: Notification system for upcoming bills
- **Financial Goals**: Savings goals and progress tracking
- **Reports & Analytics**: Monthly/yearly financial reports

#### 3. **Enhanced UI/UX**
- **Custom Animations**: More sophisticated micro-interactions
- **Interactive Charts**: Touch-enabled charts with drill-down capabilities
- **Gesture Navigation**: Swipe gestures for common actions
- **Accessibility**: Improved screen reader support

#### 4. **Technical Improvements**
- **State Management**: Consider BLoC or Riverpod for complex state
- **Error Handling**: Comprehensive error boundaries and recovery
- **Testing**: Unit, widget, and integration tests
- **Performance**: Lazy loading and memory optimization

#### 5. **Platform Integration**
- **Biometric Auth**: Fingerprint/face recognition
- **Widgets**: Home screen widgets for quick balance view
- **Notifications**: Smart financial notifications
- **Bank Integration**: Connect to real bank accounts (with proper security)

#### 6. **Code Quality**
- **Documentation**: Comprehensive API documentation
- **Code Generation**: Build runner for model serialization
- **CI/CD**: Automated testing and deployment
- **Analytics**: Crash reporting and usage analytics

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the code comments for implementation details

---

**Built with using Flutter and GetX**
