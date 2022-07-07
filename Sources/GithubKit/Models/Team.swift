// Team.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Team: Codable {
    public let id: Int
    public let nodeID: String
    public let url: URL
    public let htmlURL: URL
    public let name: String
    public let slug: String
    public let requestedTeamDescription: String
    public let privacy: String
    public let permission: String
    public let membersURL: URL
    public let repositoriesURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case url
        case htmlURL = "html_url"
        case name, slug
        case requestedTeamDescription = "description"
        case privacy, permission
        case membersURL = "members_url"
        case repositoriesURL = "repositories_url"
    }
}
