// MoveTask.swift
// Copyright (c) 2022 hiimtmac

import AsanaKit
import AsyncHTTPClient
import Foundation
import GithubKit

struct MoveTask {
    let token: String
    let handle: TaskHandle
    let targetSection: String
    let decoder: JSONDecoder

    func perform(on client: HTTPClient) async throws {
        let sections = try await GetSections
            .init(projectGid: handle.project, token: self.token)
            .perform(on: client, decoder: self.decoder)

        guard let section = sections.first(where: { $0.name == targetSection }) else {
            let sectionNames = sections.map(\.name).joined(separator: ", ")
            warning(
                "Could not find section with name '\(self.targetSection)' in \(sectionNames)",
                title: "No section found"
            )
            return
        }

        try await AddTaskToSection
            .init(sectionGid: section.gid, token: self.token, taskGid: self.handle.task)
            .perform(on: client, decoder: self.decoder)
    }
}
