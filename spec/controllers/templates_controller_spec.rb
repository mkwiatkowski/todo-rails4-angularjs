require 'spec_helper'

describe TemplatesController do
  describe "#index" do
    it "should return 200 for the template" do
      get :index
      response.should be_ok
    end
  end
end
