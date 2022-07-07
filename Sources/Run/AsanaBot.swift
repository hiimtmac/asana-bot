// AsanaBot.swift
// Copyright (c) 2022 hiimtmac

import ArgumentParser
import AsyncHTTPClient
import Foundation

@main
struct AsanaBot: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "asana-bot",
        abstract: "Helpers for github actions, slack notifications, and asana tasks",
        version: "0.1.0",
        subcommands: [
            MoveTasks.self
        ]
    )
}
