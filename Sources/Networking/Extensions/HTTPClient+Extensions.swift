// HTTPClient+Extensions.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation

extension HTTPClient {
    public func execute(_ request: HTTPClientRequest) async throws -> HTTPClientResponse {
        try await self.execute(request, timeout: .seconds(15))
    }
}
