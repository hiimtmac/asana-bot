// GithubKitTests.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import XCTest
@testable import GithubKit

final class GithubKitTests: XCTestCase {
    let token = "token"
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

    func _testGetPullRequest() async throws {
        let response = try await GetPullRequest
            .init(repo: repo, token: token, pull: 1)
            .perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.title, "other")
        XCTAssertEqual(response.body, "these are the comments")
    }

    func _testGetPullRequests() async throws {
        let response = try await GetPullRequests
            .init(repo: repo, token: token, base: "main", head: "hiimtmac:update")
            .perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.count, 1)
    }

    func _testUpdatePullRequest() async throws {
        let response = try await UpdatePullRequest(repo: repo, token: token, pull: 1, body: .init(
            body: "Add this to the body"
        )).perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.body, "Add this to the body")
    }

    func _testCreateRelease() async throws {
        let response = try await CreateRelease(repo: repo, token: token, body: .init(
            tagName: "1.0.2",
            name: "Initial",
            body: "Hello",
            targetCommitish: "main"
        )).perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.name, "Initial")
        XCTAssertEqual(response.body, "Hello")
    }

    func _testGetRelease() async throws {
        let response = try await GetRelease
            .init(repo: repo, token: token, type: .latest)
            .perform(on: self.client, decoder: self.decoder)

        XCTAssertEqual(response.name, "Initial")
        XCTAssertEqual(response.body, "Hello")
    }
}
