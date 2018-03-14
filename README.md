# ReSwiftConsumer

## NOW COLLECTING ... 지금은 정리 중입니다. 간단한 예제(Example)를 통해 손흥민같이 빠르게 파악할 수 있을 겁니다.

> With ReSwiftConsumer you can consume only the property changes of state in interesting. And you can have seperated store from global one state.

[![Version](https://img.shields.io/cocoapods/v/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)
[![License](https://img.shields.io/cocoapods/l/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)
[![Platform](https://img.shields.io/cocoapods/p/ReSwiftConsumer.svg?style=flat)](http://cocoapods.org/pods/ReSwiftConsumer)


ReSwiftConsumer는 [ReSwift](https://github.com/ReSwift/ReSwift)에 속성 선택함수(Property selector)와 변경된 값에 대한 소비함수(Changed property consumer, Observer)를 연결하여, State의 특정 속성에 대해 반응시켜 개발할 수 있도록 도와줍니다. ReSwiftConsumer를 사용해서 ReSwift의 State 중에서 자신이 원하는 속성값의 변경만 알아챌 수 있습니다.


> **속성 선택함수를 이용해 멀티 옵저버를 `extension`으로 구현한 것이 있어 링크합니다. [ReSwift+select.swift](https://gist.github.com/nferruzzi/a36e2be5c5da7dbe25e90a56fd1049ad) 제가 고민했던 문제를 너무나도 간결하게 `Promise`형식으로 구현해놨습니다. Wow!!**


## StateConsumer

ReSwift에서 newState 함수를 통해 상태가 변경되었음을 알 수 있지만, 상태의 어떤 속성값이 변경되었는지 알 수 없습니다. State 가 많은 UI 요소와 연결되어 있는 상황이라면, 빈번한 State updation에 대한 복잡하고 세밀한 처리가 필요합니다. 이런 2가지 어려운 점을 쉽게 다루고자 *StateConsumer*를 만들었습니다.

StateConsumer는 아래의 Consumer 프로토콜을 구현하고 있는데, 상태가 변경되면 consume 함수가 호출되게 됩니다.
```swift
public protocol Consumer {
    associatedtype State
    func consume(old: State?, new: State?)
}
```

사용 방법은 간단합니다. `add`함수를 통해 관심을 갖고자 하는 속성과 그 속성의 소비함수를 연결하면 됩니다. 하위 상태(sub state)의 특정 값 또한 관찰할 수 있습니다.

```swift
struct AppState: StateType {
    var counter: Int = 0
    var name: String? = nil
    var works: [String] = []
}
let mainStore = Store<AppState>(reducer: reducer, state: nil)

class CounterViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    var works: [String] = []
    let consumer = StateConsumer<AppState>()

    override func viewWillAppear(_ animated: Bool) {
        mainStore.subscribe(self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        mainStore.unsubscribe(self)
        // remove all consumers
        consumer.removeAll()
    }

    func newState(state: AppState) {
        // pass new state into consumer
        consumer.consume(newState: state)
    }

    override func viewDidLoad() {
        // add consumer of property selectively
        consumer.add({state in state.counter}, onCounterChanged)
        consumer.add({state in state.name}, onNameChanged)
        consumer.add({state in state.works}, onWorksChanged)
    }

    // MARK: Consumers

    private func onCounterChanged(old: Int, new: Int) {
        counterLabel.text = "\(new)"
    }

    private func onNameChanged(old: String?, new: String?) {
        nameLabel.text = new
    }

    private func onWorksChanged(old: [String]?, new: [String]) {
        self.works = new
    }
}


```

*StateConsumer에 대한 성능 실험은 진행되지 않았습니다. 그럼에도 StateConsumer는 내부에 상태 인스턴스를 포함하고 있기 때문에 덩치 큰 State를 다룰 경우 메모리나 속도 문제가 있을 것은 분명합니다. 상태 구조를 잘 설계하고 분절해서 사용해야 합니다. 이런 문제를 조금 해결해보고자 독립된 저장소를 만들었습니다. 아래에서 확인할 수 있습니다.*

## 분리된 저장소

### PageStoreSubscriber

독립적인 저장소의 구독자를 새로 만들었습니다.

ReSwift 에서는 하나의 스토어를 만들어서 사용하도록 권장하고 있습니다. 이에 대한 내용은 Redux 의 가이드에 잘 설명되어 있습니다. 그렇지만 App 개발에 있어, 저에게는 화면 단위의 스토어 또는 전역적이지 않는 스토어가 필요했습니다. 우리가 보통 개발을 하는 단위를 생각해보면 화면 단위였고, 화면단위로 하위 상태 구조(Sub State structure)를 설계하였습니다. 앱이 복잡해질 수록 화면은 계속 늘어나고, 하나의 State 구조체는 더욱 복잡해져 갑니다. 그리고 실행 중 화면 컨트롤러(ViewController)들은 수십번 생성되고 소멸되기 때문에 일시적인 데이터들이 많았습니다. 전역 State에 속성값을 추가하기에는 하찮은 속성들도 많이 있습니다. 저는 전역 State에 이러한 일시적인 데이터를 넣는 것에 대해 살짝 불편합니다.

App의 전역 State에 영향을 주지 않으며 화면의 생명주기와 동일한 State가 있다면, 보다 쉽게 개발할 수 있을 것으로 생각되었습니다. 화면 컨트롤러를 생성할 때 필요한 초기 상태값은 전역 State를 참고하여 생성하면 되고, 전역 State의 변경이 필요하면 전역 Store에 액션을 보내면 됩니다. 전역 State는 정말 전역적인 요소만 갖고 있으면 됩니다.

ReSwift 에서도 서브 상태만 선택하여 구독할 수 있는 기능을 제공하고 있으며 이 방식으로 상태(State)를 원하는 대로 분리할 수 있습니다. 그런데 안타까운 점은 분리된 Sub state의 StoreSubscriber 에서는 전역 State의 값을 구독형태로 접근할 수 없다는 것입니다.

예를 들어, 다음과 같이 AppState의 Sub state인 ChildState를 선택 구독한 Context에서 같은 레벨의 속성 t를 접근하려면 `appStore.state.t` 형식으로 직접 호출해야 하는 거죠.. 

```swift
struct AppState: StateType {
    var childState = ChildState()
    var t: Int = 0
}
```

**PageStoreSubscriber**를 통해 분리된 스토어를 사용하면 다음과 같이 ChildState와 t 값을 구독형태로 다룰 수 있습니다.

*작성 중...*



## Components

ViewController 단에서 바로 사용할 수 있는 다음과 같은 콤포넌트를 포함하고 있습니다.

* RePageInteractor : `PageStoreSubscriber` 를 바로 사용할 수 있도록 구현해놓은 것으로, `ReSwift`에서 제공하는 `StoreSubscriber`와 다른 Store와 Middleware를 갖고 있습니다.

* StateViewController : `RePageInteractor` 와 연결되어 동작할 수 있는 기본 뷰 컨트롤러입니다.

* StateSharedViewController : 뷰 컨트롤러 안에 다른 뷰 컨트롤러를 포함시켜 화면을 구성할 경우, 부모 뷰컨트롤러(StateViewController)와 State와 Store를 공유하기 위해 제공합니다.

*작성 중...*

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

샘플 앱의 코드를 확인해보세요.

*예제는 작성해야함...*

## Requirements

## Installation

ReSwiftConsumer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReSwift'
pod 'ReSwiftConsumer'
```

## Author

brownsoo, [@hansoo.labs](https://twitter.com/hansoolabs)

## License

ReSwiftConsumer is available under the MIT license. See the LICENSE file for more info.
