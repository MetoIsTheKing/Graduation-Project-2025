# flutter_stripe rules
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }
-keep class com.stripe.android.model.** { *; }
-keep class com.stripe.android.view.** { *; }
-keep class com.stripe.android.networking.** { *; }
-keep class com.stripe.android.payments.** { *; }
-keep class com.stripe.android.paymentsheet.** { *; }
-keep class com.stripe.android.link.** { *; }
-keep class com.stripe.android.financialconnections.** { *; }

# Rule for the react-native dependency referenced in your error log
-keep class com.reactnativestripesdk.** { *; }

# Required for Google Pay support
-keep class com.google.android.gms.wallet.** { *; }