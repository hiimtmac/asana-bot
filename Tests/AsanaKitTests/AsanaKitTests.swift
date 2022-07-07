// AsanaKitTests.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import XCTest
@testable import AsanaKit

final class AsanaKitTests: XCTestCase {
    let token = "token"
    let projectGid = "projectGid"

    var client: HTTPClient!
    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()

        self.client = HTTPClient(eventLoopGroupProvider: .createNew)
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }

    override func tearDownWithError() throws {
        try self.client.syncShutdown()

        try super.tearDownWithError()
    }

    func _testGetSections() async throws {
        let response = try await GetSections
            .init(projectGid: projectGid, token: token)
            .perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.count, 4)
    }

    func _testAddTaskToSection() async throws {
        try await AddTaskToSection
            .init(sectionGid: "sectionGid", token: self.token, body: "tokenGid")
            .perform(on: self.client, decoder: self.decoder)
    }
}
