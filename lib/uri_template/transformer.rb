require 'parslet'

class URITemplate
  class Transformer < Parslet::Transform

    rule(:string => simple(:st)) { st.to_s }

    rule(:var    => simple(:var)) { var.to_s }

  end
end

