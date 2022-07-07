// AddTaskToSection.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO

public struct AddTaskToSection: Request {
    let sectionGid: GID
    let token: String
    let body: Request

    public init(
        sectionGid: GID,
        token: String,
        body: AddTaskToSection.Request
    ) {
        self.sectionGid = sectionGid
        self.token = token
        self.body = body
    }

    public init(
        sectionGid: GID,
        token: String,
        taskGid: GID
    ) {
        self.sectionGid = sectionGid
        self.token = token
        self.body = .init(task: taskGid)
    }

    public var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "app.asana.com"
        components.path = "/api/1.0/sections/\(self.sectionGid)/addTask"

        return components.url
    }

    public func request() throws -> HTTPClientRequest {
        let url = try getURL()

        let data = try JSONEncoder().encode(AsanaData(data: self.body))
        let buffer = ByteBuffer(bytes: data)

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = .POST
        request.headers.add(name: "User-Agent", value: "AsanaBot")
        request.headers.add(name: "Accept", value: "application/json")
        request.headers.add(name: "Content-Type", value: "application/json")
        request.headers.add(name: "Authorization", value: "Bearer \(self.token)")
        request.body = .bytes(buffer)

        return request
    }

    public func perform(on client: HTTPClient, decoder _: JSONDecoder) async throws {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
    }
}

extension AddTaskToSection {
    public struct Request: Codable {
        let task: GID
        let insertAfter: GID?
        let insertBefor: GID?

        public init(
            task: String,
            insertAfter: GID? = nil,
            insertBefor: GID? = nil
        ) {
            self.task = task
            self.insertAfter = insertAfter
            self.insertBefor = insertBefor
        }

        enum CodingKeys: String, CodingKey {
            case task
            case insertAfter = "insert_after"
            case insertBefor = "insert_before"
        }
    }
}

extension AddTaskToSection.Request: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(task: value)
    }
}
