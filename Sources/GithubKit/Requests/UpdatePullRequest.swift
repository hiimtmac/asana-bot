// UpdatePullRequest.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct UpdatePullRequest: Request {
    let repo: String
    let token: String
    let pull: Int
    let body: Request

    public init(
        repo: String,
        token: String,
        pull: Int,
        body: UpdatePullRequest.Request
    ) {
        self.repo = repo
        self.token = token
        self.pull = pull
        self.body = body
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(self.repo)/pulls/\(self.pull)"

        return components.url
    }

    public func request() throws -> HTTPClientRequest {
        let url = try getURL()

        let data = try JSONEncoder().encode(self.body)
        let buffer = ByteBuffer(bytes: data)

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = .POST
        request.headers.add(name: "User-Agent", value: "AsanaBot")
        request.headers.add(name: "Content-Type", value: "application/json")
        request.headers.add(name: "Accept", value: "application/vnd.github.v3+json")
        request.headers.add(name: "Authorization", value: "Bearer \(self.token)")
        request.body = .bytes(buffer)

        return request
    }

    public func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> PullRequest {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
        return try await response.decode(PullRequest.self, decoder: decoder)
    }
}

extension UpdatePullRequest {
    public struct Request: Codable {
        let body: String

        public init(
            body: String
        ) {
            self.body = body
        }
    }
}
