require 'spec_helper'
require 'rails_helper'

feature "the goal creation process" do

  it "shows user goals" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  it "redirects from goals if not logged in" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "creating a new goal" do

    it "shows username on the homepage after signup" do
      create_test_user
      expect(page).to have_content "test_user"
    end

  end

end
