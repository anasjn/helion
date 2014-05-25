expect = require("chai").expect
tags = require "../lib/tags.js"

describe "Tags", ->
  describe "#parse()", ->
    it "Should parse long formed tags", ->
      args = ["--depth=4", "--hello=world"]
      results = tags.parse args

      expect(results).to.have.a.property "depth", 4
      expect(results).to.have.a.property "hello", "world"