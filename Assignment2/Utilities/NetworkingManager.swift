//
//  NetworkingManager.swift
//  SwiftuICrypto
//
//  Created by Yaksh Jethva on 21/11/2023.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}


class WebService {
    func downloadData<T: Codable>(fromURL urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.badUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.badResponse }
        guard 200 ..< 300 ~= httpResponse.statusCode else { throw NetworkError.badStatus }
        
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.failedToDecodeResponse
        }
    }
}
