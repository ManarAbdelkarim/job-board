require "test_helper"

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get job_application_index_url
    assert_response :success
  end
end
