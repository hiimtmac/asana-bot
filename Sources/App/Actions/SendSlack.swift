// SendSlack.swift
// Copyright (c) 2022 hiimtmac

import AsyncHTTPClient
import Foundation
import Networking
import NIO
import SlackKit

struct SendSlack: Request {
    let urlString: String
    let payload: IncomingWebhook

    var url: URL? {
        URL(string: self.urlString)
    }

    func request() throws -> HTTPClientRequest {
        let url = try getURL()

        let data = try JSONEncoder().encode(self.payload)
        let buffer = ByteBuffer(bytes: data)

        var request = HTTPClientRequest(url: url.absoluteString)
        request.method = .POST
        request.headers.add(name: "User-Agent", value: "AsanaBot")
        request.headers.add(name: "Content-Type", value: "application/json")
        request.body = .bytes(buffer)

        return request
    }

    public func perform(on client: HTTPClient, decoder _: JSONDecoder) async throws {
        let response = try await client.execute(self.request())
        try await response.validate(target: .ok)
    }
}

extension SendSlack {
    struct PRMerge {
        let product: String
        let name: String
        let body: String?
        let date: String?

        var payload: IncomingWebhook {
            var markdown = "*\(name)*"
            var text = "\(product): \(name)"

            self.date.flatMap {
                markdown += " _@ \($0)_"
                text += " merged @ \($0)"
            }

            self.body.flatMap {
                markdown += "\n\n\($0)"
                text += "\n\n\($0)"
            }

            return IncomingWebhook(
                text: text,
                blocks: [
                    .header(text: "\(self.product) PR Merged"),
                    .divider(),
                    .markdownSection(
                        text: markdown
                    )
                ]
            )
        }
    }
}
