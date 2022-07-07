// output.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public func setOutput<T>(_ value: T, key: String) where T: CustomStringConvertible {
    print("::set-output name=\(key)::\(value.description)")
}

public func debug(_ message: String) {
    print("::debug::\(message)")
}

public func notice(_ message: String, title: String? = nil, file: String = #file, line: Int = #line, column: Int = #column) {
    var notice = "::notice file=\(file),line=\(line),col=\(column)"
    if let title = title {
        notice += ",title=\(title)"
    }
    notice += "::\(message)"
    print(notice)
}

public func warning(_ message: String, title: String? = nil, file: String = #file, line: Int = #line, column: Int = #column) {
    var notice = "::warning file=\(file),line=\(line),col=\(column)"
    if let title = title {
        notice += ",title=\(title)"
    }
    notice += "::\(message)"
    print(notice)
}

public func error(_ message: String, title: String? = nil, file: String = #file, line: Int = #line, column: Int = #column) {
    var notice = "::error file=\(file),line=\(line),col=\(column)"
    if let title = title {
        notice += ",title=\(title)"
    }
    notice += "::\(message)"
    print(notice)
}

public func group(_ title: String) {
    print("::group::\(title)")
}

public func endGroup() {
    print("::endgroup::")
}

public func addMask(_ value: String) {
    print("::add-mask::\(value)")
}
