// CreateRelease.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct CreateRelease: Request {
    let repo: String
    let token: String
    let body: Request

    public init(
        repo: String,
        token: String,
        body: CreateRelease.Request
    ) {
        self.repo = repo
        self.token = token
        self.body = body
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/repos/\(self.repo)/releases"

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

    public func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> Release {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
        return try await response.decode(Release.self, decoder: decoder)
    }
}

extension CreateRelease {
    public struct Request: Codable {
        let tagName: String
        let name: String
        let body: String?
        let targetCommitish: String

        public init(
            tagName: String,
            name: String,
            body: String?,
            targetCommitish: String
        ) {
            self.tagName = tagName
            self.name = name
            self.body = body
            self.targetCommitish = targetCommitish
        }

        enum CodingKeys: String, CodingKey {
            case tagName = "tag_name"
            case name
            case body
            case targetCommitish = "target_commitish"
        }
    }
}
