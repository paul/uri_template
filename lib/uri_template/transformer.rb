class UriTemplate::Transformer < Parslet::Transformer

  rule(:string => simple(:st)) { st.to_s }

  rule(:var    => simple(:var)) { var.to_s }

end

