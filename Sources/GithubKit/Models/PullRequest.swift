// PullRequest.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public struct PullRequest: Codable {
    public let url: URL
    public let id: Int
    public let nodeID: String
    public let htmlURL: URL
    public let diffURL: URL
    public let patchURL: URL
    public let issueURL: URL
    public let commitsURL: URL
    public let reviewCommentsURL: URL
    public let reviewCommentURL: String
    public let commentsURL: URL
    public let statusesURL: URL
    public let number: Int
    public let state: String
    public let locked: Bool
    public let title: String
    public let user: User
    public let body: String?
    public let labels: [Label]
    public let milestone: Milestone?
    public let activeLockReason: String?
    public let createdAt: Date
    public let updatedAt: Date
    public let closedAt: Date?
    public let mergedAt: Date?
    public let mergeCommitSHA: String
    public let assignee: User?
    public let assignees: [User]
    public let requestedReviewers: [User]
    public let requestedTeams: [Team]
    public let head: Commit
    public let base: Commit
    public let links: Links
    public let authorAssociation: String
    public let draft: Bool
    public let merged: Bool?
    public let mergeable: Bool?
    public let rebaseable: Bool?
    public let mergeableState: String?
    public let mergedBy: User?
    public let comments: Int?
    public let reviewComments: Int?
    public let maintainerCanModify: Bool?
    public let commits: Int?
    public let additions: Int?
    public let deletions: Int?
    public let changedFiles: Int?

    enum CodingKeys: String, CodingKey {
        case url
        case id
        case nodeID = "node_id"
        case htmlURL = "html_url"
        case diffURL = "diff_url"
        case patchURL = "patch_url"
        case issueURL = "issue_url"
        case commitsURL = "commits_url"
        case reviewCommentsURL = "review_comments_url"
        case reviewCommentURL = "review_comment_url"
        case commentsURL = "comments_url"
        case statusesURL = "statuses_url"
        case number
        case state
        case locked
        case title
        case user
        case body
        case labels
        case milestone
        case activeLockReason = "active_lock_reason"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case mergedAt = "merged_at"
        case mergeCommitSHA = "merge_commit_sha"
        case assignee
        case assignees
        case requestedReviewers = "requested_reviewers"
        case requestedTeams = "requested_teams"
        case head
        case base
        case links = "_links"
        case authorAssociation = "author_association"
        case draft
        case merged
        case mergeable
        case rebaseable
        case mergeableState = "mergeable_state"
        case mergedBy = "merged_by"
        case comments
        case reviewComments = "review_comments"
        case maintainerCanModify = "maintainer_can_modify"
        case commits
        case additions
        case deletions
        case changedFiles = "changed_files"
    }

    public struct Links: Codable {
        public let linksSelf: Link
        public let html: Link
        public let issue: Link
        public let comments: Link
        public let reviewComments: Link
        public let reviewComment: LinkString
        public let commits: Link
        public let statuses: Link

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
            case html
            case issue
            case comments
            case reviewComments = "review_comments"
            case reviewComment = "review_comment"
            case commits
            case statuses
        }

        public struct Link: Codable {
            public let href: URL
        }

        public struct LinkString: Codable {
            public let href: String
        }
    }
}
