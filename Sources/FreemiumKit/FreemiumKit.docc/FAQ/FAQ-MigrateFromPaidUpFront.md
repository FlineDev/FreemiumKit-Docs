# My app is paid-up-front. How can I make it Freemium?

See how easy it is to migrate from a paid-up-front app to a Freemium model using FreemiumKit, while preserving access to your app for those who already purchased.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Our SDK uses Apples [built-in solution](https://developer.apple.com/documentation/storekit/supporting_business_model_changes_by_using_the_app_transaction) in StoreKit to determine users who purchased your paid app before your migrated it to the Freemium model. And for new users, it works normally. You just need to tell our SDK which was the last paid version and build number calling `FreemiumKit.shared.lastBuildReleasedAsPaidApp(version:build:)`.

> Warning: Apple has introduced the `AppTransaction` API for this purpose in 2022 with iOS 16. Therefore, this guide only works if you target your _new_ Freemium app version to iOS 16 (or macOS 13, tvOS 16, watchOS 9) or later. 


## Full Answer

### Step 1: Set up FreemiumKit like normally

Add your app inside the FreemiumKit app and follow all instructions to set up your app for In-App Purchases like you would normally do (see Setup tab inside the Mac app). Just act like your app is already free to use and make sure to lock any features you want to hide behind paid tiers using the SDK features from our <doc:SetupGuide>.

### Step 2: Tell our SDK the last paid version

In order to continue giving users who had already purchased your app previously full access to your apps features, you need to tell our SDK which was the last version and build number sold as a paid-up-front app. Our SDK will then use Apples [built-in solution](https://developer.apple.com/documentation/storekit/supporting_business_model_changes_by_using_the_app_transaction) in StoreKit to automatically detect those users for you, there's nothing else you need to do. Just call this, e.g. in your app entry point:

```swift
import FreemiumKit

@main
struct AwesomeApp: App {
   init() {
      FreemiumKit.shared.lastPaidRelease(version: "1.5.1", buildNum: 25)
   }

   // ...
}
```

> Warning: The `AppTransaction` API Apple offers to detect the first downloaded app version returns the version (e.g. `1.5.1`) on the macOS platform but the build number (e.g. `25`) on all other platforms, including iOS. But only on macOS of all platforms (where it's not relevant) Apple requires new versions to have a _higher_ build number, but not on iOS, for example. As long as you increase the version number (e.g. from `1.5.1` to `1.5.2`) you can always go back to build number `1` even if you were at build `25` in version `1.5.1`.
>
> So for this check to work, make sure to **always** increase your build number from now on if you haven't already. Also, if you had been resetting your build number to `1` in the past, make sure to pass the highest build number you've ever shipped your app with when calling `lastPaidRelease(version:buildNum:)` and start with the next number for your future releases. E.g. if `5` was your latest released build number, but you had a version with build `25` in the past, pass `25` for the `buildNum` and start your build number at `26` for your next release.

### Step 3: Submit a new version & make your app free

Once everything is ready and tested, submit your app to the App Store and set it to "Manually release this version". Once your update is approved, release your version and immediatelz after that set your app pricing to "Free". This will ensure that no one can download your previous (paid) version for free but also no one has to pay for the new Freemium version. The order is important here.

Thats't it, you successfully migrated your paid app to the Freemium model!

## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}