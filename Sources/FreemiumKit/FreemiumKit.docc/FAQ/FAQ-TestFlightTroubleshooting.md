# Products not showing up in TestFlight builds?

Learn how to fix common issues when your in-app purchases or subscriptions don't appear in TestFlight builds of your app.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

If products aren't showing up in TestFlight, check these common issues:
1. Complete all App Store Connect setup including [Agreements, Tax, and Banking info]((https://appstoreconnect.apple.com/business/))
2. Verify products are properly linked to your TestFlight build
3. Use StoreKit Testing for more reliable purchase testing

## Full Answer

When testing in-app purchases through TestFlight, there are several common pitfalls that can prevent your products from appearing properly. Here's how to diagnose and fix them:

### 1. Complete App Store Connect Setup

A common issue that's not immediately obvious: You need to complete all App Store Connect setup sections before products will work in TestFlight, including:
- [Paid Apps Agreement](https://appstoreconnect.apple.com/business/) (needs to be accepted)
- Tax Information
- Banking Information

Even for closed beta testing where no real transactions will occur, this information must be filled out. This requirement isn't clearly documented by Apple but is essential for the StoreKit infrastructure to work properly in TestFlight builds.

### 2. Verify Build Configuration

Make sure that:
- Your products are properly linked to your TestFlight build (see our <doc:AppReviewChecklist> for detailed steps)
- The FreemiumKit configuration file is included in your Asset Catalog
- The bundle ID matches your App Store Connect configuration

### 3. Use StoreKit Testing

TestFlight can sometimes behave unpredictably with purchases, such as:
- Not reporting purchases properly to the app
- Resetting purchase states unexpectedly
- Showing inconsistent product availability

For more reliable testing, we strongly recommend using StoreKit Testing in Xcode. It provides a more accurate simulation of how purchases will behave in production. You can set up StoreKit Testing configuration files in Xcode and test purchases without needing App Store Connect approval.

> Tip: If everything works properly with StoreKit Testing but not in TestFlight, it's likely an App Store Connect configuration issue rather than a code problem.

### 4. Common Error Cases

If you see these symptoms:
- Empty product list in TestFlight
- Products visible locally but not in TestFlight
- "Cannot connect to App Store" errors

First check the App Store Connect setup completion, particularly the Paid Apps Agreement, Tax, and Banking sections. These are the most common root causes of product visibility issues in TestFlight builds.

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
