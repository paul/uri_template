class UriTemplate::Parser < Parslet::Parser

  rule(:uri_template) do
    uri_element.repeat(1)
  end

  rule(:uri_element) do
    expansion | uri_part
  end

  rule(:expansion) do
    str('{') >> operator.maybe.as(:operator) >> (var_list | var) >> str('}')
  end

  rule(:operator) do
    str('?')
  end

  rule(:var_list) do
    (var >> ( str(",") >> var ).repeat(1)).as(:list)
  end

  rule(:var) do
    match('[a-zA-Z0-9]').repeat(1).as(:var)
  end

  rule(:uri_part) do
    (unreserved | reserved | pct_encoded).repeat(1).as(:string)
  end

  rule(:unreserved) do
    alphanumeric | match("[-._~]")
  end

  rule(:alphanumeric) do
    match('[A-Za-z0-9]')
  end

  rule(:reserved) do
    match("[:/?#\\[\\]@!$&'()*+,;=]")
  end

  rule(:pct_encoded) do
    str('%') >> hex >> hex
  end

  rule(:hex) do
    match('[a-fA-F0-9]')
  end

  root(:uri_template)

end

