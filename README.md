# Corrily SDK

## Installation

### Swift Package Manager

1. Open your Xcode project settings
2. Go to project level (i.e. not target level)
3. Open tab **Package Dependencies**
4. Press **+**
5. Paste `https://github.com/corrily/ios-sdk.git` (or respective SSH URL) in the top right search field
6. Select desired Dependency Rule, the project you'd like to add the SDK to and press **Add Package**
7. Select `CorrilySDK`, the target you'd like to add the SDK to and press **Add Package**

### Cocoapods

Example:

```ruby
pod 'CorrilySDK', '~> 1.0'
```

## Usage

Import the SDK module: `import CorrilySDK`

All public methods are documented, please see details in their apidoc.

### Initialization

To initiate the CorrilySDK, call the `start` method with your `apiKey`. This should only be done once, typically when your app is launched.

```swift
CorrilySDK.start(apiKey: "your_api_key_here")
```

### Setting User Properties
The setUser method allows you to add additional properties for your user. Moreover, it ensures that the user's prices are linked to their userId and persisted across sessions, even if they log out and re-login.

```swift
CorrilySDK.setUser(userId: "optional_user_id", country: "optional_country_code")
```

### Paywall Rendering
To display the default paywall template, use the renderPaywall method:
```swift
CorrilySDK.renderPaywall(paywallId: Optional<Int>)
```

### Setting a Fallback Paywall
In scenarios where the SDK is unable to retrieve the paywall details from the API, having a fallback paywall ensures your users have uninterrupted access. Use the setFallbackPaywall method to set this up:
```swift
CorrilySDK.setFallbackPaywall(paywall: your_fallback_paywall_here)
```
The PaywallResponse object should match the expected format your application uses to render paywalls, ensuring consistency for your users.
