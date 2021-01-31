require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end
  
  test "should get home" do
    get root_path
    assert_response :success
    # assert_select "title", "Ruby on Rails Tutorial Sample App"
  end
  test "should get about" do
    get about_path
    assert_response :success
    # assert_select "title", "Ruby on Rails Tutorial Sample App"
  end
  test "should get help" do
    get help_path
    assert_response :success
    # assert_select "title", "Ruby on Rails Tutorial Sample App"
  end
end
