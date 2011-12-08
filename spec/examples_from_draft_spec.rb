require 'spec_helper'

# These examples are take directly from the draft spec
# http://tools.ietf.org/html/draft-gregorio-uritemplate-07
describe "Examples given in the Draft" do
  let(:params) do
    {
      "dom"        => "example.com",
      "dub"        => "me/too",
      "hello"      => "Hello World!",
      "half"       => "50%",
      "var"        => "value",
      "who"        => "fred",
      "base"       => "http://example.com/home/",
      "path"       => "/foo/bar",
      "list"       => [ "red", "green", "blue" ],
      "keys"       => {"semi"=>";", "dot"=>".", "comma" =>","},
      "v"          => "6",
      "x"          => "1024",
      "y"          => "768",
      "empty"      => "",
      "empty_keys" => [],
      "undef"      => nil
    }
  end

  examples = {}
  section = ""
  File.read(File.dirname(__FILE__) + "/examples_from_draft.txt").each_line do |line|
    next if line.strip.empty?
    if line =~ /^##/
      section = line.gsub('## ', '').to_s
      examples[section] = []
    else
      template, expected = line.strip.split(/\s+/,2)
      examples[section] << [template, expected]
    end
  end

  examples.each do |section, data|
    describe section do
      data.each do |template, expected|
        it "should render #{template.inspect} as #{expected.inspect}" do
          URITemplate.new(template).expand(params).should == expected
        end
      end
    end
  end

end

