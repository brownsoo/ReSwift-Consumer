# ReSwiftConsumer

## NOW DEVELOPING ...

> With ReSwiftConsumer you can consume segmented property changes of state.

ReSwiftConsumer는 [ReSwift](https://github.com/ReSwift/ReSwift)에 속성 선택함수(Property Selector)를 연결하여 사용한 것입니다.
ReSwiftConsumer를 사용해서 ReSwift의 State 중에서 자신이 원하는 속성값의 변경만 알아챌 수 있습니다.

**PageStoreSubscriber**
It is sperated store subscriber.

ViewController 단에서 바로 사용할 수 있는 다음과 같은 콤포넌트를 포함하고 있습니다.

* ReStateInteractor : `PageStoreSubscriber` 를 바로 사용할 수 있도록 구현해놓은 것으로, `ReSwift`에서 제공하는 `StoreSubscriber`와 다른 Store와 Middleware를 갖고 있습니다.
* StateViewController : `PageStoreSubscriber` 와 연결되어 동작할 수 있는 기본 뷰 컨트롤러입니다.
* StateSharedViewController : 뷰 컨트롤러 안에 다른 뷰 컨트롤러를 포함시켜 화면을 구성할 경우, 부모 뷰컨트롤러와 State와 Store를 공유하기 위해 제공합니다.


[![CI Status](http://img.shields.io/travis/brownsoo/ReSwift-Consumer.svg?style=flat)](https://travis-ci.org/brownsoo/ReSwift-Consumer)
[![Version](https://img.shields.io/cocoapods/v/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)
[![License](https://img.shields.io/cocoapods/l/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)
[![Platform](https://img.shields.io/cocoapods/p/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

샘플 앱의 코드를 확인해보세요.

TODO: 예제는 작성해야함...

## Requirements

## Installation

ReSwiftConsumer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReSwift'
pod 'ReSwiftConsumer'
```

## Author

brownsoo, hansune@me.com

## License

ReSwiftConsumer is available under the MIT license. See the LICENSE file for more info.
