// VaporError.swift
// Copyright (c) 2022 hiimtmac

import Foundation
import NIO
import NIOFoundationCompat

// example error usage
struct VaporError: APIError {
    let error: Bool
    let reason: String?

    static func errorHandler(_ buffer: ByteBuffer, decoder: JSONDecoder) throws -> Swift.Error {
        do {
            return try decoder.decode(Self.self, from: buffer)
        } catch {
            throw NetworkingError.decodingError(error.localizedDescription)
        }
    }
}
