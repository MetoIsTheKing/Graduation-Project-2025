# Keep all classes related to the core Stripe SDK and its interfaces
-keep class com.stripe.** { *; }
-keep interface com.stripe.** { *; }

# Keep all classes related to the react-native-stripe SDK wrapper and its interfaces
-keep class com.reactnativestripesdk.** { *; }
-keep interface com.reactnativestripesdk.** { *; }

# Required for Google Pay
-keep class com.google.android.gms.wallet.** { *; }

# New rules to suppress the specific warnings
-dontwarn com.reactnativestripesdk.**
-dontwarn com.stripe.android.pushProvisioning.**