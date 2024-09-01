# Checklist to Pass App Review

@Metadata {
   @PageImage(purpose: icon, source: "FreemiumKit")
   @TitleHeading("FreemiumKit")
   @PageKind(article)
}

This checklist helps developers using FreemiumKit to navigate Apple's app review process for apps with in-app purchases (IAPs).

## Before Submission

1. **Set App Price to Free**
   - Navigate to "Pricing and Availability" in App Store Connect
   - Set app price to "0.00" / Free
   - Ensure availability for all desired countries

2. **Link IAPs/Subscriptions to Your Build**
   - In App Store Connect, go to your in-progress build
   - Find 'In-App Purchases and Subscriptions' section
   - Click 'Select In-App Purchases or Subscriptions'
   - Associate relevant products with your build

## Legal Compliance

1. **Accept Latest 'Paid Apps Agreement'**
   - Go to 'Business' tab in [App Store Connect](https://appstoreconnect.apple.com/business)
   - Accept the latest agreement

2. **Add Privacy Policy Link**
   - In App Store Connect: 
     - Go to your app's page > 'App Privacy'
     - Add Privacy Policy URL

3. **Set Up Privacy Labels in App Store Connect**
   - Go to your app's page > 'App Privacy'
   - Select "Purchases" for data types
   - Choose "Analytics" and "App Functionality" within "Purchases"
   - Answer subsequent questions with 'No' (we don't collect user-identifiable data)
   
   ![Purchase History Setup](AppPrivacy-Purchases)


4. **Include Apple's EULA in App Description**
   - Add this to your App Store description (all locales):
     ```
     ----- Legal Notice ----- 
     Terms of Use (EULA): https://www.apple.com/legal/internet-services/itunes/dev/stdeula/
     ```

5. **Link to Privacy & Terms in your App**

   - Within Your App:
     - Add a link for Privacy and Terms in settings menu or Help menu (Mac)
     - For iOS, example code:
       ```swift
       import SwiftUI

       struct SettingsView: View {
          @Environment(\.openURL) private var openURL

          var body: some View {
             Form {
                // ...
                #if !os(macOS)
                Section {
                   Button("Terms and Conditions", systemImage: "text.book.closed") {
                      self.openURL(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                   }
                   Button("Privacy", systemImage: "lock") {
                      self.openURL(URL(string: "https://www.fline.dev/app-privacy-analytics-en/")!)
                   }
                }
                #endif
             }
          }
       }
       ```
     - For macOS, example code:
       ```swift
       import SwiftUI

       @main
       struct YourApp: App {
          @Environment(\.openURL) private var openURL

          var body: some Scene {
             WindowGroup {
                // ...
             }
             #if os(macOS)
             .commands {
                CommandGroup(replacing: .help) {
                   Button("Terms and Conditions") {
                      self.openURL(URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                   }
                   Button("Privacy") {
                      self.openURL(URL(string: "https://www.fline.dev/app-privacy-analytics-en/")!)
                   }
                }
             }
             #endif
          }
       }
       ```
   
      > Note: You can optionally add these links to your paywall using "Auxiliary Buttons" in the FreemiumKit paywall editor, but it's not a requirement. They are only required directly within your app to ensure users can access them even without/before/after making a purchase.

## Transparent Communication

1. **Label Paid Features in App Description**

   - If you mention features that require payment, clearly indicate that in your description
   
2. **Label Paid Features in Screenshots and Previews**

   - If featuring premium content, add a label like "Premium Feature" / "Requires Subscription"
   - For app preview videos, add a text overlay when showing premium features

> Tip: If your app allows free access to one instance of a feature and requires payment for more, you might get away without mentioning in-app purchases at all. To be safe, mention that you have limited free content in your app and users need to pay for more.

## Conclusion

Following this checklist will help ensure a smoother app review process when using FreemiumKit for in-app purchases. Remember to thoroughly test your app before submission and stay updated with Apple's latest guidelines.

## Support

For questions or support, contact: [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev)

---

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}
