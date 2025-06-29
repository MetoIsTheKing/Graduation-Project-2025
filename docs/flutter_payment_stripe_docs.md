# Flutter Flight Booking: Payment Integration Documentation

*Last Updated: June 29, 2025*

---

## 1. High-Level Overview

This document outlines the architecture and implementation of the payment processing flow for the flight booking application. The system uses a secure, backend-driven approach with Stripe as the payment provider.

The core principle is that the Flutter application **never** directly handles sensitive credit card information. The process is orchestrated through a series of secure API calls to our backend, which then communicates with Stripe.

### Architectural Flow

1.  **Booking Creation (Flutter -> Backend)**: The user finalizes flight details. The Flutter app sends a request to the backend to create a booking, receiving a unique `bookingId` in return. The booking's initial status is `pending`.

2.  **Payment Intent Creation (Flutter -> Backend -> Stripe)**: The Flutter app requests the backend to create a Stripe "Payment Intent." This is a record of the transaction. The backend communicates with Stripe and returns a unique `clientSecret` to the Flutter app.

3.  **Payment Collection (Flutter -> Stripe)**: The Flutter app uses the `flutter_stripe` SDK and the `clientSecret` to present Stripe's secure, pre-built payment sheet. The user enters their card details directly into this UI.

4.  **Payment Confirmation (Stripe -> Backend)**: After the user submits payment, Stripe processes it and sends a secure webhook notification to our backend. The backend verifies this webhook and updates the booking status in the database from `pending` to `confirmed`.

5.  **Status Verification (Flutter -> Backend)**: The Flutter app does not assume the payment was successful. Instead, it **polls** a backend endpoint, repeatedly asking for the booking status. Once the backend confirms the booking status is `confirmed`, the Flutter app navigates the user to a success screen.

---

## 2. Step-by-Step Flutter Implementation

The entire client-side process is managed using `flutter_bloc`, specifically a `BookingCubit` to handle state.

### 2.1: Initial Booking

-   **Action**: User confirms flight details.
-   **Logic**: Call the `bookFlight()` method in `BookingCubit`.
-   **API Call**: `POST /booking/create` (or similar).
-   **Result**: On success, the `bookingId` and `totalPrice` are stored in the `BookingCubit`. The user is navigated to the `PaymentScreen`.

### 2.2: Initiating the Payment Flow

-   **Action**: The `PaymentScreen` is loaded.
-   **Logic**: A `BlocProvider` is used to provide the `BookingCubit` to the `PaymentScreen`. We use the cascade operator (`..`) to call `createPaymentIntent()` immediately upon providing the cubit, ensuring it runs once while keeping the UI stateless.
    ```dart
    // In routing logic
    BlocProvider.value(
      value: getIt<BookingCubit>()..createPaymentIntent(),
      child: const PaymentScreen(),
    )
    ```
-   **API Call**: `POST /payment/create-payment-intent` with `bookingId`, `amount`, and `currency`.
-   **Result**: The `clientSecret` is received from the backend and stored in the `BookingCubit`. A `PaymentIntentSuccess` state is emitted.

### 2.3: Presenting the Stripe Payment Sheet

-   **Action**: The `PaymentScreen` listens for the `PaymentIntentSuccess` state.
-   **Logic**: A `BlocListener` on the `PaymentScreen` triggers the `_startPayment` function when the `clientSecret` is ready.
    ```dart
    // Inside PaymentScreen
    Future<void> _startPayment(BuildContext context, String clientSecret) async {
      try {
        await Stripe.instance.initPaymentSheet(...);
        await Stripe.instance.presentPaymentSheet();

        // After sheet closes, start polling
        context.read<BookingCubit>().startPaymentStatusPolling();
      } on StripeException catch (e) {
        // Handle Stripe-specific errors (e.g., card declined)
      }
    }
    ```

### 2.4: Polling for Backend Confirmation

-   **Action**: The Stripe sheet closes successfully.
-   **Logic**: The `startPaymentStatusPolling()` method is called in `BookingCubit`. This method uses a `Timer.periodic` to call a private `_checkPaymentStatus` function every 2 seconds.
-   **API Call**: The `_checkPaymentStatus` function repeatedly calls `GET /payment/status/{bookingId}`.
-   **Result**:
    -   If the API returns `"paymentStatus": "completed"`, the timer is cancelled, and a `PaymentPollingSuccess` state is emitted.
    -   If the API returns a different status, the timer continues.
    -   If 10 attempts are made (20 seconds), the timer is cancelled, and a `PaymentPollingFailure` state is emitted (timeout).
    -   The UI listens for these states to show a final success/failure message and navigate away.

---

## 3. Configuration & Setup

Proper native configuration is critical for `flutter_stripe` to function.

-   **Dependencies**: `flutter_stripe` and `flutter_dotenv` were added to `pubspec.yaml`.
-   **Environment Variables**: A `.env` file was created to store the `STRIPE_PUBLIC_KEY`. The secret key (`sk_...`) was explicitly kept out of the client-side code.
-   **`main.dart` Initialization**: Stripe is initialized before `runApp()` is called.
    ```dart
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY']!;
    await Stripe.instance.applySettings();
    runApp(const MyApp());
    ```

---

## 4. Common Errors Encountered & Solutions

During this implementation, we faced several configuration-related issues. This section documents them for future reference.

### 4.1. Kotlin Gradle Plugin Version Mismatch

> **Error Message**: `Your project requires a newer version of the Kotlin Gradle plugin.`

-   **Cause**: The `flutter_stripe` package required a newer version of the Kotlin Gradle Plugin (KGP) than was configured. We also used a very new Android Gradle Plugin (AGP) version (`8.8.0`), which had a strict requirement for its KGP counterpart.
-   **Solution**: We edited `android/settings.gradle` to align the plugin versions. The AGP version `8.8.0` required KGP version `2.0.0`.
    ```groovy
    // In android/settings.gradle
    plugins {
        id "com.android.application" version "8.8.0" apply false
        id "org.jetbrains.kotlin.android" version "2.0.0" apply false // Updated from 1.9.22
    }
    ```

### 4.2. MainActivity Not Extending `FlutterFragmentActivity`

> **Error Message**: `Your Main Activity class ... is not a subclass FlutterFragmentActivity.`

-   **Cause**: The `flutter_stripe` SDK needs the ability to display native Android UI fragments (like a web view for 3D Secure) over the Flutter view. This requires the main Android activity to be based on `FlutterFragmentActivity`.
-   **Solution**: We modified `android/app/src/main/kotlin/.../MainActivity.kt` to extend the correct class.
    ```kotlin
    // In MainActivity.kt
    import io.flutter.embedding.android.FlutterFragmentActivity // Changed import

    class MainActivity: FlutterFragmentActivity() { // Changed class
    }
    ```

### 4.3. Incorrect Android Theme

> **Error Message**: `Your theme isn't set to use Theme.AppCompat or Theme.MaterialComponents.`

-   **Cause**: Stripe's native UI components need to inherit from a modern Android theme to render correctly. The default Flutter theme was not compatible.
-   **Solution**: We updated the `NormalTheme` style in both `android/app/src/main/res/values/styles.xml` and `android/app/src/main/res/values-night/styles.xml` to inherit from a Material Components theme.
    ```xml
    <!-- In styles.xml -->
    <style name="NormalTheme" parent="@style/Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
    ```