# Can I use FreemiumKit for consumable products (like in-game currency / donations)?

Learn how FreemiumKit makes it easy to implement consumable in-app purchases for things like in-game currency, AI tokens, or donation/tip buttons.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

While FreemiumKit is primarily focused on subscription and lifetime purchase management, we also provide a `ConsumablePurchaseButton` for consumable in-app purchases. Just create your consumable products on App Store Connect and use our button to build a simple paywall anywhere in your app. You'll receive push notifications just like for subscriptions!

## Full Answer

Unlike subscriptions and lifetime purchases, consumable products aren't part of the core "Freemium" model concept. Therefore, we don't provide automatic product creation or remote paywall configuration for consumables. However, we still make it easy to integrate consumable purchases with our `ConsumablePurchaseButton`.

### Setting Up Consumable Products

1. Create your consumable products on App Store Connect manually
2. Prepare square product images of 128×128 points (provide @2x/@3x resolution)
3. Use `ConsumablePurchaseButton` to build your paywall:

```swift
ConsumablePurchaseButton(
    productID: "com.app.tokens.100",
    productImage: Image("100-tokens"),
    badgeText: "+10 Bonus"
) { transaction in
    await addTokensToBalance(100)  // persist purchase
    await transaction.finish()  // mark as consumed
}
```

### Preloading Consumables (Optional but Recommended)

While subscriptions and lifetime purchases are pre-loaded automatically upon app start, consumables need to be preloaded explicitly. Add this call to your app entry point to eliminate unnecessary loading delays when presenting your consumable purchases:

```swift
@main
struct MyApp: App {
    init() {
        // Preload consumable product details
        FreemiumKit.shared.preloadConsumables(productIDs: [
            "com.app.tokens.50",
            "com.app.tokens.100",
            "com.app.tokens.400"
        ])
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FreemiumKit.shared)
        }
    }
}
```

### Managing Purchases

Unlike subscriptions which are persisted by the App Store, you need to implement your own logic to handle consumable purchases. Some examples:

#### Simple Donation Button
```swift
ConsumablePurchaseButton(
    productID: "com.app.donation",
    productImage: Image("donation-heart"),
    badgeText: nil
) { transaction in
    // Store donation in UserDefaults
    let donations = UserDefaults.standard.integer(forKey: "donations") ?? 0
    UserDefaults.standard.setValue(donations + 1, forKey: "donations")
    
    await transaction.finish()
    showThankYouMessage()
}
```

#### AI Token Purchase with Server Sync
```swift
ConsumablePurchaseButton(
    productID: "com.app.tokens.50",
    productImage: Image("50-tokens"),
    badgeText: "+5 Free"
) { transaction in
    // Sync with your server
    try await addTokensToServer(
        amount: 55,  // 50 + 5 bonus
        transactionId: transaction.id,
        userId: currentUserId
    )
    
    await transaction.finish()
    await refreshTokenBalance()
}
```

Note that it is important to call `finish()` on the `Transaction` parameter (like done in above examples) as soon as you have provided the user with their purchased content.

FreemiumKit handles all the complexity of loading product information from the App Store, managing purchase states, and handling errors. You'll receive push notifications for new purchases and can track them in the FreemiumKit dashboard.

A great example of consumable products in action is [TranslateKit](https://translatekit.app), which provides monthly 'AI Tokens' in its subscription tiers, but offers additional AI Tokens for purchase when more is needed:

@Image(source: "TranslateKit-Consumables")

Whether you're implementing in-game currency, donation buttons, or AI token purchases, that's how easy it is to add consumable products with FreemiumKit!

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
