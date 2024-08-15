# SDK Setup Guide

Learn how to set up your app for our paywalls and live push notifications.

@Metadata {
   @PageImage(purpose: icon, source: "FreemiumKit")
   @TitleHeading("FreemiumKit")
   @PageKind(article)
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

1. Add a call to `.environmentObject(FreemiumKit.shared)` to every scene in the app entry point. For example:

   ```swift
   import FreemiumKit

   @main
   struct MyApp: App {
      var body: some Scene {
         WindowGroup {
            MainView()
         }
         .environmentObject(FreemiumKit.shared)
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
> }
> .environmentObject(FreemiumKit.shared)
> ```

## Understanding Apples Tier System

If your goal is to ship your app with any combination of Monthly, Yearly, and Lifetime purchases, you most likely only need only one tier: Tier 1. Just pass `1` for the `purchasedTier` parameter everywhere – easy. Continue to the next section.

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

   If you want to conditionally hide views based on paid state (like hiding the unlock button if a user has already purchased), you can add the `FreemiumKit` object as an `@EnvironmentObject` and call `.purchasedTier` (or `.hasPurchased` if you only have one tier) like so:

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

   If you want to show the paywall right upon appearance of a view, you should additionally check for the `purchasesLoaded` property of the environment object like so:

   ```swift
   import FreemiumKit

   struct MyView: View {
      @EnvironmentObject private var freemiumKit: FreemiumKit
      @State var showPaywall: Bool = false

      var body: some View {
         VStack {
            // your view ...
         }
         .paywall(isPresented: $showPaywall)
         .onAppear {
            if freemiumkit.purchasesLoaded, freemiumkit.purchasedTier == nil {
               showPaywall = true
            }
         }
         .onChange(of: freemiumKit.purchasesLoaded) {
            if freemiumkit.purchasesLoaded, freemiumkit.purchasedTier == nil {
               showPaywall = true
            }
         }
      }
   }
   ```

   Note that you can also access the `FreemiumKit` object from your models globally by calling `FreemiumKit.shared`. But in your SwiftUI views you should use the `@EnvironmentObject` so your views get updated correctly.

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
      }
      
      // ...
   }
   ```


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


## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}
