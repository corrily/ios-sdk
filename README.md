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

### User Identification

Corrily works with 2 types of user identifiers:
- anonymous `device_id`
- `user_id` of signed user 

On the first launch SDK generates random deviceID and stores it in Keychain. Every Paywall request will pass this deviceID, and Corrily will always respond with the same Products to provide consistent user experience at the time of AB-experiments.

Once user logs in, you shoud configure it in SDK to add `user_id` to every Paywall request. This is especially imporant for cross-platforms apps, where user might see the Paywall on the Web and inside the App.

The setUser method allows you to add additional properties for your user. Moreover, it ensures that the user's prices are linked to their userId and persisted across sessions, even if they log out and re-login.

```swift
CorrilySDK.setUser(userId: "optional_user_id")
```

### Determining User's country

Both App Store and Corrily Platform supports country-based price localization. Therefore, each signed User or anonymous Device should be associated with a country.
By default, Corrily SDK tries to **fetch User's country from App Store**, and use it to fetch Paywall from Corrily.

It's also possible to explicitly set User's country by running:
```swift
CorrilySDK.setUser(userId: "my_user_id", country: "US")
```

### Tracking Conversion in Corrily Dashboard

To unlock the full potential of Corrily analytics, it's important to let Corrily know about every new anonymous or registered user of the app by sending [identification request](https://docs.corrily.com/api-reference/set-user-characteristics). By default SDK won't send randomly generated `device_id` to server, because some apps always requre authentication, and don't need anonymous device_id mechanisms at all.

To notify Corrily back-end about a new anonymous device_id, you should call:
```swift
CorrilySDK.identifyUser()
```

or, if you want to explicitly provide country code for anonymous device_id, then:
```swift
CorrilySDK.identifyUser(country: "US")
```

<br>

The default behavior is the opposite for Users. `CorrilySDK.setUser` method [sends](https://docs.corrily.com/api-reference/set-user-characteristics) user information to the server under the hood. This is the correct behavior for most of the cases, but the developer has an option to disable [identification request](https://docs.corrily.com/api-reference/set-user-characteristics):
```swift
CorrilySDK.setUser(userId: "optional_user_id", disableIdentificationRequest: true)
```

### Fetching Products

To fetch the content to display on your Paywall, including list of Products, their features and paywall design details, use `requestPaywall` method.

```swift
let response = try await CorrilySDK.requestPaywall()
print(response!.products)
```

Based on country and other User attributes, Corrily will dynamically determine the Products and other details to be displayed for a given User.
Corrily Platform allows you to show different Prices, sets of Products, and different Paywalls for a different Users,
varying them based on User's country, audience, experiment arm or individual config specified on User's page in dashboard.

Ream more about Paywalls Segmentation [in the docs](https://docs.corrily.com/paywall-builder/configure#segmentation-rules-for-paywalls).

It's also possible to explicitly provide `paywallId` to ignore segmentation rules:
```swift
let response = try await CorrilySDK.requestPaywall(paywallId: 1234)
```


### Paywall Template Rendering
<img src="https://github.com/corrily/ios-sdk/blob/main/docs/paywall_01.png?raw=true" alt="Corrily Paywall Template" style="max-height: 500px;">

To display the default paywall template View, use the renderPaywall method:
```swift
CorrilySDK.renderPaywall()
```

Based on country and other user attributes, Corrily will dynamically determine the Paywall to be displayed for a given user. Corrily Platform allows you to have multiple Paywalls and vary them depends on user's country, audience, or experiment arm. Ream more about [Paywalls Segmentation](https://docs.corrily.com/paywall-builder/configure#segmentation-rules-for-paywalls).

It's possible to explicitly provide `paywallId` too:
```swift
CorrilySDK.renderPaywall(paywallId: 1234)
```

### Paywall Custom Component Rendering

To render your own Paywall View, pass it to the renderPaywall method:
```swift
CorrilySDK.renderPaywall(customView: { factory in
    CustomView(factory: factory)
})
```
An example of the Custom Paywall View could be found [here](./Example/Corrily/Corrily/CustomView.swift).

### Setting a Fallback Paywall
In scenarios where the SDK is unable to retrieve the paywall details from the API, having a fallback paywall ensures your users have uninterrupted access. Use the setFallbackPaywall method to set this up:
```swift
CorrilySDK.setFallbackPaywall(jsonString)
```
The `jsonString` should be a stringified version of the JSON response you get from `/v1/paywall` endpoint. An example of the Custom Paywall View could be found [here](./Example/Corrily/Corrily/FallbackPaywallView.swift).
