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
pod 'CorrilySDK', :git => 'https://github.com/corrily/ios-sdk.git', :tag => '1.0.0'
```

## Usage

Import the SDK module: `import CorrilySDK`

All public methods are documented, please see details in their apidoc.

### SDK start

Call SDK's `start()` method at app launch time, for example:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  CorrilySDK.start(apiKey: "your_API_key")
  return true
}
```

### Request products

```swift
CorrilySDK.requestPaywall(paywallApiID: "your_API_ID", userID: nil, country: .UnitedStates, isDev: true) {
  guard let response = $0 else {
    print("error requesting paywall: \($1)")
    return
  }
  // process response.monthlyProducts and response.yearlyProducts
}
```

### Send charge request

This should be done in the `updatedTransactions` method of `SKPaymentTransactionObserver`. Call the method regardless of the transaction state, example:

```swift
func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
  transactions.forEach {
    // here `product` is StoreKit product, probably the one that's being purchased at the moment
    // `corrilyProduct` is the corresponding Corrily product
    CorrilySDK.requestCharge(
      transaction: $0,
      product: product,
      paywallProduct: corrilyProduct,
      userID: nil,
      country: .UnitedStates
    )
    queue.finishTransaction($0)
  }
}
```
