require 'addressable/uri'

__dir__ = File.dirname(__FILE__)
require __dir__ + "/uri_template/version"
require __dir__ + "/uri_template/parser"
require __dir__ + "/uri_template/transformer"

class URITemplate
  class ParseError < StandardError; end

  def initialize(uri_template)
    @uri_template = uri_template
    tree = Parser.new.parse(@uri_template)
    @template = Transformer.new.apply(tree)
    rescue Parslet::ParseFailed => ex
      raise ParseError, "invalid template: #{uri_template}"
  end

  def expand(params)
    output = ""
    @template.each do |part|
      case part
      when String then output << part
      when Hash   then output << Expression.new(part).expand(params)
      end
    end

    output
  end

  class Expression

    def initialize(tree)
      @tree = tree
    end

    def expand(params = {})
      out = var_list.map do |var|
        Var.new(self, var[:var]).value(params)
      end.compact

      return "" if out.empty?
      first_char + out.join(separator)
    end

    def var_list
      @tree[:var_list]
    end

    def operator
      @tree[:operator]
    end

    def separator
      case operator
        when nil, "+", "#" then ","
        when "."           then "."
        when "/"           then "/"
        when ";"           then ";"
        when "?", "&"      then "&"
      end
    end

    def first_char
      case operator
      when nil, "+" then ""
      else               operator
      end
    end

    def named?
      [";", "?", "&"].include? operator
    end

    def str_if_empty
      case operator
      when "?", "&" then "="
      else ""
      end
    end

    def encode_set
      set = Addressable::URI::CharacterClasses::UNRESERVED
      set += Addressable::URI::CharacterClasses::RESERVED if ["+", "#"].include? operator
      set
    end

  end

  class Var
    attr_reader :exp

    def initialize(exp, tree)
      @exp, @tree = exp, tree
    end

    def value(params)
      value = params[name]

      out = ""
      case value
      when nil
        return nil
      when String
        if exp.named?
          out << "#{encode(name)}#{value.empty? ? exp.str_if_empty : "="}"
        end
        out << encode(trim(value))

      when Array
        if !explode?
          if exp.named?
            out << "#{encode(name)}#{value.empty? ? exp.str_if_empty : "="}"
          end
          return if value.empty?
          out << value.map{|v| encode(v)}.join(",")
        else
          return if value.empty?
          out << value.map{|v| encode(v)}.join(exp.separator)
        end

      when Hash
        if !explode?
          if exp.named?
            out << "#{encode(name)}#{value.empty? ? exp.str_if_empty : "="}"
          end
          return if value.empty?
          out << value.map{|k,v| [encode(k), encode(v)]}.flatten.join(",")
        else
          return if value.empty?
          out << value.map{|k,v| "#{encode(k)}=#{encode(v)}"}.join(exp.separator)
        end

      end

      out
    end

    protected

    def name
      @tree[:name]
    end

    def explode?
      @tree.has_key?(:explode)
    end

    def max_length
      @tree[:max_length]
    end

    def trim(str)
      max_length ? str[0..(max_length-1)] : str
    end

    def encode(str)
      Addressable::URI.encode_component(str, exp.encode_set)
    end


  end

end

