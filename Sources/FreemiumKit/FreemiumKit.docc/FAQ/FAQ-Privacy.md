# How does FreemiumKit handle User Privacy? 

Learn how FreemiumKit was designed to keep your users data private and reduce the exposure of your purchase data to a minimum.

@Metadata {
   @TitleHeading("FAQs")
   @PageKind(sampleCode)
}

## Short Answer

We **don't send any personal user data** to our servers, respecting user privacy. And we delete purchase data from our servers as soon as they are fetched to _your_ devices. Your purchase data is persisted via CloudKit in your Apple Account. We can't access your purchase history.

> Apple App Privacy: If you are here to understand what fields you need to fill out for your app on App Store Connect, here's your quick answer: Select "Purchases" for data types. Then select "Analytics" and "App Functionality" within the "Purchases" detail setup like this:
>
> ![Purchase History Setup](AppPrivacy-Purchases)
>
> You can answer all subsequent questions with "No" when pressing "Next" because we are not collecting any user-identifiable information.

## Full Answer

Firstly, we follow the principle of **data minimization** and don't send any personal data to our servers. The only data we send are the date and country of the purchase and the purchased product with its price. This way even if our servers were breached, there's nothing useful to be obtained for attackers.

Secondly, we **don't keep the data for long**: The moment the FreemiumKit app on your devices successfully fetch the purchase data, they are deleted from our servers. If you install FreemiumKit on your iPhone and have push notifications turned on, this happens just seconds after a purchase was made, keeping the amount of data we store on our servers close to zero basically all the time.

> Tip: All our servers are hosted within the European Union (EU), ensuring your data complies with strict EU privacy laws, including GDPR, for enhanced protection and security.

To ensure your data is backed up and syncs across devices, we use CloudKit. This way, even if you delete the FreemiumKit app or lose your device, you can just reinstall FreemiumKit on another device and your full purchase history statistics will stay available within the same Apple Account.

If you happen to stop using the FreemiumKit app for some reason, new purchases are kept up to 90 days on our servers. So you'll always be able to fetch the last 90 days if you decide to return. If you have push notifications disabled, you need to open the app at least once every 90 days to not lose any purchase history data. If you returned after 100 days, you would lose 10 days of data, for example.

That's why we strongly recommend to **keep push notifications enabled** on FreemiumKit for iPhone, even if you don't wish to actually receive push notifications. You can turn off push notifications within the FreemiumKit app, which will disable the local push notification sent by the app while woken up in the background by a silent push notification. This way, the app will continue fetching purchase data without bothering you with push notifications.

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
