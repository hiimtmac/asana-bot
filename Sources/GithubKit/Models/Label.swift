// Label.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Label: Codable {
    public let id: Int
    public let nodeID: String
    public let url: String
    public let name: String
    public let labelDescription: String
    public let color: String
    public let labelDefault: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case url
        case name
        case labelDescription = "description"
        case color
        case labelDefault = "default"
    }
}
