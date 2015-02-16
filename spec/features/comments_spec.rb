require 'spec_helper'
require 'rails_helper'

feature "comments" do

  it "shows user comments" do
    create_test_user
    create_test_user("hannibal","ieathumans")
    visit user_url(User.first)
    fill_in "Comment", with: "Test Comment"
    click_on "Create Comment"
    expect(page).to have_content "Test Comment"
  end

  it "shows goal comments" do
    create_test_user
    visit new_user_goal_url(User.first)
    fill_in "Title", with: "Goal 1"
    fill_in "Content", with: "Tight rope walk by 2016"
    choose "Public"
    choose "Incomplete"
    click_on "Create Goal"
    create_test_user("hannibal","ieathumans")
    visit goal_url(Goal.first)
    fill_in "Comment", with: "Test Comment"
    click_on "Create Comment"
    expect(page).to have_content "Test Comment"
  end
end
