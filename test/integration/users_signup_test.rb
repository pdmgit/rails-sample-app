require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid signup" do
  	
  	get signup_path

  	assert_no_difference 'User.count' do
  		post users_path, user: { 	name: "",
  									email: "invalid.email@address",
  									password: "foo",
  									password_confirmation: "bar" }
  	end

  	assert_template 'users/new'
  	assert_select 'div#error_explanation'
  end

  test "valid signup" do

    get signup_path

    assert_difference 'User.count' do
      post_via_redirect users_path, user: {   name: "Valid Submission",
                    email: "vaild.submission@example.com",
                    password: "password",
                    password_confirmation: "password" }
    end

    assert_template 'users/show'
    assert_select 'div.alert-success'
  end
end
