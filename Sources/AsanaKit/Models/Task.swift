// Task.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Task: Codable {
    public let gid: GID
    public let resourceType: ResourceType
    public let name: String

    enum CodingKeys: String, CodingKey {
        case gid
        case resourceType = "resource_type"
        case name
    }
}

public struct FullTask: Codable {
    public let gid: GID
    public let resourceType: ResourceType
    public let name: String
    public let projects: [Project]

    enum CodingKeys: String, CodingKey {
        case gid
        case resourceType = "resource_type"
        case name
        case projects
    }
}
