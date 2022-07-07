// APIError.swift
// Copyright (c) 2022 hiimtmac

import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1

public enum NetworkingError: Error, LocalizedError {
    case validationError(target: HTTPResponseStatus, actual: HTTPResponseStatus)
    case decodingError(String)
    case bodyMissing

    public var errorDescription: String? {
        switch self {
        case let .validationError(target, actual):
            return "Validation error - expecting \(target.code), got \(actual.code)"
        case let .decodingError(string):
            return "Decoding error, received: \(string)"
        case .bodyMissing:
            return "Response body missing"
        }
    }
}

public protocol APIError: LocalizedError, Codable {
    static func errorHandler(_ buffer: ByteBuffer, decoder: JSONDecoder) throws -> Error
}
