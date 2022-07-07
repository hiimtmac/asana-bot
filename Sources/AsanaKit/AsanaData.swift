// AsanaData.swift
// Copyright (c) 2022 hiimtmac

import Foundation

struct AsanaData<T> {
    let data: T
}

extension AsanaData: Decodable where T: Decodable {}
extension AsanaData: Encodable where T: Encodable {}
