// Options.swift
// Copyright (c) 2022 hiimtmac

import ArgumentParser

struct SharedOptions: ParsableArguments {
    @Argument(help: "Github Token")
    var githubToken: String

    @Argument(help: "Asana Token")
    var asanaToken: String

    @Argument(help: "Repo Owner/Name")
    var repo: String
}
