# How can I apply my custom server-side limits?

Learn how you can recognize a purchased user across app installs and devices to roll your own server-side logic for custom limits.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

FreemiumKit uses the built-in `appDeviceToken` in StoreKit 2 to recognize the same user across app installs and devices. You can access it from the `FreemiumKit` instance either using the `@EnvironmentObject` method or globally via `FreemiumKit.shared.appDeviceToken`.

## Full Answer

If you have your own server-side logic for locking/unlocking functionality based on usage (such as '100 posts per month'), you will want to identify the same user across app installs or devices. To do this, you can access `appAccountToken` on the `FreemiumKit` environment object which will return a `UUID` stored right within StoreKit (so Apple makes sure you recognize the same user across devices – we don't store that data on our servers).

Access the field after purchases are loaded like so:

```swift
import FreemiumKit

struct MyView: View {
   @EnvironmentObject private var freemiumKit: FreemiumKit

   var body: some View {
      VStack {
         // your main view ...
      }
      .onPurchasesLoaded {
         let appAccountToken: UUID = freemiumKit.appAccountToken
         // do something with the app account token
      }
   }
}
```

You can also access it globally via `FreemiumKit.shared.appAccountToken` but make sure that `FreemiumKit.shared.purchasesLoad` is `true`, else you won't get the correct `UUID`. Note that FreemiumKit loads this data upon app start and caches it, so most of the time it should be available.

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
