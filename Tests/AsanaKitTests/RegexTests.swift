// RegexTests.swift
// Copyright (c) 2022 hiimtmac

import XCTest
@testable import AsanaKit

final class RegexTests: XCTestCase {
    func testRegexMatch() throws {
        let text = """
            https://app.asana.com/0/0123456789012345/0123456789012345/f
            asdasd
            https://app.asana.com/0/0123456789012345/9876543210987654/f
            """

        let matched = try text.asanas()
        XCTAssertEqual(matched.count, 2)
    }

    func testRegexNoMatch() throws {
        let text = """
            https://app.asana.com/0/asd/0123456789012345/f
            asdasd
            https://app.com/0/0123456789012345/9876543210987654/f
            """

        let matched = try text.asanas()
        XCTAssertEqual(matched.count, 0)
    }
}
