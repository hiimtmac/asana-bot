// MoveTasksFlow.swift
// Copyright (c) 2022 hiimtmac

import AsanaKit
import AsyncHTTPClient
import Foundation
import GithubKit
import NIO

public struct MoveTasksFlow {
    let repo: String
    let githubToken: String
    let asanaToken: String
    let pull: Int
    let targetSection: String
    let webhookUrl: String?

    public init(
        repo: String,
        githubToken: String,
        asanaToken: String,
        pull: Int,
        targetSection: String,
        webhookUrl: String?
    ) {
        self.repo = repo
        self.githubToken = githubToken
        self.asanaToken = asanaToken
        self.pull = pull
        self.targetSection = targetSection
        self.webhookUrl = webhookUrl
    }

    public func perform() async throws {
        let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
        defer {
            try? httpClient.syncShutdown()
        }

        let triggeringPull = try await GetPullRequest
            .init(repo: repo, token: githubToken, pull: pull)
            .perform(on: httpClient, decoder: Self.decoder)

        guard let asanas = try triggeringPull.body?.asanas(), !asanas.isEmpty else {
            notice("No asana tasks to move")
            return
        }

        try await withThrowingTaskGroup(of: Void.self) { group in
            for asana in asanas {
                group.addTask {
                    try await MoveTask(
                        token: asanaToken,
                        handle: asana,
                        targetSection: targetSection,
                        decoder: Self.decoder
                    )
                    .perform(on: httpClient)
                }
            }

            try await group.waitForAll()
        }

        if let webhookUrl = webhookUrl {
            let webhook = SendSlack.PRMerge(
                product: self.repo.components(separatedBy: "/").last ?? self.repo,
                name: triggeringPull.title,
                body: triggeringPull.body,
                date: triggeringPull.mergedAt.flatMap { Self.formatter.string(from: $0) }
            )

            try await SendSlack
                .init(urlString: webhookUrl, payload: webhook.payload)
                .perform(on: httpClient, decoder: Self.decoder)
        }
    }

    static let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "YYYY-MM-DD hh:mm"
        return f
    }()
}
