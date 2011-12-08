require 'parslet'

class URITemplate
  class Parser < Parslet::Parser

    rule(:uri_template) do
      (literals | expression).repeat
    end

    rule(:expression) do
      str('{') >> operator.maybe.as(:operator) >> var_list.as(:var_list) >> str('}')
    end

    rule(:operator) do
      str("+") | str("#") | str(".") | str("/") | str(";") | str("?") | str("&")
    end

    rule(:var_list) do
      (varspec >> ( str(",") >> varspec ).repeat).maybe.as(:array)
    end

    rule(:varspec) do
      (varname >> modifier.maybe).as(:var)
    end

    rule(:varname) do
      ((varchar >> (varchar | str(".")).repeat).as(:string)).as(:name)
    end

    rule(:varchar) do
      (alphanumeric | str("_") | pct_encoded)
    end

    rule(:modifier) do
      prefix | explode
    end

    rule(:prefix) do
      str(':') >> number.as(:max_length)
    end

    rule(:explode) do
      str('*').as(:explode)
    end

    rule(:literals) do
      (unreserved | reserved | pct_encoded).repeat(1).as(:literals)
    end

    rule(:unreserved) do
      alphanumeric | match("[-._~]")
    end

    rule(:reserved) do
      match("[:/?#\\[\\]@!$&'()*+,;=]")
    end

    rule(:pct_encoded) do
      str('%') >> hex >> hex
    end

    rule(:alphanumeric) do
      match('[A-Za-z0-9]')
    end

    rule(:number) do
      match('[0-9]').repeat(1).as(:number)
    end

    rule(:hex) do
      match('[a-fA-F0-9]')
    end

    root(:uri_template)

  end
end

