// Request.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation

public protocol Request {
    associatedtype Response

    var url: URL? { get }
    func request() throws -> HTTPClientRequest
    func perform(on client: HTTPClient, decoder: JSONDecoder) async throws -> Response
}

extension Request {
    public func getURL() throws -> URL {
        guard let url = url else {
            throw RequestError.malformedURL
        }

        return url
    }
}
