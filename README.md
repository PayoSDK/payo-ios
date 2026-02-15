# Payo

The simplest way to add subscriptions to your iOS app.

Payo is a lightweight iOS SDK built on StoreKit 2 that handles subscription management, access control, and purchase flows — so you can focus on building your app.

## Features

- **Auto-detection** — Pass product IDs, Payo detects subscription types, periods, and pricing from StoreKit automatically
- **Synchronous access checks** — `Payo.hasAccess` returns a `Bool` instantly, no `await` needed
- **Reactive SwiftUI state** — `Payo.state` is an `ObservableObject` that updates automatically on purchases, restores, renewals, and expirations
- **One-liner view gating** — `.requiresAccess()` adds a blur + lock overlay to any SwiftUI view or UIView
- **Intro offer eligibility** — Check if users qualify for free trials or discounted first periods
- **Manage & refund** — Open Apple's native subscription management and refund sheets
- **Multi-tier support** — Gate features behind named groups for apps with multiple plan levels
- **Zero configuration code** — Drop in a `Payo.plist` and the SDK auto-configures at launch

## Requirements

- iOS 15+
- Swift 5.9+
- Xcode 15+

## Installation

### Swift Package Manager

1. In Xcode, go to **File > Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/PayoSDK/payo-ios
   ```
3. Set the dependency rule to **Up to Next Major Version** and click **Add Package**

## Quick Start

### 1. Get your API key

Visit the [Payo setup guide](https://payo-sdk.com) to generate an API key for your bundle identifier and download a pre-configured `Payo.plist`.

### 2. Add the plist to your project

Drag `Payo.plist` into your Xcode project navigator. Make sure **"Copy items if needed"** is checked. Payo reads it automatically at launch — no setup code needed.

### 3. Check access

```swift
import payo

// Synchronous — use anywhere
if Payo.hasAccess {
    // unlock pro features
}

// Reactive SwiftUI
struct ContentView: View {
    @ObservedObject var billing = Payo.state

    var body: some View {
        if billing.hasAccess {
            ProContent()
        } else {
            PaywallView()
        }
    }
}
```

### 4. Purchase

```swift
do {
    let info = try await Payo.purchase("pro_monthly")
    print("Purchased! Expires: \(info.expirationDate ?? .now)")
} catch PayoError.userCancelled {
    // user tapped Cancel — do nothing
}
```

### 5. Gate views

```swift
// SwiftUI — one-liner blur + lock overlay
GroupBox("Premium Analytics") {
    AnalyticsChart()
}
.requiresAccess()
```

## API Reference

| Method | Description |
|--------|-------------|
| `Payo.hasAccess` | Synchronous Bool — does the user have any active subscription? |
| `Payo.hasAccess("group")` | Check access for a specific named group |
| `Payo.state` | Observable state for SwiftUI (`@ObservedObject`) |
| `Payo.purchase(_ productID:)` | Purchase a subscription or one-time product |
| `Payo.allProductInfo()` | Get localized names, prices, and intro offers |
| `Payo.productInfo(_ productID:)` | Get info for a specific product |
| `Payo.isEligibleForIntroOffer()` | Check free trial / intro offer eligibility |
| `Payo.restorePurchases()` | Restore previous purchases (required by Apple) |
| `Payo.showManageSubscriptions()` | Open Apple's subscription management sheet |
| `Payo.beginRefundRequest(_ productID:)` | Present Apple's native refund sheet |
| `Payo.refreshEntitlements()` | Manually re-check entitlements from StoreKit |
| `Payo.reset()` | Clear all state and re-initialize from plist |
| `Payo.enableDebug(_ enabled:)` | Toggle `[Payo]` console logging |
| `.requiresAccess()` | SwiftUI view modifier — blur + lock overlay |

## License

Copyright 2026 PayoSDK. All rights reserved.
