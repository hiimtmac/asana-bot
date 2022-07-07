// Repo.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct Repo: Codable {
    public let id: Int
    public let nodeID: String
    public let name: String
    public let fullName: String
    public let owner: User
    public let repoPrivate: Bool
    public let htmlURL: URL
    public let repoDescription: String?
    public let fork: Bool
    public let url: URL
    public let archiveURL: String
    public let assigneesURL: String
    public let blobsURL: String
    public let branchesURL: String
    public let collaboratorsURL: String
    public let commentsURL: String
    public let commitsURL: String
    public let compareURL: String
    public let contentsURL: String
    public let contributorsURL: URL
    public let deploymentsURL: URL
    public let downloadsURL: URL
    public let eventsURL: String
    public let forksURL: URL
    public let gitCommitsURL: String
    public let gitRefsURL: String
    public let gitTagsURL: String
    public let gitURL: String
    public let issueCommentURL: String
    public let issueEventsURL: String
    public let issuesURL: String
    public let keysURL: String
    public let labelsURL: String
    public let languagesURL: URL
    public let mergesURL: URL
    public let milestonesURL: String
    public let notificationsURL: String
    public let pullsURL: String
    public let releasesURL: String
    public let sshURL: String
    public let stargazersURL: URL
    public let statusesURL: String
    public let subscribersURL: URL
    public let subscriptionURL: URL
    public let tagsURL: URL
    public let teamsURL: URL
    public let treesURL: String
    public let cloneURL: String
    public let mirrorURL: URL?
    public let hooksURL: URL
    public let svnURL: String
    public let homepage: String?
    public let forksCount: Int
    public let stargazersCount: Int
    public let watchersCount: Int
    public let size: Int
    public let defaultBranch: String
    public let openIssuesCount: Int
    public let topics: [String]?
    public let hasIssues: Bool
    public let hasProjects: Bool
    public let hasWiki: Bool
    public let hasPages: Bool
    public let hasDownloads: Bool
    public let archived: Bool
    public let disabled: Bool
    public let pushedAt: Date
    public let createdAt: Date
    public let updatedAt: Date
    public let permissions: Permissions?
    public let allowRebaseMerge: Bool?
    public let tempCloneToken: String?
    public let allowSquashMerge: Bool?
    public let allowMergeCommit: Bool?
    public let forks: Int
    public let openIssues: Int
    public let license: License?
    public let watchers: Int
    public let allowForking: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case repoPrivate = "private"
        case htmlURL = "html_url"
        case repoDescription = "description"
        case fork
        case url
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case sshURL = "ssh_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case mirrorURL = "mirror_url"
        case hooksURL = "hooks_url"
        case svnURL = "svn_url"
        case homepage
        case forksCount = "forks_count"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case size
        case defaultBranch = "default_branch"
        case openIssuesCount = "open_issues_count"
        case topics
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDownloads = "has_downloads"
        case archived
        case disabled
        case pushedAt = "pushed_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case permissions
        case allowRebaseMerge = "allow_rebase_merge"
        case tempCloneToken = "temp_clone_token"
        case allowSquashMerge = "allow_squash_merge"
        case allowMergeCommit = "allow_merge_commit"
        case forks
        case openIssues = "open_issues"
        case license
        case watchers
        case allowForking = "allow_forking"
    }

    public struct License: Codable {
        public let key: String
        public let name: String
        public let url: URL
        public let spdxID: String
        public let nodeID: String

        enum CodingKeys: String, CodingKey {
            case key
            case name
            case url
            case spdxID = "spdx_id"
            case nodeID = "node_id"
        }
    }

    public struct Permissions: Codable {
        public let admin: Bool
        public let push: Bool
        public let pull: Bool
    }
}
