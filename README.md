# UserDefaultsBacked

![badge-mit][] ![badge-languages][] ![badge-pms][] ![badge-platforms][]

A property wrapper to save `Codable` objects in `UserDefaults`.  
Inspired by https://www.swiftbysundell.com/articles/property-wrappers-in-swift/.

### Getting Started

We only support [Swift Package Manager](https://swift.org/package-manager/)

#### Swift Package Manager

```swift
.package(url: "https://github.com/mrgrauel/UserDefaultsBacked.git", from: "1.0.0")
```

### Example

```swift

@UserDefaultsBacked("sample", defaultValue: false)
var sample: Bool

@UserDefaultsBacked("sampleString", defaultValue: "sample")
var sampleString: String

// MARK: `nil` Support

@UserDefaultsBacked("nil_check")
var nilSample: String?

// MARK: Custom `UserDefaults`

static var userDefaults = UserDefaults(suiteName: "StorageTests")!

@UserDefaultsBacked("other_defaults", defaultValue: true, userDefaults: userDefaults)
var otherDefaults: Bool

// MARK: Custom `Codable`

enum Environment: String, Codable {
    case development, stage, production
}

@UserDefaultsBacked("environment", defaultValue: .production)
var environment: Environment

struct Mock: Codable {
    let value: Int
}

@UserDefaultsBacked("codable")
var codable: Mock?
```

[badge-pms]: https://img.shields.io/badge/supports-SwiftPM-green.svg
[badge-languages]: https://img.shields.io/badge/languages-Swift-orange.svg
[badge-platforms]: https://img.shields.io/badge/platforms-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgrey.svg
[badge-mit]: https://img.shields.io/badge/license-MIT-blue.svg
