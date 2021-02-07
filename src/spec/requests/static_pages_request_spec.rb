require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "#home" do
    it "responds successfully" do
      get root_path
      expect(response).to be_successful
    end
  end
  describe "#help" do
    it "responds successfully" do
      get help_path
      expect(response).to be_successful
    end
  end
  describe "#about" do
    it "responds successfully" do
      get about_path
      expect(response).to be_successful
    end
  end

  describe "link in home" do
    before do
      visit root_path
    end
    it "help link" do
      expect(page).to have_link 'ヘルプ'
    end
    it "about link" do
      expect(page).to have_link 'このサイトについて'
    end
    it "user new link" do
      expect(page).to have_link '会員登録'
    end
  end
end
