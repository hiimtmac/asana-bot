// User.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct User: Codable {
    public let login: String
    public let id: Int
    public let nodeID: String
    public let avatarURL: URL
    public let gravatarID: String
    public let url: URL
    public let htmlURL: URL
    public let followersURL: URL
    public let followingURL: String
    public let gistsURL: String
    public let starredURL: String
    public let subscriptionsURL: URL
    public let organizationsURL: URL
    public let reposURL: URL
    public let eventsURL: String
    public let receivedEventsURL: URL
    public let type: String
    public let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}
