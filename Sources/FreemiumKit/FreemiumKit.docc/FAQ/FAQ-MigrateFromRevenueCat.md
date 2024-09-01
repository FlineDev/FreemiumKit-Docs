# I use RevenueCat, how can I migrate?

See how easy it is to migrate from RevenueCat with our detailed migration guide – takes only ~30 minutes (including read time). And learn about some limitations we currently have.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Migrating from RevenueCat involves the following steps (outlined in detail below):

1. Set up your app & existing purchases in the FreemiumKit app (5 min)
1. Integrate the FreemiumKit SDK into your app & configure it (5 min)
1. Replace RevenueCat SDK calls with FreemiumKit calls (10-15 min)
1. Remove the RevenueCat SDK integration from your app (5 min)
1. Adjust the Paywall UI in FreemiumKit to your liking (5 min)

Current limits: You can't select products for the paywall at this moment – all of them are automatically shown. (This limitation will be fixed in a future version.)

## Full Answer

### Step 1: Set up your app & purchases in FreemiumKit (5 min)

1. Download FreemiumKit and follow the simple instructions to connect to your App Store account if you're starting it for the first time. This should take less than a minute.

2. Now, press the + button at the top of the left sidebar and select the app you want to migrate and press "Add Project".

3. Navigate to your apps "Products" tab and make sure that all purchases are listed there and have the correct tier set. Subscription tiers are detected automatically, but if you have a Lifetime Purchase, FreemiumKit can't auto-detect the tier, so you need to press "Mark as Lifetime for Tier…" and select the right tier (most likely 'Tier 1').

4. Open the 'Setup' tab and drag & drop the config icon on the right to your apps' Asset Catalog.

### Step 2: Integrate FreemiumKit SDK & configure it (5 min)

For this step, simply follow the 'Adding the SDK' and 'Configuring the SDK' sections of the <doc:SetupGuide> – feel free to also read the rest of the guide to get a better understanding of the next step!

### Step 3: Replace RevenueCat SDK with our SDK calls (10-15 min)

If you've been using RevenueCat with your own paywall UIs, we have good news because you no longer need to maintain your paywall code that loads 'offerings' and displays them – we all handle this for you!

If this is the case, then somewhere in your project you're checking if the current user has access to your paid features with either the async/await call or the completion call below:

```swift
// async/await call
let customerInfo = try await Purchases.shared.customerInfo()

// 
Purchases.shared.getCustomerInfo { (customerInfo, error) in
    // access latest customerInfo
}
```

A quick search for `Purchases.shared.customerInfo()` and `Purchases.shared.getCustomerInfo` should reveal these places. You'll have some logic based on `customerInfo` instance details that either gives the user access to your paid features or shows your paywall.

This logic can be completely replaced by one of our 3 APIs explained in the 'Showing the Paywalls' section in our <doc:SetupGuide>:

1. Use `PaidFeatureButton` or `PaidFeatureView` for buttons or custom views that should only work for paying customers. Both of these views will automatically show our built-in paywall if the user didn't purchase the required paid tier yet. These are the easiest and therefore recommended APIs for most cases – and thanks to `PaidFeatureView` they're quite flexible.

2. You can also use the `.paywall(isPresented:)` SwiftUI modifier with a custom check for the `purchasedTier` property of `@EnvironmentObject var freemiumKit: FreemiumKit` added to your SwiftUI view(s). This is more similar to how the RevenueCat SDK works with either the manual paywall or their bult-in iOS paywalls, but we still provide the paywall UI for you. This requires more code on your end, but also gives you more control if needed.

3. Our `PaidStatusView` is a special view that we pepared for use in places where you want to simply indicate the current paid status of the user. This is a common need in the settings screen of an app and usually inside a `Form` or `List` view. We recommend adding it if you don't have such a place yet as this serves also as a reminder for Free users that you have paid features they might be interested in.

If you need global access to the current user's purchase status, you can call `FreemiumKit.shared.purchasedTier` from anywhwere in your app (e.g. in your models).

Make sure your project builds before moving on to the next step.

### Step 4: Remove the RevenueCat SDK integration (5 min)

Once you migrated all your code over to FreemiumKit, you can remove the RevenueCat SDK from your project. Once the dependency is removed, build your project to find places where you still are importing the RevenueCat SDKs and where you configuried it (probably in your app entry point). Remove the configuration code and all import statements. Your project should build now and the technical part of the migration process is completed! Feel free to commit. 🎉

> Tip: While FreemiumKit is much more convenient to use than RevenueCat overall (less clicks, less code, more "built-in" stuff like localization), services like RevenueCat have been around for longer and excel at other areas like integrations with other services. If you want to keep using RevenueCat for these benefits, just put their SDK to "Observer mode" rather than removing it entirely: [Learn more](https://www.revenuecat.com/docs/migrating-to-revenuecat/sdk-or-not/finishing-transactions).

### Step 5: Adjust the Paywall UI in FreemiumKit (5 min)

While at this point your app is already fully migrated to FreemiumKit, you might want to open the FreemiumKit app, select your project and open the 'Paywalls' tab.

Here you can see a preview of your paywall and adjust it with many configuration options. Feel free to play around with the options until you're happy with the results and don't forget to press 'Save Changes to Remote' at the end.

You might also want to optionally delete the 'FreemiumKit' config file from your Asset Catalog and drag & drop the now adjusted config file from the 'Setup' tab. This will make sure your adjustments are also available in case the remote config file can't be loaded on the users devices, where FreemiumKit will fall back to the local file included in the Asset Catalog.

### Current Limitations

If you have created more products on App Store Connect than you want to show in your paywall, you might want to wait until we have implemented a product selection for paywalls in a future version.

For example, if you have a Weekly, a Monthly, a Yearly, and a Lifetime purchase on Connect (and all of them are approved), then they all will be shown in our paywalls. If you want to exclude e.g. the Weekly purchase from your paywall, that's currently not supported.

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
