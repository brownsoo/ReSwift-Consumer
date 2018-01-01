# ReSwiftConsumer

## NOW COLLECTING ... 지금은 정리 중입니다.

> With ReSwiftConsumer you can consume only the property changes of state in interesting.

ReSwiftConsumer는 [ReSwift](https://github.com/ReSwift/ReSwift)에 속성 선택함수(Property Selector function)와 소비함수(Changed property consumer function)를 연결하여, State의 특정 속성에 대해 반응시켜 개발할 수 있도록 도와줍니다. ReSwiftConsumer를 사용해서 ReSwift의 State 중에서 자신이 원하는 속성값의 변경만 알아챌 수 있습니다.

### Seperated Store

**RePageStoreSubscriber** : 분리된 저장소 구독자

ReSwift 에서는 하나의 스토어를 만들어서 사용하도록 권장하고 있습니다. 이에 대한 내용은 Redux 의 가이드에 잘 설명되어 있습니다. 그렇지만 App 개발에 있어, 저에게는 화면 단위의 스토어 또는 전역적이지 않는 스토어가 필요했습니다. 우리가 보통 개발을 하는 단위를 생각해보면 보통 화면 단위였고, 화면단위로 하위 상태 구조(Sub State structure)를 설계하였습니다. 앱이 복잡해질 수록 화면은 계속 늘어나고, 하나의 State 구조체는 더욱 복잡해져 갑니다. 그런데 실행 중 화면 컨트롤러(ViewController)들은 수십번 생성했다 소멸됩니다. 전역 State에 속성값을 추가하기에는 하찮은 속성들도 많이 있습니다.

App의 전역 State에 영향을 주지 않으며 화면의 생명주기와 동일한 State 가 있다면, 보다 쉽게 개발할 수 있을 것으로 생각되었습니다. 화면 컨트롤러를 생성할 때 팰요한 초기 상태값은 전역 State 를 참고하여 생성하면 되고, 전역 State의 변경이 필요하면 전역 Store에 액션을 보내면 됩니다. 전역 State는 정말 전역적인 요소만 갖고 있으면 됩니다.

ReSwift 에서도 서브 상태만 선택하여 구독할 수 있는 기능을 제공하고 있으며 이 방식으로 상태(State)를 원하는 대로 분리할 수 있습니다. 그런데 안타까운 점은 분리된 Sub state의 StoreSubscriber 에서는 다른 Sub State의 값을 구독형태로 접근할 수 없다는 것입니다.

예를 들어, 다음과 같이 AppState의 Sub state인 AState를 선택 구독한 Context에서 같은 레벨의 BState를 접근하려면 `appStore.state?.bState` 형식으로 직접 호출해야 하는 거죠.. 

*작성 중...*

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
