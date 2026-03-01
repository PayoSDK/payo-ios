# Payo

The simplest way to add subscriptions to your iOS app.

Payo is a lightweight iOS SDK built on StoreKit 2 that handles subscription management, access control, and purchase flows — so you can focus on building your app.

## Features

- **One-line setup** — `Payo.configure("pk_...")` and you're live, config fetched from the server
- **Synchronous access checks** — `Payo.hasAccess` returns a `Bool` instantly, no `await` needed
- **Reactive SwiftUI state** — `Payo.state` is an `ObservableObject` that updates automatically on purchases, restores, renewals, and expirations
- **One-liner view gating** — `.requiresAccess()` blurs and locks any SwiftUI view, with full UIKit support
- **Drop-in purchase button** — `PayoPurchaseButton` fetches pricing, detects intro offers, and handles the purchase flow
- **Tiers** — Gate features behind named access levels like "pro" or "premium", each mapping to one or more product IDs
- **Paywall offerings** — Group products with metadata for dynamic paywalls, configurable from your dashboard
- **A/B experiments** — Test different paywalls with deterministic variant assignment, no server round-trip
- **Intro offer eligibility** — Check if users qualify for free trials or discounted first periods
- **Manage & refund** — Open Apple's native subscription management and refund sheets

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

Visit the [Payo setup wizard](https://payo-sdk.com) to generate an API key for your bundle identifier.

### 2. Configure at app launch

```swift
import payo

@main
struct MyApp: App {
    init() {
        Payo.configure("pk_abc123")
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

### 3. Check access

```swift
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

## Tiers

Tiers let you gate features behind named access levels instead of individual product IDs. A tier like "pro" maps to multiple products (e.g. `pro_monthly` and `pro_annual`), so you check once instead of listing every product.

Configure tiers from your [Payo dashboard](https://payo-sdk.com/dashboard.html).

```swift
// Check access by tier
if Payo.hasAccess("pro") {
    // true if user owns pro_monthly OR pro_annual
}

// SwiftUI view modifier
GroupBox("Pro Analytics") {
    AnalyticsChart()
}
.requiresTier("pro")

// List all tiers
for tier in Payo.tiers {
    print("\(tier.id): \(tier.isActive ? "active" : "inactive")")
}
```

## Paywall Offerings

Paywall offerings group products with metadata for dynamic paywalls. Configure them from your dashboard — no app update needed to change what products are shown.

```swift
// Get the current offering (experiment-aware)
if let offering = await Payo.currentOffering {
    let productIDs = offering.productIDs
    let paywallID = offering.metadata["paywall_id"]
}

// All offerings
let offerings = await Payo.allOfferings()

// Override the current offering
await Payo.setCurrentOffering("sale_50_off")
```

## A/B Experiments

Test different paywalls or price points with deterministic variant assignment. Configure experiments from your dashboard — each variant maps to a paywall offering.

```swift
if let experiment = await Payo.activeExperiment() {
    print("Variant: \(experiment.assignedVariant)")
    print("Offering: \(experiment.offering.id)")
}

// Payo.currentOffering automatically returns the right offering
// for the user's assigned variant — no extra code needed
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

### Configuration

| Method | Description |
|--------|-------------|
| `Payo.configure(_ apiKey:)` | Configure Payo with your API key. Call once at app launch. |
| `Payo.enableDebug(_ enabled:)` | Toggle `[Payo]` console logging |

### Access

| Method | Description |
|--------|-------------|
| `Payo.hasAccess` | Synchronous Bool — does the user have any active subscription? |
| `Payo.hasAccess("id")` | Check access for a specific product ID, group, or tier |
| `Payo.activeProductIDs` | Set of all currently active product IDs |
| `Payo.state` | Observable state for SwiftUI (`@ObservedObject`) |

### Purchasing

| Method | Description |
|--------|-------------|
| `Payo.purchase(_ productID:)` | Purchase a subscription or one-time product |
| `Payo.allProductInfo()` | Get localized names, prices, and intro offers for all products |
| `Payo.productInfo(_ productID:)` | Get info for a specific product |
| `Payo.isEligibleForIntroOffer()` | Check free trial / intro offer eligibility |
| `Payo.isEligibleForIntroOffer("group")` | Check intro eligibility for a specific group |

### Tiers

| Method | Description |
|--------|-------------|
| `Payo.tiers` | All configured tiers with their current active state |
| `Payo.tier(_ id:)` | Get a specific tier by ID |
| `.requiresTier("pro")` | SwiftUI view modifier — gate behind a tier |

### Paywall Offerings

| Method | Description |
|--------|-------------|
| `Payo.currentOffering` | The current offering (experiment-aware) |
| `Payo.offering(_ id:)` | Get a specific offering by ID |
| `Payo.allOfferings()` | All configured paywall offerings |
| `Payo.setCurrentOffering(_ id:)` | Override the current offering |

### A/B Experiments

| Method | Description |
|--------|-------------|
| `Payo.activeExperiment()` | The currently active experiment, if any |
| `Payo.experiment(_ id:)` | Get a specific experiment by ID |

### Subscription Status

| Method | Description |
|--------|-------------|
| `Payo.subscriptionInfo()` | Get status, expiration, and renewal info for the active subscription |
| `Payo.subscriptionInfo(_ productID:)` | Get subscription info for a specific product |

### Account Management

| Method | Description |
|--------|-------------|
| `Payo.restorePurchases()` | Restore previous purchases (required by Apple) |
| `Payo.showManageSubscriptions()` | Open Apple's subscription management sheet |
| `Payo.beginRefundRequest(_ productID:)` | Present Apple's native refund sheet |
| `Payo.presentOfferCodeRedeemSheet()` | Open Apple's offer code redemption sheet (iOS 16+) |
| `Payo.refreshAccess()` | Manually re-check access state from StoreKit |
| `Payo.reset()` | Clear all state and re-initialize |

### View Modifiers

| Method | Description |
|--------|-------------|
| `.requiresAccess()` | SwiftUI — blur + lock overlay |
| `.requiresAccess(group:)` | SwiftUI — gate behind a specific product group |
| `.requiresTier("pro")` | SwiftUI — gate behind a named tier |
| `PayoPurchaseButton` | Drop-in purchase button with smart labels |

## License

Copyright 2026 PayoSDK. All rights reserved.
