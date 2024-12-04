# Is Apple Watch Supported as a Platform in FreemiumKit?  

Yes, Apple Watch is supported in FreemiumKit with a small extra setup step. Learn more about what that step is and what limitations there are.

@Metadata {  
   @TitleHeading("FAQs")  
   @PageKind(sampleCode)  
}  

## Short Answer  

Apple Watch is supported, but you’ll need to do one extra step: drag & drop the config file into the WatchKit Extension. Since FreemiumKit doesn’t display paywalls on Apple Watch, purchases happen on iPhone, but you can still check premium status easily with `FreemiumKit.shared.hasPurchased`.

## Full Answer

FreemiumKit works on Apple Watch, but because watchOS handles resources differently, you’ll need to manually add the config file to your WatchKit Extension target. Here’s how to add the file:

### Steps to Add the Config File to the WatchKit Extension  

1. **Open the FreemiumKit Mac App:**  
   - Navigate to the **Setup** tab of your app.

2. **Drag & Drop the Config File:**  
   - Drag the config file (e.g., `FreemiumKit.config`) into your WatchKit Extension in Xcode.

3. **Ensure the File Is Included in Your Target:**
   - Select the file in Xcode.
   - In the **File Inspector**, ensure the **Target Membership** box for your WatchKit Extension is checked.

### Important Notes  

- **Paywall on iPhone Only:** FreemiumKit doesn’t show paywalls on Apple Watch. This ensures a better user experience, as purchases can be made on the iPhone with a larger screen.
- **Check Premium Status:** You can still check premium status using the following call:

  ```swift  
  if FreemiumKit.shared.hasPurchased {  
      // Provide premium features  
  } else {  
      // Restrict to free features  
  }
  ```  

For full setup instructions, refer to the [FreemiumKit SDK Setup Guide](https://freemiumkit.app/documentation/freemiumkit/setupguide).  

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
```
