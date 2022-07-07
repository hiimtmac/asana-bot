// Section.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Section: Codable {
    public let gid: GID
    public let resourceType: ResourceType
    public let name: String

    enum CodingKeys: String, CodingKey {
        case gid
        case resourceType = "resource_type"
        case name
    }
}

public struct FullSection: Codable {
    public let gid: GID
    public let resourceType: ResourceType
    public let name: String
    public let createdAt: Date
    public let project: Project
    public let projects: [Project]

    enum CodingKeys: String, CodingKey {
        case gid
        case resourceType = "resource_type"
        case name
        case createdAt = "created_at"
        case project
        case projects
    }
}
