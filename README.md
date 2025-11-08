# Product Quote Builder

A professional Flutter application for creating product quotations with real-time calculations, BLoC state management, and responsive design.

## 📱 Features

### Core Features
- **Dynamic Quote Creation**: Add and manage multiple line items with ease
- **Client Information Management**: Store client name, address, and project reference
- **Real-time Calculations**: Automatic calculation of subtotals, taxes, and grand totals
- **Responsive Design**: Seamlessly adapts to mobile, tablet, and desktop screens
- **Professional Preview**: Print-ready quote layout with clean formatting

### Advanced Features
- **Tax Mode Toggle**: Switch between tax-inclusive and tax-exclusive calculations
- **Quote Status Tracking**: Track quotes through Draft, Sent, and Accepted stages
- **Currency Formatting**: Professional INR currency display with proper formatting
- **Save & Send Simulation**: Mock save and email functionality for demonstration
- **Dynamic Line Items**: Add/remove products with independent calculations

## 🏗️ Architecture

### State Management
- **BLoC Pattern**: Clean separation of business logic and UI
- **Events**: User actions are dispatched as events
- **States**: Immutable state management with Equatable
- **Bloc**: Processes events and emits new states

### Project Structure
```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── client_info.dart              # Client data model
│   ├── line_item.dart                # Line item model with calculations
│   └── quote.dart                    # Quote model with business logic
├── bloc/
│   ├── quote_bloc.dart               # BLoC implementation
│   ├── quote_event.dart              # Event definitions
│   └── quote_state.dart              # State definitions
├── screens/
│   ├── quote_form_screen.dart        # Main form screen
│   └── quote_preview_screen.dart     # Preview screen
├── widgets/
│   ├── client_info_section.dart      # Client info form
│   ├── line_item_row.dart            # Individual line item
│   ├── quote_summary.dart            # Summary card
│   └── preview_card.dart             # Preview layout
└── utils/
    ├── currency_formatter.dart       # Currency formatting utilities
    └── calculations.dart             # Calculation helpers
```

##  Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

### Installation

1. **Clone or download the project**
   ```bash
   cd product_quote_builder
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3        # State management
  equatable: ^2.0.5           # Value equality
  intl: ^0.18.1              # Internationalization and formatting

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0       # Linting rules
```

## 💡 Usage

### Creating a Quote

1. **Enter Client Information**
    - Fill in client name, address, and reference/project details

2. **Add Line Items**
    - Click "Add Item" or use the floating action button
    - Enter product/service name
    - Specify quantity, rate, discount, and tax percentage
    - Each item's total is calculated automatically

3. **Review Summary**
    - View real-time subtotal, tax total, and grand total
    - Toggle between tax-inclusive and tax-exclusive modes

4. **Preview Quote**
    - Click the "Preview" floating action button
    - View professional quote layout
    - Change quote status (Draft/Sent/Accepted)
    - Simulate save or send actions

### Calculations

The app uses the following calculation logic:

```dart
Item Subtotal = (Rate - Discount) × Quantity
Item Tax = Item Subtotal × (Tax % ÷ 100)
Item Total = Item Subtotal + Item Tax

Quote Subtotal = Sum of all Item Subtotals
Quote Tax Total = Sum of all Item Taxes
Grand Total = Quote Subtotal + Quote Tax Total
```

## 📱 Responsive Behavior

### Mobile (< 600px)
- Stacked layout with full-width cards
- Line items display in card format with vertical fields
- Buttons stack vertically

### Tablet (600px - 900px)
- Mixed layout optimizing space
- Line items in horizontal rows
- Side-by-side buttons

### Desktop (> 900px)
- Two-column layout: form on left, summary on right
- Table-style line items
- Wide preview layout

## 🎨 Key Components

### Models
- **ClientInfo**: Stores client details with immutability
- **LineItem**: Represents a product/service with built-in calculations
- **Quote**: Main model containing client info, items, status, and tax mode

### BLoC Events
- `UpdateClientInfo`: Updates client details
- `AddLineItem`: Adds a new line item
- `RemoveLineItem`: Removes a line item
- `UpdateLineItem`: Updates line item values
- `ToggleTaxMode`: Switches tax calculation mode
- `UpdateQuoteStatus`: Changes quote status
- `ResetQuote`: Clears all data

### Widgets
- **ClientInfoSection**: Reusable client info form
- **LineItemRow**: Adaptive line item with mobile/desktop layouts
- **QuoteSummary**: Real-time summary card
- **PreviewCard**: Professional print-ready quote display

## 🔧 Customization

### Currency Symbol
Edit `utils/currency_formatter.dart`:
```dart
static final NumberFormat _formatter = NumberFormat.currency(
  symbol: '₹',  // Change to $, €, etc.
  decimalDigits: 2,
);
```

### Theme Colors
Edit `main.dart`:
```dart
theme: ThemeData(
  primarySwatch: Colors.blue,  // Change primary color
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,    // Change accent color
  ),
),
```

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## 📸 Screenshots

The app includes:
- Clean form interface with intuitive controls
- Real-time calculation display
- Professional preview layout
- Status tracking with visual indicators
- Fully responsive design across all devices

## 🤝 Contributing

Contributions are welcome! This project was built for a technical assessment.

## 📄 License

This project is created for educational and assessment purposes.

## 👨‍💻 Developer

**Nibin Joseph**
- Email: nibin.joseph.career@gmail.com
- Position Applied: Flutter Developer
- Company: Meru Technosoft

## 🎯 Assignment Requirements Met

-  Dynamic line items with add/remove functionality
-  Responsive layout for all screen sizes
-  Real-time business logic calculations
-  Professional B2B tool UI organization
-  BLoC state management implementation
-  Clean code structure and component separation
-  Tax-inclusive/exclusive mode (Bonus)
-  Currency formatting (Bonus)
-  Save/Send simulation (Bonus)
-  Quote status tracking (Bonus)

## 📝 Notes

- No external API integration (local app as required)
- All data is stored in memory during the session
- Currency formatting uses Indian Rupee (₹) by default
- Material Design 3 principles applied throughout
- No comments in code for production-ready cleanliness