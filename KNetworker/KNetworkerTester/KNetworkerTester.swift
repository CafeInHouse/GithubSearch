//
//  KNetworkerTester.swift
//  KNetworkerTester
//
//  Created by saeng lin on 3/30/24.
//

import XCTest

@testable import KNetworker

final class KNetworkerTester: XCTestCase {

    var networker: KlyNetworker!
    
    // MARK: - 유효하지 않는 url
    func test_네트워크객체를_생성하고_잘못된_URL형식인경우_InvalidURL_에러가_나온다() async {
        // give
        let expectError = KlyError.invalidURL
        networker = KlyNetworker(requester: MockRequester(data: .init(), response: .init()))
        
        do {
            // when
            let _: MockModel = try await networker.request(api: MockAPI.invalidURL)
            XCTFail("fail")
            
        } catch {
            // then
            XCTAssertEqual(KlyError.invalidURL, expectError)
        }
    }
    
    // MARK: - 유효하지 않는 StatusCode
    func test_네트워크_객체를_생성하고_statusCode가_유효하지않으면_invalidstatus_에러가_나온다() async {
        // give
        let expectError = KlyError.invalidStatus(500)
        let invalidStatusResponse = HTTPURLResponse(
            url: URL(string: "invalidURL")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )!
        networker = KlyNetworker(requester: MockRequester(data: .init(), response: invalidStatusResponse))
        
        do {
            // when
            let _: MockModel = try await networker.request(api: MockAPI.invalid)
            
            XCTFail("fail")
            
        } catch {
            
            // then
            XCTAssertEqual(KlyError.invalidStatus(500), expectError)
        }
    }
    
    // MARK: - 유효하지 않는 JSON 포맷
    func test_네트워크가_성공하고_형식의_맞지않는_json포맷인경우_invalidDecode_에러가_나온다() async {
        // give
        let expectError = KlyError.invalidDecode
        let invalidStatusResponse = HTTPURLResponse(
            url: URL(string: "https://www.naver.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let dict = TestUtil.loadJSON("InValidMockModel") as! [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        networker = KlyNetworker(requester: MockRequester(data: jsonData, response: invalidStatusResponse))
        
        do {
            // when
            let _: MockModel = try await networker.request(api: MockAPI.invalid)
            
            XCTFail("fail")
            
        } catch {
            
            // then
            XCTAssertEqual(KlyError.invalidDecode, expectError)
        }
    }
    
    // MARK: - 성공 case
    func test_네트워크가_성공하고_형식의_맞는_josn포맷인경우_모델이_맴핑된다() async {
        // give
        let expectModel = MockModel(name: "린생")
        let invalidStatusResponse = HTTPURLResponse(
            url: URL(string: "https://www.naver.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        let dict = TestUtil.loadJSON("MockModel") as! [String: Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        networker = KlyNetworker(requester: MockRequester(data: jsonData, response: invalidStatusResponse))
        
        do {
            // when
            let responseModel: MockModel = try await networker.request(api: MockAPI.invalid)
            
            XCTAssertEqual(responseModel, expectModel)
            
        } catch {
            
            // then
            XCTFail("fail")
        }
    }
}
