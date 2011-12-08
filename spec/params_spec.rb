require 'spec_helper'

describe URITemplate do

  describe "params" do
    let(:template) { URITemplate.new("{foo}") }

    it "should handle string keys" do
      template.expand("foo" => "bar").should == "bar"
    end

    it "should handle symbol keys" do
      template.expand(:foo  => "bar").should == "bar"
    end
  end

end
