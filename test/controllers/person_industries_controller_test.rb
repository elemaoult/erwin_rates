require 'test_helper'

class PersonIndustriesControllerTest < ActionDispatch::IntegrationTest
  test "should get person_technologies" do
    get person_industries_person_technologies_url
    assert_response :success
  end

  test "should get person_expertises" do
    get person_industries_person_expertises_url
    assert_response :success
  end

end
