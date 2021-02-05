require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "responds successfully" do
      get '/'
      expect(response).to be_successful
    end
  end
  describe "#help" do
    it "responds successfully" do
      get help_path
      expect(response).to be_successful
    end
  end
end
