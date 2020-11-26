import XCTest
@testable import UserDefaultsBacked

final class UserDefaultsBackedTests: XCTestCase {
    static var userDefaults = UserDefaults(suiteName: "StorageTests")!

    @UserDefaultsBacked("sample", defaultValue: false)
    var sample: Bool

    @UserDefaultsBacked("sampleString", defaultValue: "sample")
    var sampleString: String

    @UserDefaultsBacked("environment", defaultValue: .production)
    var environment: Environment

    @UserDefaultsBacked("nil_check")
    var nilSample: String?

    @UserDefaultsBacked("other_defaults", defaultValue: true, userDefaults: userDefaults)
    var otherDefaults: Bool

    @UserDefaultsBacked("codable")
    var codable: Mock?
    
    @UserDefaultsBacked("url", defaultValue: URL(string: "https://www.google.com")!)
    var url: URL
    
    @UserDefaultsBacked("data", defaultValue: Data())
    var data: Data

    override func setUpWithError() throws {
        UserDefaults.standard.reset()
        Self.userDefaults.reset()
    }

    override func tearDownWithError() throws {
        UserDefaults.standard.reset()
        Self.userDefaults.reset()
    }
    
    func testData() {
        XCTAssertEqual(self.data, Data())
        let stringData = "String".data(using: .utf8)!
        self.data = stringData
        XCTAssertEqual(self.data, stringData)
    }
    
    func testURL() {
        XCTAssertEqual(url.absoluteString, "https://www.google.com")
        url = URL(string: "https://www.github.com")!
        XCTAssertEqual(url.absoluteString, "https://www.github.com")
    }

    func testSample() {
        XCTAssertFalse(sample)
        sample = true
        XCTAssertTrue(sample)
    }

    func testEnvironment() {
        XCTAssertEqual(environment, .production)
        environment = .stage
        XCTAssertEqual(environment, .stage)
    }

    func testNilSample() {
        XCTAssertNil(nilSample)
        nilSample = "value"
        XCTAssertNotNil(nilSample)
        XCTAssertEqual(nilSample, "value")
        nilSample = nil
        XCTAssertNil(nilSample)
    }

    func testOtherDefaults() {
        XCTAssertTrue(otherDefaults)
        otherDefaults = false
        XCTAssertFalse(otherDefaults)
    }

    func testDefaultValues() {
        XCTAssertEqual(sampleString, "sample")
        sampleString = "otherSample"
        XCTAssertEqual(sampleString, "otherSample")
        UserDefaults.standard.setValue(1, forKey: "sampleString")
        XCTAssertEqual(sampleString, "sample")

        XCTAssertEqual(environment, .production)
        environment = .stage
        XCTAssertEqual(environment, .stage)
        UserDefaults.standard.setValue(Data(), forKey: "environment")
        XCTAssertEqual(environment, .production)

        let mock = Mock(value: .nan)
        XCTAssertNil(codable)
        codable = mock
        XCTAssertNil(codable)
    }
}

enum Environment: String, Codable {
    case development, stage, production
}

struct Mock: Codable {
    let value: Float
}

extension UserDefaults {
    func reset() {
        let dictionary = dictionaryRepresentation()
        dictionary.keys.forEach { key in
            removeObject(forKey: key)
        }
    }
}
