require 'spec_helper'

RSpec.describe "static_pages" do
  describe "Home page" do
    it "should have the content 'home'" do
      visit root_path
      expect(page).to have_content("200")
    end
  end
  describe "help page" do
    it "should have the content 'help'" do
      visit help_path
      expect(page).to have_content("200")
    end
  end
  describe "content page" do
    it "should have the content 'content'" do
      visit '/content'
      # expect(page).to have_content("200")
    end
  end
end

    