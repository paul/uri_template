require 'spec_helper'

describe UriTemplate do

  describe "with good uris" do

    good = [
      "{var}",
      "http://example.com/",
      "http://example.com/{foo}",
      "http://example.com/search{?q}",
      "http://example.com/search{?q,list}"
    ]

    good.each do |tmpl|
      it "should parse #{tmpl.inspect}" do
        lambda { UriTemplate.new(tmpl) }.should_not raise_error(UriTemplate::ParseError)
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
        lambda { UriTemplate.new(tmpl) }.should raise_error(UriTemplate::ParseError)
      end
    end
  end
end

