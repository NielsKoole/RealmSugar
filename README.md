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

- [x] Easy way to get realm object notifications with less boilerplate code.
- [x] Looking for a way to improve it to avoid the need to guard type safety.
- [x] Sugar to get notifications on Lists, Results and LinkingObjects.

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

### Notifications on objects

Get notified on all changed properties.

```swift
let instance = Employee()

let token = instance.notify { [weak self] (employee) in
    
    // Update label
    self?.textLabel.text = employee.name
}
```

Get notified when an update comes in for specific properties.

```swift
let instance = Employee()
let token = instance.notify(for: #keyPath(Employee.name)) { [weak self] (employee) in
    
    // Update label
    self?.textLabel.text = employee.name
}

let token = instance.notify(for: [#keyPath(Employee.name)]) { [weak self] (employee) in
    
    // Update label
    self?.textLabel.text = employee.name
}
```

Get notified on initiation and on updates.

```swift
let instance = Employee()

let token = instance.fireAndNotify(for: #keyPath(Employee.name)) { [weak self] (employee) in
    
    // Update label
    self?.textLabel.text = employee.name
}

let token = instance.fireAndNotify(for: [#keyPath(Employee.name)]) { [weak self] (employee) in
    
    // Update label
    self?.textLabel.text = employee.name
}
```

### Notifications on collections

Get notified on all changed objects.

```swift
let realm = try! Realm()
let token = realm.objects(Employee.self).notify { [weak self] (employees) in
    
    // Log all employees
    employees.forEach { dump($0) }
}
```

Specify for which kind of updates you want to get notified.

```swift
let realm = try! Realm()
let token = realm.objects(Employee.self).notify(when: .inserted) { [weak self] (employees) in
    
    // Log all employees
    employees.forEach { dump($0) }
}

let token = realm.objects(Employee.self).notify(when: [.inserted, .deleted]) { [weak self] (employees) in
    
    // Log all employees
    employees.forEach { dump($0) }
}
```

Get notified on initiation and on updates.

```swift
let realm = try! Realm()
let token = realm.objects(Employee.self).fireAndNotify(when: .inserted) { [weak self] (employees) in
    
    // Log all employees
    employees.forEach { dump($0) }
}

let token = realm.objects(Employee.self).fireAndNotify(when: [.inserted, .modified]) { [weak self] (employees) in
    
    // Log all employees
    employees.forEach { dump($0) }
}
```

## Credits

Please make any pull requests to improve this, all help is welcome.


## License

RealmSugar is released under the Apache license. See LICENSE for details.