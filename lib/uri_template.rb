__dir__ = File.dirname(__FILE__)
require __dir__ + "/uri_template/version"
require __dir__ + "/uri_template/parser"
require __dir__ + "/uri_template/transformer"

class URITemplate
  class ParseError < StandardError; end

  def initialize(uri_template)
    @uri_template = uri_template
    tree = Parser.new.parse(@uri_template)
    @template = Transform.new.apply(tree)
    rescue Parslet::ParseFailed => ex
      raise ParseError, "invalid template: #{uri_template}"
  end

  def expand(params)
    output = ""
    @template.each do |part|
      case part
      when String then output << part
      when Hash   then output << stringify(part, params)
      end
    end

    output
  end

  protected

  def stringify(expression, params)

  end

end

