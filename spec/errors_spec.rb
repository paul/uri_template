require 'rspec'
require File.expand_path(File.dirname(__FILE__) + "/../lib/uri_template")

describe URITemplate do

  describe "with good uris" do

    good = [
      "http://example.com/",
      "http://example.com/{foo}",
      "http://example.com/search{?q}",
      "http://example.com/search{?q,list}"
    ]

    good.each do |tmpl|
      it "should parse #{tmpl.inspect}" do
        lambda { URITemplate.new(tmpl) }.should_not raise_error(URITemplate::ParseError)
      end
    end
  end

  describe "with invaldi uris" do

    bad = [
      "http://example.com/{",
      "http://example.com/{^foo}"
    ]

    bad.each do |tmpl|
      it "should not parse #{tmpl.inspect}" do
        lambda { URITemplate.new(tmpl) }.should raise_error(URITemplate::ParseError)
      end
    end
  end
end

