# My Mac app is crashing on start on TestFlight / during App Review – how to fix?

If your app crashes upon app start, it's likely that your app can't find the FreemiumKit SDK path. Learn how to fix your build settings.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Make sure that your `Runpath Search Paths` build setting in Xcode has both `@executable_path/Frameworks` and `@executable_path/../Frameworks` in it. If one is missing, the SDK binary won't be found.

## Full Answer

FreemiumKit ships with an SDK binary that is automatically copied & handled by Xcode. While everything should work out of the box for most users, in some cases (depending on which version of Xcode created your project) your build settings might not be set up correctly. You might not notice an issue during DEBUG builds, but when you archive your project and upload it to TestFlight or to the App Store, the build settings need to be correct.

The fix is very easy:

1. Select your app target in Xcode
1. Navigate to the "Build Settings" tab
1. In the top right 'Filter' search field, enter `runpath`
1. Double-click the `Runpath Search Paths` setting to reveal the list
1. Make sure both `@executable_path/Frameworks` and `@executable_path/../Frameworks` are in the list
1. If one of them is missing, add it by using the plus button in the bottom left corner of the modal

And that's it, this should ensure that your app searches for the FreemiumKit SDK on the right paths and fix any app start issues. You can archive and upload a new build and everything should work on TestFlight / App Store.

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
