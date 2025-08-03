# Flutter/Dart
-dontwarn io.flutter.embedding.**
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase Crashlytics
-keep class com.google.firebase.crashlytics.** { *; }
-keep class com.google.firebase.analytics.** { *; }
-dontwarn com.google.firebase.**

# Gson (لو بتستخدمه في models)
-keep class * implements com.google.gson.TypeAdapter
-keep class * implements com.google.gson.JsonDeserializer
-keep class * implements com.google.gson.JsonSerializer
-keepattributes Signature
-keepattributes *Annotation*

# Retrofit (لو موجود)
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**
-keepattributes Signature
-keepattributes Exceptions

# Needed for reflection
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}
