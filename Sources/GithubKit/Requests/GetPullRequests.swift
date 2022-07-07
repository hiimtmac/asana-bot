// GetPullRequests.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct GetPullRequests: Request {
    let repo: String
    let token: String
    let base: String
    let head: String

    public init(
        repo: String,
        token: String,
        base: String,
        head: String
    ) {
        self.repo = repo
        self.token = token
        self.base = base
        self.head = head
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(self.repo)/pulls"

        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "base", value: self.base))
        items.append(URLQueryItem(name: "head", value: self.head))
        components.queryItems = items

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

    public func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> [PullRequest] {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
        return try await response.decode([PullRequest].self, decoder: decoder)
    }
}
