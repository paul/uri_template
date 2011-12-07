require "uri_template/version"
require "uri_template/parser"
require "uri_template/transformer"

class URITemplate

  def initialize(uri_template)
    @uri_template = uri_template
    tree = Parser.new.parse(@uri_template)
    @template = Transform.new.apply(tree)
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

