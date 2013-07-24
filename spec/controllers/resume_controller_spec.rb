require 'spec_helper'

describe ResumeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'tag'" do
    it "returns http success" do
      get 'tag'
      response.should be_success
    end
  end

end
