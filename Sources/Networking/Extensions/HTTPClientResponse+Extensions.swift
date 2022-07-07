// HTTPClientResponse+Extensions.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import NIOFoundationCompat
import NIOHTTP1

extension HTTPClientResponse {
    static var bufferSize: Int { 1024 * 1024 }

    public func validate(
        target: HTTPResponseStatus,
        handlers: [HTTPResponseStatus: APIError.Type] = [:]
    ) async throws {
        if self.status == target { return }

        if let buffer = try? await body.collect(upTo: HTTPClientResponse.bufferSize) {
            let decoder = JSONDecoder()

            if let handler = handlers[self.status] {
                let error = try handler.errorHandler(buffer, decoder: decoder)
                throw error
            }
        }

        throw NetworkingError.validationError(target: target, actual: self.status)
    }

    public func decode<T>(
        _: T.Type,
        decoder: JSONDecoder = .init()
    ) async throws -> T where T: Decodable {
        let buffer = try await body.collect(upTo: HTTPClientResponse.bufferSize)
        // we use an overload defined in `NIOFoundationCompat` for `decode(_:from:)` to
        // efficiently decode from a `ByteBuffer`
        return try decoder.decode(T.self, from: buffer)
    }
}
