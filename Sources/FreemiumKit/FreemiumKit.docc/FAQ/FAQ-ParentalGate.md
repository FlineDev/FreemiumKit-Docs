# Are 'Made for Kids' apps supported with a Parental Gate?

Learn how to use our built-in parental gate for apps 'Made for Kids' to comply with Apples guidelines and avoid accidental purchases by small children. 

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

Yes, the FreemiumKit SDK ships with a built-in parental gate. Just call `FreemiumKit.shared.enableParentalGate(options:)` upon app start.

## Full Answer

We've built a simple math-based parental gate that will ask a random multiplication question with numbers from 2 to 10. This should be easy enough for any parent to solve, but tricky enough to avoid small children (6 or younger) accidentally getting into the paywall, as required by the [App Store guidelines](https://developer.apple.com/app-store/review/guidelines/#kids-category) for apps in the Kids category.

Just tell our SDK that it should use a parental gate before showing the paywall upon app start, like this:

```swift
import FreemiumKit

@main
struct AwesomeApp: App {
   init() {
      FreemiumKit.shared.enableParentalGate(options: ParentalGateOptions())
   }
}
```

This single line will already work! 🎉 But it will use the default system colors (black/white/accent) which can look off.

You probably want to customize the parental gate to look nicer to fit your apps playful color scheme, like this:

```swift
import FreemiumKit

@main
struct AwesomeApp: App {
  init() {
    FreemiumKit.shared.enableParentalGate(
      options: ParentalGateOptions(
         background: .linearGradient(
            LinearGradient(
               gradient: Gradient(colors: [.blue, .purple]),
               startPoint: .topLeading, 
               endPoint: .bottomTrailing
            )
         ),
         textColor: .white, 
         submitButtonBackgroundColor: .green,
         submitButtonTitleColor: .white
      )
    )
  }
}
```

The result will look like this on iOS (and similar on other platforms):

@Image(source: "ParentalGate-Customized")



## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}
