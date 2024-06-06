# FreemiumKit

Simple In-App Purchases and Subscriptions for Apple Platforms:
Automation, Paywalls, A/B Testing, Live Notifications, PPP, and more. 

@Metadata {
   @TechnologyRoot
   @PageImage(purpose: icon, source: "FreemiumKit")
   @TitleHeading("Welcome to")
   @CallToAction(url: "mailto:beta@fline.dev?subject=FreemiumKit&body=Register", purpose: link, label: "📧 Register for the Beta")
}


## Overview

![FreemiumKit Logo](FreemiumKit-Lettering)

FreemiumKit is the ultimate solution for Apple platform developers to integrate and manage in-app purchases and subscriptions effortlessly. With support for all Apple platforms, FreemiumKit provides a seamless and efficient way to handle your app's monetization.

## Key Features

### One-Click Creation of Monthly/Yearly/Lifetime

- **Connect API Integration**: FreemiumKit connects to App Store Connect on your behalf to automate all the steps needed to create your products, saving you a lot of click & wait.
- **Automatic Pricing**: We even calculate the prices for longer periods by default based on your Monthly price in a sensible manner, giving you full control when needed.
- **Combined Review Note**: The review note updates for all of Monthly/Yearly/Lifetime at once.

@Video(poster: "QuickSetup-Poster", source: "QuickSetup")

### Configurable Paywalls

- **Paywalls**: Our SDK contains beautiful & localized paywall designs for all Apple platforms.
- **Remote Config**: Paywalls update immediately so you don't need to wait for a new app version.
- **A/B Testing**: Improve your conversion by comparing up to 4 designs in parallel.
   
@Video(poster: "Paywalls-Poster", source: "Paywalls")


### Flexible Pricing Adjustments

- **Purchase Power Parity:** Adjust prices based on country to maximize revenue & accessibility.
- **A/B Testing:** Automatically creates subscription groups so you can test different prices!


@Row {
   @Column(size: 2) {
      ### Native Experience
      - **Full Apple Platforms Support:** Seamlessly integrate the SDK with iOS, macOS, visionOS, and tvOS.
      - **Live Purchase Push Notifications:** Receive real-time notifications for user purchases to stay on top of your app's performance.
      - **Privacy by Design:** The SDK avoids sending personal user data to any servers. And we don't keep your purchase data on our servers.
   }
   
   @Column {
      ![Push Notifications](PushNotifications)
   }
}


## FreemiumKit vs. RevenueCat

Many people in our community love 😻 RevenueCat, so you might wonder how FreemiumKit compares. The following table should explain why I've built FreemiumKit in the first place:

| Feature                        | FreemiumKit                                           | RevenueCat                     |
|--------------------------------|-------------------------------------------------------|--------------------------------|
| **Quick Setup**                | ✅ (automated creation of products on Connect)        | ❌                             |
| **Paywalls**                   | ✅ (on all Apple Platforms, even visionOS!)           | 🚧 (only iOS)                  |
| **Built-In Localization**      | ✅ (paywalls localized to ~40 languages)              | ❌                             |
| **Real-Time Notifications**    | ✅ (push notifications sent to native iPhone app)     | ❌ (only webhooks)             |
| **Skip Renewal Notifications** | ✅ (reports purchases & **new** subscriptions)        | ❌                             |
| **Verified Transactions**      | ✅ (using StoreKit 2)                                 | ✅                             |
| **A/B Testing**                | ✅ (fast setup, up to 4 designs in parallel)          | ✅ (but a lot of work)         |
| **Native App**                 | ✅ (on all Apple Platforms)                           | ❌                             |
| **Purchases Dashboard**        | ✅ (in native app)                                    | ✅ (only Web)                  |
| **Purchase Power Parity**      | ✅ (adjustable slider to mix with Apple prices)       | ❌                             |
| **Scalable**                   | ✅ (CDN for remote config, purchases in iCloud)       | ✅ (higher price)              |
| **User Privacy**               | ✅ (no personal data sent, server temporary storage)  | ❌ (lots of data)              |
| **Supports Apple Platforms**   | ✅ (including visionOS)                               | ✅ (including visionOS)        |
| **Supports Android & Web**     | ❌                                                    | ✅                             |
| **Pricing**                    | Freemium, paid tier **below 1%** of Revenue           | Freemium, paid tier exactly 1% of Revenue |

> Tip: If you need RevenueCat for combined stats (with Android) or for their 3rd-party integrations, you can set RevenueCat to Observer mode and still use FreemiumKit for paywalls, live notifications etc.


## Pricing

FreemiumKit is **completely free to use** at the moment for _everyone_.

In the future, only developers with more than $500 monthly income on App Store Connect will need to pay, and always less than 1% of their proceeds. The full planned pricing table:

@Row {
   @Column {
      | Monthly Income        | Cost     |
      |-----------------------|----------|
      | $0 - $500             | Free     |
      | $500 - $1k            | $5/mo    |
      | $1k - $2k             | $10/mo   |
      | $2k - $4.5k           | $20/mo   |
      | $4.5k - $7.5k         | $45/mo   |
   }

   @Column {
      | Monthly Income        | Cost      |
      |-----------------------|---------- |
      | $7.5k - $15k          | $75/mo    |
      | $15k - $30k           | $150/mo   |
      | $30k - $50k           | $300/mo   |
      | $50k - $100k          | $500/mo   |
      | $100k+                | $1,000/mo |
   }
}


## Get Started

Ready to take your app's monetization to the next level? Download FreemiumKit today and start experiencing the benefits of simplified and powerful in-app purchases & subscriptions.

[Download Now](https://apps.apple.com/app/apple-store/id6502914189?pt=549314&mt=8&ct=freemiumkit.app) (Coming Soon)


## SDK Setup Guide

For a detailed walkthrough on how to integrate the FreemiumKit SDK into your app, check out our [SDK Setup Guide](doc:SetupGuide).


## Testimonials

Here's what customers are saying about FreemiumKit:

@Row {
   @Column {
      ![Testimonial Image](path/to/testimonial-image.png)
      
      > Jane Doe, Developer: FreemiumKit has transformed the way we handle in-app purchases. The setup was incredibly easy, and the features are exactly what we needed!
   }
   
   @Column {
      ![Testimonial Image](path/to/testimonial-image.png)
      
      > Jane Doe, Developer: FreemiumKit has transformed the way we handle in-app purchases. The setup was incredibly easy, and the features are exactly what we needed!
   }
}


## FAQ

The top 5 most frequently asked questions:

@Links(visualStyle: list) {
   - <doc:FAQ-HowItWorks>
   - <doc:FAQ-Privacy>
   - <doc:FAQ-Validation>
   - <doc:FAQ-Pricing>
}

Visit the [Frequently Asked Questions](doc:FAQs) page for the full list of questions & answers.



## Contact

Have questions or need support? Reach out to me at [freemiumkit@fline.dev](mailto:freemiumkit@fline.dev).

---

## Legal

@Small {
   Cihat Gündüz © 2024. All rights reserved.
   Privacy: No personal data is tracked on this site.
   [Imprint](https://www.fline.dev/imprint/)
}


## Topics

- <doc:SetupGuide>
- <doc:FAQs>
