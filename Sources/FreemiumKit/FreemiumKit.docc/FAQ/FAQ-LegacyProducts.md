# How can I disable old products without customers losing access?

Learn how FreemiumKit allows you to mark purchases as 'legacy' and how the SDK ensures existing customers can continue to use your app as expected.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Disabling products without users losing access involves three steps:

1. Disable the checkmark for your legacy product in the "Products" tab within FreemiumKit.
2. Press on "Save Changes to Remote" on the "Paywalls" tab within FreemiumKit to save the changes.
3. Upon your apps' start, call `FreemiumKit.shared.legacyProductsIDsByTier` on the SDK to mark products as legacy while specifying their access level.

## Full Answer

Once purchases are created, submitted, and approved on the App Store, you no longer can rename their product ID or safely delete them without losing paying customers. So if you want to "clean up" your products for whatever reasons, it's a good idea to keep the existing products on App Store Connect.

With FreemiumKit, it's easy to mark products you had created in the past as "legacy". First, you need to do some setup within the FreemiumKit app:

1. For each product you want to mark as "legacy", uncheck the checkbox in front of the product in the "Products" tab.
2. Press on "Save Changes to Remote" on the "Paywalls" tab.

This makes sure that your legacy products are no longer shown in the paywall. But it doesn't give your users access to the features they already paid for.

For that, you need to additionally make a call on app start using the FreemiumKit SDK like so:

```swift
@main
struct YourApp: App {
   init() {
      FreemiumKit.shared.legacyProductsIDsByTier = [
         1: [
            "Premium.Weekly",
            "Premium.Weekly.Alternative",
            "Premium.Monthly.Alternative",
            "Premium.Yearly.Alternative",
            "Premium.Lifetime.Alternative",
         ]
      ]
   }

   // ...
}
```

This makes sure any existing customers who purchased the no longer sold `Premium.Weekly` product still have access to the features of tier 1.

> Tip: The App Store Review team may get confused when you submit new products with an app update but your paywall doesn't include your old products. Make sure to explain in your review notes that you are no longer selling the old products (you might even rename them by adding the suffix "- Legacy" on Connect) but existing customers will continue to have access.

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
