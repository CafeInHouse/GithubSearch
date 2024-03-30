//
//  KlyNetworker.swift
//  KlyNetworker
//
//  Created by saeng lin on 3/29/24.
//

import Foundation

extension KlyNetworker {
    
    /// 리얼 endpoint를 적용
    public static var product: KlyNetworker {
        return KlyNetworker(
            pahse: .product,
            requester: URLSession(configuration: KlyNetworker.Configuration)
        )
    }
    
    /// 개발자 endpoint를 적용
    public static var develop: KlyNetworker {
        return KlyNetworker(
            pahse: .dev,
            requester: URLSession(configuration: KlyNetworker.Configuration)
        )
    }
}

final public class KlyNetworker {
    
    /// 환경 상태
    private var pahse: Phase = .product
    
    /// Header
    private var headers: [String: String] = [
        "Accept": "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28"
    ]
    
    private let requester: Requester
    
    /// 초기화
    /// - Parameters:
    ///   - pahse: 개발 환경
    ///   - requester: DI Requester 객체
    init(
        pahse: Phase = .product,
        requester: Requester
    ) {
        self.pahse = pahse
        self.requester = requester
    }
}

// MARK: - async/await interface
extension KlyNetworker {
    
    /// 외부에서 네트워크 요청 ( async/await 인터페이스 )
    /// - Parameter api: 추상화 된 API 정보
    /// - Returns: 요청 결과 ( Decodable & Sendable )
    public func request<T: Decodable & Sendable>(
        api: APIable
    ) async throws -> T {
        switch api.method {
        case .get:
            var urlComponents = URLComponents(string: "\(pahse.prefix)\(api.path)")
            
            var parameters: [URLQueryItem] = []
            api.params?.forEach({ key, value in
                parameters.append(URLQueryItem(name: key, value: "\(value)"))
            })
            
            urlComponents?.queryItems = parameters
            
            guard let url = urlComponents?.url else {
                throw KlyError.invalidURL
            }

            return try await request(urlRequest: URLRequest(url: url))
        }
    }
    
    
    /// 요청 EndPoint
    /// - Parameter urlRequest: 요청 정보
    /// - Returns: 요청 결과 ( Decodable & Sendable )
    private func request<T: Decodable & Sendable>(
        urlRequest: URLRequest
    ) async throws -> T {
        do {
            
            #if DEBUG
            let monitor = Monitor()
            #endif
            
            let (data, response) = try await requester.request(urlRequest: urlRequest)
            
            #if DEBUG
            let duration = monitor.stop()
            print("🟢 [Network][Time] \(String(format: "%.3f", duration)) second")
            #endif

            guard let httpResponse = (response as? HTTPURLResponse), (200 ..< 300).contains(httpResponse.statusCode) else {
                
                #if DEBUG
                print("🔴 [\(urlRequest.url?.absoluteString ?? "")][Status] \((response as? HTTPURLResponse)?.statusCode ?? -999)")
                #endif
                
                throw KlyError.invalidStatus((response as? HTTPURLResponse)?.statusCode ?? -999)
            }
            
            #if DEBUG
            print("🟢 [\(urlRequest.url?.absoluteString ?? "")][Status] \(httpResponse.statusCode)")
            
            if let dict = try? JSONSerialization.jsonObject(with: data), let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print("🟢 [Model][\(T.self)]\n \(jsonString)")
            }
            
            #endif
            
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                #if DEBUG
                print("🔴 [invalidDecode][\(T.self)])")
                #endif
                throw KlyError.invalidDecode
            }
            
            return model
            
        } catch let error {
            if let networkerError = error as? KlyError {
                #if DEBUG
                print("🔴 [Error] \(error)")
                #endif
                throw networkerError
            } else {
                #if DEBUG
                print("🔴 [Error] unowned \(error)")
                #endif
                throw KlyError.unowned(message: "알 수 없는 에러입니다.")
            }
        }
    }
}
