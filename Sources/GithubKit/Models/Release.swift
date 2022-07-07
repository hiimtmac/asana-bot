// Release.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Release: Codable {
    public let url: URL
    public let htmlURL: URL
    public let assetsURL: URL
    public let uploadURL: String
    public let tarballURL: URL
    public let zipballURL: URL
    public let discussionURL: URL?
    public let id: Int
    public let nodeID: String
    public let tagName: String
    public let targetCommitish: String
    public let name: String
    public let body: String?
    public let draft: Bool
    public let prerelease: Bool
    public let createdAt: Date
    public let publishedAt: Date
    public let author: User
    public let assets: [Asset]

    enum CodingKeys: String, CodingKey {
        case url
        case htmlURL = "html_url"
        case assetsURL = "assets_url"
        case uploadURL = "upload_url"
        case tarballURL = "tarball_url"
        case zipballURL = "zipball_url"
        case discussionURL = "discussion_url"
        case id
        case nodeID = "node_id"
        case tagName = "tag_name"
        case targetCommitish = "target_commitish"
        case name, body, draft, prerelease
        case createdAt = "created_at"
        case publishedAt = "published_at"
        case author, assets
    }

    public struct Asset: Codable {
        public let url: URL
        public let browserDownloadURL: URL
        public let id: Int
        public let nodeID: String
        public let name: String
        public let label: String
        public let state: String
        public let contentType: String
        public let size: Int
        public let downloadCount: Int
        public let createdAt: Date
        public let updatedAt: Date
        public let uploader: User

        enum CodingKeys: String, CodingKey {
            case url
            case browserDownloadURL = "browser_download_url"
            case id
            case nodeID = "node_id"
            case name, label, state
            case contentType = "content_type"
            case size
            case downloadCount = "download_count"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case uploader
        }
    }
}
