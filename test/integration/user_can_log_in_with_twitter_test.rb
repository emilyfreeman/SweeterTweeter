require "test_helper"
class UserCanLogInWithTwitter < ActionDispatch::IntegrationTest
  include Capybara::DSL
  def setup
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  test "user can log in with navbar link" do
    User.stub_any_instance(:name, "Clara") do
      visit root_path

      assert_equal 200, page.status_code

      click_link "Login"

      assert_equal root_path, current_path
      assert page.has_content? "Clara"
      assert page.has_link? "Logout"
    end
  end

  test "user can log in with button" do
    User.stub_any_instance(:name, "Clara") do
      visit root_path

      assert_equal 200, page.status_code

      click_button "Login"

      assert_equal root_path, current_path
      assert page.has_content? "Clara"
      assert page.has_link? "Logout"
    end
  end

  test "user can log out" do
    User.stub_any_instance(:name, "Clara") do
      visit root_path

      assert_equal 200, page.status_code

      click_link "Login"

      click_link "Logout"

      assert_equal root_path, current_path
      assert page.has_link? "Login"
    end
  end

  def stub_omniauth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter',
        extra: {
          raw_info: {
            user_id: "013084",
            name: "Clara",
            screen_name: "missclaraelinor"
          }
        },
        credentials: {
          token: "beautiful",
          secret: "favorite"
        }
      })
  end

end
