require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:michael)
  end

  test "should get index" do
    sign_in @user
    get posts_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    sign_in @user
    assert_difference('Post.count') do
    post posts_url, params: { post: { body: "some text" } }
  end

    assert_redirected_to root_url
  end

  test "should show post" do
    sign_in @user
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_post_url(@post)
    assert_response :success
  end


  test "should destroy post" do
    sign_in @user
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end
end
