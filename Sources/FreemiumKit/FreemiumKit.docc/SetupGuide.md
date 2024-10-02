# SDK Setup Guide

Learn how to set up your app for our paywalls and live push notifications.

@Metadata {
   @PageImage(purpose: icon, source: "FreemiumKit")
   @TitleHeading("FreemiumKit")
   @PageKind(article)
   @CallToAction(url: "https://www.youtube.com/watch?v=6JxwA3WieHs", purpose: link, label: "Detailed Setup Video (17 min)")
}

## Adding the SDK

1. Open your app project in Xcode.

2. In the "File" menu select "Add Package Dependencies…"
   
   @Image(source: "Setup-Add-Dependency")

3. Paste this to the top right text field and press "Add Package":
   ```
   https://github.com/FlineDev/FreemiumKit.git
   ```

   @Image(source: "Setup-Add-Package")

4. Select your app target (if not already selected) and confirm by pressing "Add Package"
   
   @Image(source: "Setup-Choose-Package")


## Configuring the SDK

> Tip: Don't forget to `import FreemiumKit` for any of the below calls to build.

1. Make sure your app's Asset Catalog contains the `FreemiumKit` data set from the "Setup" tab of your app in FreemiumKit for Mac. If it doesn't, drag & drop it from the Setup tab now.

1. Add a call to `.environmentObject(FreemiumKit.shared)` to the root view of every scene in the app entry point. For example:

   ```swift
   import FreemiumKit

   @main
   struct MyApp: App {
      var body: some Scene {
         WindowGroup {
            MainView()
               .environmentObject(FreemiumKit.shared)
         }
      }
   }
   ```
   
> Tip: If you want to disable the paywall during DEBUG builds after you've made sure that it works as expected, you can call `.overrideForDebug` on `FreemiumKit.shared` within an `#if DEBUG` check like this:
>
> ```swift
> WindowGroup {
>    MainView()
>       .onAppear {
>          #if DEBUG
>          FreemiumKit.shared.overrideForDebug(purchasedTier: 1)
>          #endif
>       }
>       .environmentObject(FreemiumKit.shared)
> }
> ```

## Understanding Apples Tier System

If your goal is to ship your app with any combination of Monthly, Yearly, and Lifetime purchases, you most likely only need one tier: Tier 1. Just pass `1` for the `purchasedTier` parameter everywhere or don't pass any, `1` is the default value – easy. Continue to the next section.

