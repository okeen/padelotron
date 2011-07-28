require 'spec_helper'

describe ConfirmationsController do

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'do_confirmation'" do
    it "should be successful" do
      get 'do_confirmation'
      response.should be_success
    end
  end

end
