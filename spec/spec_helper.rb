
RSpec.configure do |config|


  config.expect_with :rspec do |expectations|


    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|


    mocks.verify_partial_doubles = true
  end

end


def create_test_user(username="test_user", password="test_password")
  visit new_user_url
  fill_in "Username", with: username
  fill_in "Password", with: password
  click_on "Create User"
end

def log_in_test_user
  visit new_session_url
  fill_in "Username", with: "test_user"
  fill_in "Password", with: "test_password"
  click_on "Sign In"
end
