require 'parslet'

class URITemplate
  class Transformer < Parslet::Transform

    rule(:literals => simple(:l)) { l.to_s }
    rule(:string   => simple(:s)) { s.to_s }

    rule(:array => subtree(:ar)) { ar.is_a?(Array) ? ar : [ar] }

    rule(:explode) { true }

    #rule(:name    => simple(:name)) { name.to_s }

    rule(:number => simple(:x)) { Integer(x) }

  end
end

