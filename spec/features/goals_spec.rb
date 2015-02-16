require 'spec_helper'
require 'rails_helper'

feature "the goal creation process" do

  it "shows user goals" do
    create_test_user
    visit user_goals_url(User.first)
    expect(page).to have_content "Goals"
  end

  it "redirects from goals if not logged in" do
    create_test_user
    click_on "Sign Out"
    visit user_goals_url(User.first)
    expect(page).to have_content "Login"
    expect(page).to_not have_content "Goals"
  end

  feature "creating a new goal" do

    it "can create a goal" do
      create_test_user
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 1"
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      expect(page).to have_content "Goal 1"
      expect(page).to have_content "Tight rope walk by 2016"
    end

    it "prints out errors for validations" do
      create_test_user
      visit new_user_goal_url(User.first)
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      expect(page).to have_content "Title can't be blank"
    end

  end

  feature "editing a goal" do

    it "can edit a goal" do
      create_test_user
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 1"
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      id = Goal.last.id
      click_link "edit-#{id}"
      fill_in "Content", with: "Tight rope walk by 2017"
      click_on "Edit Goal"
      expect(page).to have_content "Goal 1"
      expect(page).to have_content "Tight rope walk by 2017"
    end

    it "won't see edit for another user's goal" do
      create_test_user("hannibal","ieathumans")
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 1"
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      create_test_user
      visit user_goals_url(User.first)
      expect(page).to_not have_content "Edit"
    end

    it "can't edit another user's goal" do
      create_test_user("hannibal","ieathumans")
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 1"
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      id = Goal.last.id
      create_test_user
      visit edit_goal_url(id)
      expect(page).to_not have_content "Edit Goal"
    end

  end

  feature "deleting a goal" do
    it "can delete a goal" do
      create_test_user
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 1"
      fill_in "Content", with: "Tight rope walk by 2016"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      visit new_user_goal_url(User.first)
      fill_in "Title", with: "Goal 2"
      fill_in "Content", with: "Teach cat to drive"
      choose "Public"
      choose "Incomplete"
      click_on "Create Goal"
      id = Goal.first.id
      click_on "delete-#{id}"
      expect(page).to_not have_content "Goal 1"
      expect(page).to_not have_content "Tight rope walk by 2016"
      expect(page).to have_content "Goal 2"
      expect(page).to have_content "Teach cat to drive"
    end
  end

  feature "private goals are not accessible to other users" do

    it "can't see private goals of another user" do
    end

  end


end
