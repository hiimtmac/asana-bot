// AsanaRegex.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public typealias TaskHandle = (project: GID, task: GID)

extension String {
    // TODO: replace with swift regex builder
    public func asanas() throws -> [TaskHandle] {
        let projectGid = "projectGid"
        let taskGid = "taskGid"
        let regex = try NSRegularExpression(pattern: "https:\\/\\/app.asana.com\\/0\\/(?<\(projectGid)>\\d+)\\/(?<\(taskGid)>\\d+)\\/f")

        return regex
            .matches(in: self, range: NSRange(self.startIndex..., in: self))
            .map { result in
                let projectRange = result.range(withName: projectGid)
                let taskRange = result.range(withName: taskGid)

                let project = String(self[Range(projectRange, in: self)!])
                let task = String(self[Range(taskRange, in: self)!])

                return (project, task)
            }
    }
}
