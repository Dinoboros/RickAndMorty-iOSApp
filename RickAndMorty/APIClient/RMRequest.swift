//
//  RMRequest.swift
//  RickAndMorty
//
//  Created by Méryl VALIER on 28/08/2023.
//

import Foundation

/// Object that represent a single API Call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    /// Path components for the API, if any
    private let path: [String]
    /// Query items for the API, if any
    private let query: [URLQueryItem]
    
    /// Constructed URL for the API Request
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !path.isEmpty {
            path.forEach {
                string += "/\($0)"
            }
        }
        
        if !query.isEmpty {
            string += "?"
            let argumentString = query.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired HTTP method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - path: Collection of path components
    ///   - query: Collection of query items
    init(endpoint: RMEndpoint, path: [String] = [], query: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.path = path
        self.query = query
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, query: queryItems)
                    return
                }
            }
        }
        return nil 
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
