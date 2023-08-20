require "test_helper"

class JobPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get job_posts_index_url
    assert_response :success
  end
end
