require 'spec_helper'

describe UriTemplate do

  describe "params" do
    let(:template) { UriTemplate.new("{foo}") }

    it "should handle string keys" do
      template.expand("foo" => "bar").should == "bar"
    end

    it "should handle symbol keys" do
      template.expand(:foo  => "bar").should == "bar"
    end
  end

end
