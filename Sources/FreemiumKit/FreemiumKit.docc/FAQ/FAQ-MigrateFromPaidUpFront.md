# My app is paid-up-front. How can I make it Freemium?

See how easy it is to migrate from a paid-up-front app to the Freemium model using FreemiumKit, while preserving access to your app for those who already purchased.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Our SDK uses Apples [built-in solution](https://developer.apple.com/documentation/storekit/supporting_business_model_changes_by_using_the_app_transaction) in StoreKit to determine users who purchased your paid app before you migrated it to the Freemium model. And for new users, it works normally. You just need to tell our SDK which was the last paid version and build number like this:

```swift
FreemiumKit.shared.lastPaidRelease(version: "1.5.1", build: 25)
```


## Full Answer

Read our full guide here:

@Links(visualStyle: list) {
   - <doc:MigrateFromPaid>
}



## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}
