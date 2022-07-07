// MoveTasks.swift
// Copyright (c) 2022 hiimtmac

import App
import ArgumentParser

struct MoveTasks: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "move-tasks",
        abstract: "Move tasks in asana generated from PR",
        version: "0.1.0"
    )

    @OptionGroup
    var options: SharedOptions

    @Argument(help: "Pull Request ID")
    var pull: Int

    @Argument(help: "Target Section")
    var section: String

    @Option(help: "Slack URL")
    var slackWebhook: String?

    func run() async throws {
        try await MoveTasksFlow
            .init(
                repo: self.options.repo,
                githubToken: self.options.githubToken,
                asanaToken: self.options.asanaToken,
                pull: self.pull,
                targetSection: self.section,
                webhookUrl: self.slackWebhook
            )
            .perform()
    }
}
