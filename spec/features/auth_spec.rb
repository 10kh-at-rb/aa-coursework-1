require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      create_test_user
      expect(page).to have_content "test_user"
    end

  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    create_test_user
    click_on "Sign Out"
    log_in_test_user
    expect(page).to have_content "test_user"
  end

end

feature "logging out" do

  it "begins with logged out state" do
    visit users_url
    expect(page).to have_content "Login"
  end

  it "doesn't show username on the homepage after logout" do
    create_test_user
    click_on "Sign Out"
    expect(page).to_not have_content "test_user"
  end


end
