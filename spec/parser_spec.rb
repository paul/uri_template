require 'spec_helper'

describe URITemplate::Parser do

  let(:parser) { URITemplate::Parser.new }

  context "single var" do
    it "should work" do
      p parser.expansion.parse("{foo}")
    end
  end

  context "var list" do
    it "should work" do
      p parser.expansion.parse("{foo,bar}")
    end
  end
end
