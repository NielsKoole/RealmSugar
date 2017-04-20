# RealmSugar

[![CocoaPods Compatible](https://img.shields.io/cocoapods/p/RealmSugar.svg)](https://img.shields.io/cocoapods/p/RealmSugar.svg)
[![Twitter](https://img.shields.io/twitter/follow/nielskoole.svg?style=social&label=Follow)](http://twitter.com/nielskoole)

RealmSugar is a syntactic sugar to remove unnecessary code for retrieving notifications on realm instances.

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Summary

RealmSugar is an extension of only 15 lines of code to make retrieving notifications more readable. You need less boilerplate code to get updates of each realm instance.

## Features

- [x] Easy way to get realm instance notifications with less boilerplate code.
- [ ] Looking for a way to improve it with generics to avoid the need to guard type safety.

## Requirements

- iOS 9.0+
- Xcode 8.0+
- Swift 3.0

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.0.0+ is required to build RealmSugar.

To integrate RealmSugar into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'RealmSugar'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage

```swift
let instance = Employee()

let token = instance.notify(for: [#keyPath(Employee.name)], handler: { [weak self] (object) in
    guard let employee = object as? Employee else { return }
    
    // Update label
    self?.textLabel.text = employee.name
})
```

## Credits

Please make any pull requests to improve this, all help is welcome.


## License

RealmSugar is released under the Apache license. See LICENSE for details.
