# RealmSugar

[![CocoaPods Compatible](https://img.shields.io/cocoapods/p/RealmSugar.svg)](https://img.shields.io/cocoapods/p/RealmSugar.svg)
[![Twitter](https://img.shields.io/twitter/follow/nielskoole.svg?style=social&label=Follow)](http://twitter.com/nielskoole)

RealmSugar is a syntactic sugar to remove unnecessary code for retrieving notifications on realm instances.

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Summary

RMRoute makes it easy to provide access to all your features from anywhere in your app. With bigger applications it's sometimes handy to have entry points to your features, without referencing to them by class.

## Features

- [x] Easy way to get realm instance notifications with less boilerplate code.

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

let token = instance.notifierUpdated(properties: [#keyPath(Employee.name)], handler: { [weak self] (object) in
    guard let employee = object as? Employee else { return }
    
    dump(employee.name)
})
```

## Credits

Please make any pull requests to improve this, all help is welcome.


## License

RealmSugar is released under the Apache license. See LICENSE for details.
