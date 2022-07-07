// GetRelease.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct GetRelease: Request {
    let repo: String
    let token: String
    let type: ReleaseType

    public init(
        repo: String,
        token: String,
        type: GetRelease.ReleaseType
    ) {
        self.repo = repo
        self.token = token
        self.type = type
    }

    public enum ReleaseType {
        case tag(String)
        case latest

        var path: String {
            switch self {
            case let .tag(tag): return "tags/\(tag)"
            case .latest: return "latest"
            }
        }
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(self.repo)/releases/\(self.type.path)"

        return components.url
    }

    public func request() throws -> HTTPClientRequest {
        let url = try getURL()

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = .GET
        request.headers.add(name: "User-Agent", value: "AsanaBot")
        request.headers.add(name: "Accept", value: "application/vnd.github.v3+json")
        request.headers.add(name: "Authorization", value: "Bearer \(self.token)")

        return request
    }

    public func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> Release {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
        return try await response.decode(Release.self, decoder: decoder)
    }
}
