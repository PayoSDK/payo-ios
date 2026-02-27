# Payo

The simplest way to add subscriptions to your iOS app.

Payo is a lightweight iOS SDK built on StoreKit 2 that handles subscription management, access control, and purchase flows — so you can focus on building your app.

## Features

- **Auto-detection** — Pass product IDs, Payo detects subscription types, periods, and pricing from StoreKit automatically
- **Synchronous access checks** — `Payo.hasAccess` returns a `Bool` instantly, no `await` needed
- **Reactive SwiftUI state** — `Payo.state` is an `ObservableObject` that updates automatically on purchases, restores, renewals, and expirations
- **One-liner view gating** — `.requiresAccess()` blurs and locks any SwiftUI view, with full UIKit support
- **Drop-in purchase button** — `PayoPurchaseButton` fetches pricing, detects intro offers, and handles the purchase flow
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
            UpgradeView()
        }
    }
}
```

### 4. Purchase

```swift
// One-liner — smart label with intro offer detection
PayoPurchaseButton("pro_monthly")
    .buttonStyle(.borderedProminent)
```

Or handle the purchase manually:

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
// Blur + lock overlay — unlocks automatically when access is granted
GroupBox("Premium Analytics") {
    AnalyticsChart()
}
.requiresAccess()
```

## `requiresAccess`

The `.requiresAccess()` modifier blurs content and shows a lock overlay when the user doesn't have an active subscription. It updates automatically when access state changes — no manual toggling needed.

### Default overlay

```swift
GroupBox("Weekly Insights") {
    InsightsChart()
}
.requiresAccess()
```

### Custom message and icon

```swift
GroupBox("Pro Stats") {
    StatsView()
}
.requiresAccess("Upgrade to Pro", icon: "star.fill")
```

### Fully custom overlay

```swift
GroupBox("Pro Stats") {
    StatsView()
}
.requiresAccess {
    VStack(spacing: 12) {
        Image(systemName: "crown.fill")
            .font(.largeTitle)
            .foregroundStyle(.yellow)
        Text("Unlock Premium")
            .font(.headline)
        PayoPurchaseButton("pro_monthly")
            .buttonStyle(.borderedProminent)
    }
}
```

### Group-specific access

```swift
// Only unlocks if the user has access to the "premium" group
GroupBox("Premium Feature") {
    FeatureView()
}
.requiresAccess(group: "premium")
```

### UIKit

```swift
// UIView — adds blur + lock overlay
premiumView.setRequiresAccess()
premiumView.removeRequiresAccess()

// UIViewController — shows a paywall VC when access is missing
override func viewDidLoad() {
    super.viewDidLoad()
    requiresAccess {
        PaywallViewController()
    }
}
```

## `PayoPurchaseButton`

A drop-in SwiftUI button that fetches product info, detects intro offer eligibility, and handles the entire purchase flow.

```swift
// Smart label — shows "Start 7-Day Free Trial", "Try for $0.99/Month",
// or "Subscribe — $4.99" depending on eligibility
PayoPurchaseButton("pro_monthly")

// With callbacks
PayoPurchaseButton("pro_monthly", onPurchase: { info in
    print("Purchased: \(info.productID)")
}, onError: { error in
    print("Failed: \(error)")
})

// Custom label
PayoPurchaseButton("pro_monthly") { product, isEligibleForTrial in
    HStack {
        VStack(alignment: .leading) {
            Text(product.displayName)
            if isEligibleForTrial, let offer = product.introOffer {
                Text("\(offer.periodValue)-\(offer.periodUnit) free trial")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        Spacer()
        Text(product.displayPrice)
            .fontWeight(.semibold)
    }
}
```

## API Reference

| Method | Description |
|--------|-------------|
| `Payo.hasAccess` | Synchronous Bool — does the user have any active subscription? |
| `Payo.hasAccess("productID")` | Check access for a specific product ID |
| `Payo.activeProductIDs` | Set of all currently active product IDs |
| `Payo.state` | Observable state for SwiftUI (`@ObservedObject`) |
| `Payo.purchase(_ productID:)` | Purchase a subscription or one-time product |
| `Payo.allProductInfo()` | Get localized names, prices, and intro offers for all products |
| `Payo.productInfo(_ productID:)` | Get info for a specific product |
| `Payo.subscriptionInfo()` | Get status, expiration, and renewal info for the active subscription |
| `Payo.subscriptionInfo(_ productID:)` | Get subscription info for a specific product |
| `Payo.isEligibleForIntroOffer()` | Check free trial / intro offer eligibility |
| `Payo.isEligibleForIntroOffer("group")` | Check intro eligibility for a specific group |
| `Payo.restorePurchases()` | Restore previous purchases (required by Apple) |
| `Payo.showManageSubscriptions()` | Open Apple's subscription management sheet |
| `Payo.beginRefundRequest(_ productID:)` | Present Apple's native refund sheet |
| `Payo.presentOfferCodeRedeemSheet()` | Open Apple's offer code redemption sheet (iOS 16+) |
| `Payo.refreshEntitlements()` | Manually re-check entitlements from StoreKit |
| `Payo.reset()` | Clear all state and re-initialize from plist |
| `Payo.enableDebug(_ enabled:)` | Toggle `[Payo]` console logging |
| `.requiresAccess()` | SwiftUI view modifier — blur + lock overlay |
| `PayoPurchaseButton` | Drop-in purchase button with smart labels |

## License

Copyright 2026 PayoSDK. All rights reserved.
