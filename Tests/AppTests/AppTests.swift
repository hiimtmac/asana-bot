// AppTests.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import GithubKit
import XCTest
@testable import App

final class AppTests: XCTestCase {
    let asanaToken = "token"
    let projectGid = "projectGid"
    let repo = "repo"

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

    func _testMoveTask() async throws {
        let move = MoveTask(
            token: asanaToken,
            handle: (project: projectGid, task: "taskGid"),
            targetSection: "Ready for Review",
            decoder: decoder
        )

        try await move.perform(on: self.client)
    }

    func _testSendSlack() async throws {
        let release = SendSlack.PRMerge(
            product: "Frontend",
            name: "Cool Release",
            body: """
                Really great release. We did lots of things:
                - This thing
                - That thing
                - Another thing
                """,
            date: "2020-01-01"
        )

        try await SendSlack
        (urlString: "slack", payload: release.payload)
            .perform(on: self.client, decoder: .init())
    }
}
