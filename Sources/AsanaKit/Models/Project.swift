// Project.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Project: Codable {
    public let gid: GID
    public let resourceType: ResourceType
    public let name: String

    enum CodingKeys: String, CodingKey {
        case gid
        case resourceType = "resource_type"
        case name
    }
}