But if you want to support multiple levels of access to your app, like a combination of Monthly/Yearly/Lifetime for the 'Pro' level, another combination of Monthly/Yearly/Lifetime for the 'Max' level, and maybe another combination of Monthly/Yearly/Lifetime for the 'Ultra' level, that's when you need to think about which value to pass to the `purchasedTier` parameter. Note that `1` always refers to the highest level. That's how Apple has decided their tier system to work. Read their [official docs](https://developer.apple.com/help/app-store-connect/manage-subscriptions/offer-auto-renewable-subscriptions) to learn more.

## Showing the Paywalls

@Video(poster: "PaidViews-Poster", source: "PaidViews")

1. Lock your paid features for users who have not made a purchase yet by using one of the built-in views `PaidFeatureButton` or `PaidFeatureView`. This is the recommended way of using the SDK (when applicable) as it handles purchase states automatically for you and saves you a lot of boilerplate code. For example:

   ```swift
   // opens paywall if user has not purchased, else just like `Button`
   PaidFeatureButton("Export", systemImage: "square.and.arrow.up") {
      // your export logic – no check for a paid tier needed, only called if already purchased 
   }

   // exactly the same as above, but gives you full customizability
   PaidFeatureView {
      Button("Export", systemImage: "square.and.arrow.up") {
         // your export logic – no check for a paid tier needed, only called if already purchased
      }
   } lockedView: {
      Label("Export", systemImage: "lock")
   }
   ```

   Both `PaidFeatureButton` and `PaidFeatureView` accept an `unlocksAtTier` parameter of type `Int` (default: `1`) and a `showPaywallOnPressIfLocked` parameter of type `Bool` (default: `true`).

   If you don't pass any of those parameters, the default behavior unlocks the feature only if tier 1 is purchased and shows a paywall on press if tier 1 is not yet purchased. If `showPaywallOnPressIfLocked` is set to `false`, the locked view will not have any automatic interaction, just rendering locked view state as-is without any added behavior.

   > Note: If you place `PaidFeatureButton` or `PaidFeatureView` inside a view that self-dismisses itself after any interaction (like in a `Menu`), the paywall might not show because SwiftUI deinitializes the view and attached logic before it can be executed. Use the below method in such contexts and place the `.paywall` modifier at the root of your view to avoid auto-deinit.

1. Alternatively, if you want to control the presentation of the paywall manually, you can add the `.paywall(isPresented:)` modifier to your custom views where needed. For example:

   ```swift
   import FreemiumKit

   struct MyView: View {
      @State var showPaywall: Bool = false

      var body: some View {
         Button("Unlock Pro") {
            showPaywall = true
         }
         .paywall(isPresented: $showPaywall)
      }
   }
   ```

   If you want to conditionally hide views based on paid state (like hiding the unlock button if a user has already purchased), you can add the `FreemiumKit` object as an `@EnvironmentObject` and call `.purchasedTier` or `.hasPurchased` if you only have one tier like so:

   ```swift
   import FreemiumKit

   struct MyView: View {
      @EnvironmentObject var freemiumKit: FreemiumKit
      @State var showPaywall: Bool = false

      var body: some View {
         if freemiumKit.purchasedTier == nil {
            Button("Unlock Pro") {
               showPaywall = true
            }
            .paywall(isPresented: $showPaywall)
         }
      }
   }
   ```

   If you want to show the paywall upon appearance of a view if a user has not paid, you should first check that the `purchasesLoaded` property of `FreemiumKit` is `true` – or else paying users might see the paywall, too. Since this is a common use case, our SDK ships with the `.onPurchasesLoaded` view modifier which is guaranteed to be called exactly once (like `.onAppear`) but only when purchases are loaded:

   ```swift
   import FreemiumKit

   struct MyView: View {
      @State var showPaywall: Bool = false

      var body: some View {
         VStack {
            // your view ...
         }
         .paywall(isPresented: $showPaywall)
         .onPurchasesLoaded {
            if !FreemiumKit.shared.hasPurchased {
               showPaywall = true
            }
         }
      }
   }
   ```

1. There's also a `PaidStatusView` which you can add to your app's settings to indicate to users what their current purchase state is. There are two styles:

   ```swift
   PaidStatusView(style: .plain)
   PaidStatusView(style: .decorative(icon: .laurel))
   ```

   @Image(source: "Setup-PaidStatusView")

   The `.decorative` style has multiple `icon` parameter options and also accepts optional `foregroundColor` and `backgroundColor` parameters if you need to adjust the defaults. Note that the `PaidStatusView` will automatically open a paywall on press if there's no purchase yet. Else, it's rendered as just a label without interaction.

   If you place it inside a `Form` with `Sections`, you might want to set the `listRowBackground` for a clean look like this:

   ```swift
   Form {
      Section {
         PaidStatusView(style: .decorative(icon: .laurel))
            .listRowBackground(Color.accentColor)
            .padding(.vertical, -10)
      }
      
      // ...
   }
   ```

> Tip: We prepared a <doc:AppReviewChecklist> you will find useful, especially if this is the first time you're publishing an app with In-App Purchases.

## `@EnvironmentObject` vs `FreemiumKit.shared`

Sometimes we were using `FreemiumKit.shared` and sometimes `@EnvironmentObject var freemiumKit: FreemiumKit`. They both actually refer to the exact same Singleton instance. So you might ask yourself: _**When to use which?**_

The answer is simple: Whenever you are in a **SwiftUI view** and you want your view to **automatically update** based on the purchase state, you should use `@EnvironmentObject`. This will ensure that the SwiftUI rendering picks up changes to the purchase state and refreshes your UI accordingly.

Everywhere else, you can use `FreemiumKit.shared`. For example in your model layer, your user-intitiated functions, or even in one-off modifiers in your views like in `onAppear`. 


## SwiftUI Previews

For SwiftUI previews to work where you make use of the built-in views or modifier, add a call to `.environmentObject(FreemiumKit.preview)` in your preview code like so:

```swift
#Preview {
   YourView()
      .environmentObject(FreemiumKit.preview)
}
```

If you want to simulate a specific paid state in your previews, you can call the `withOverridesForDebug(purchasedTier:)` function on `FreemiumKit.preview` and set your desired tier (set `1` for full access). The default `FreemiumKit.preview` shows in the "nothing purchased" state, showcasing how things will look from a Free users perspective. For example:

```swift
#Preview("Full Access") {
   YourView()
      .environmentObject(FreemiumKit.preview.withOverridesForDebug(purchasedTier: 1))
}
```

> Note: The paywall UI you will see in SwiftUI previews will not reflect your custom paywall UI due to previews being rendered outside your apps lifecycle. Run your app on device or simulator to see your own paywall. 

## Direct Access to StoreKit Transactions

In some advanced use cases, you might want to directly access the transactions reported by `StoreKit` which our SDK is already subscribed to. You can easily get all valid transactions by calling `FreemiumKit.shared.purchasedTransactions` or even subscribe and react to changes in your SwiftUI views:

```swift
import FreemiumKit

struct MyView: View {
   @EnvironmentObject var freemiumKit: FreemiumKit

   var body: some View {
      MyView()
         .onChange(of: self.freemiumKit.purchasedTransactions) {
            for transaction in self.freemiumKit.purchasedTransactions {
               // do something with the `StoreKit.Transaction`
            }
         }
   }
}
```

If all you need to know is _which_ of your in-app purchases/subscriptions the user has purchased, there's a much easier way to get the ID of the product (e.g. `YourApp.Pro.Monthly`):

```swift
FreemiumKit.shared.purchasedProductID  // returns a `String?`
```

If all you need is to **get notified** when a user just made a purchase (e.g. to report to analytics or show some kind of confetti effect), use the built-in `.onPurchaseCompleted` modifier which has the purchased `transaction` available with all the StoreKit details if needed:

```swift
import FreemiumKit

@main
struct MyApp: App {
   var body: some Scene {
      WindowGroup {
         MainView()
            .onPurchaseCompleted { transaction in
               // show confetti or report transaction details to analytics
            }
            .environmentObject(FreemiumKit.shared)
      }
   }
}
```

[🏠 Back to Home](https://freemiumkit.app)

## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}
