// GetTask.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct GetTask: Request {
    let taskGid: GID
    let token: String

    public init(
        taskGid: GID,
        token: String
    ) {
        self.taskGid = taskGid
        self.token = token
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "app.asana.com"
        components.path = "/api/1.0/tasks/\(self.taskGid)"

        return components.url
    }

    public func request() throws -> HTTPClientRequest {
        let url = try getURL()

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = .GET
        request.headers.add(name: "User-Agent", value: "AsanaBot")
        request.headers.add(name: "Accept", value: "application/json")
        request.headers.add(name: "Authorization", value: "Bearer \(self.token)")

        return request
    }

    public func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> FullTask {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
        return try await response.decode(AsanaData<FullTask>.self, decoder: decoder).data
    }
}
