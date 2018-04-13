import XCTest
import ReSwiftConsumer

class PredictConsumerTests: XCTestCase {
    
    struct State {
        let count: Int
        let map: [Int: String]
    }
    private var consumer: StateConsumer<State>!
    private var result: [Int: String]!
    
    override func setUp() {
        super.setUp()
        consumer = StateConsumer()
    }
    
    override func tearDown() {
        consumer = nil
        super.tearDown()
    }
    
    func testPrediction() {
        let expectation = XCTestExpectation(description: "Predictor test equation")
        let a = State(count: 1, map:[
            1: "a",
            2: "b",
            3: "c"
            ])
        let consumption: (([Int: String]?,  [Int: String]) -> Void) = { old, new in
            self.result = new
            XCTAssertEqual(a.map, self.result)
            expectation.fulfill()
        }
        consumer.add({ state in state?.map },
                     consumption,
                     predict: { old, new -> Bool in old == new })
        consumer.consume(newState: a)
        
        wait(for: [expectation], timeout: 0.5)
        
    }
}
