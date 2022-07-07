// Errors.swift
// Copyright (c) 2022 hiimtmac

import Foundation

public enum RequestError: Error, LocalizedError {
    case malformedURL

    public var errorDescription: String? {
        switch self {
        case .malformedURL:
            return "Malformed URL"
        }
    }
}

public enum ResponseError: Error, LocalizedError {
    case badResponse(String)
    case missingBody

    public var errorDescription: String? {
        switch self {
        case let .badResponse(string):
            return "Bad response: \(string)"
        case .missingBody:
            return "Missing body"
        }
    }
}
