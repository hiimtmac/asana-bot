// Commit.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Commit: Codable {
    public let label: String
    public let ref: String
    public let sha: String
    public let user: User
    public let repo: Repo
}
