-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
-dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider

# Example to keep all members of a class
-keep class com.example.your_app.** { *; }

# Example to keep a specific class
-keep class com.example.your_app.SomeClass

# Example to keep all classes that extend a specific class
-keep class * extends com.example.your_app.BaseClass
