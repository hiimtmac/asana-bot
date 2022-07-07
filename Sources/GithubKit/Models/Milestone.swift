// Milestone.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Milestone: Codable {
    public let url: URL
    public let htmlURL: URL
    public let labelsURL: URL
    public let id: Int
    public let nodeID: String
    public let number: Int
    public let state: URL
    public let title: String
    public let milestoneDescription: String
    public let creator: User
    public let openIssues: Int
    public let closedIssues: Int
    public let createdAt: Date
    public let updatedAt: Date
    public let closedAt: Date
    public let dueOn: Date

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case labelsURL = "labels_url"
        case id
        case nodeID = "node_id"
        case number
        case state
        case title
        case milestoneDescription = "description"
        case creator
        case openIssues = "open_issues"
        case closedIssues = "closed_issues"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case dueOn = "due_on"
    }
}
