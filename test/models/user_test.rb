require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
  	@user = User.new( name: 'Test User', email: 'testuser@test.com' , password: 'password' , password_confirmation: 'password' )
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = '     '
  	assert_not @user.valid?
  end

  test "name should be 50 or fewer characters" do
  	@user.name = '012345678901234567890123456789012345678901234567890123456789' # 60 characters long
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "     "
  	assert_not @user.valid?
  end

  test "email should be 255 or fewer characters" do
  	@user.email = 'x'*244 + '@example.com' # for a total of 256 characters
  	assert_not @user.valid?
  end

  test "email validation should accept vaild addresses" do
  	valid_addresses = %w[ user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn ]

  	valid_addresses.each do |valid_address|
  	  @user.email = valid_address
  	  assert @user.valid?, "#{valid_address.inspect} should be valid"
  	end
  end

  test "email validation should reject invalid addresses" do
  	invalid_addresses = %w[ user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com ]

  	invalid_addresses.each do |invalid_address|
  	  @user.email = invalid_address
  	  assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
  	end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save # saves @user so that when duplicate_user is tested an entry with idenical email already exists
    assert_not duplicate_user.valid?
  end

  test "email addresses should be unique and case insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save # saves @user so that when duplicate_user is tested an entry with idenical email already exists
    assert_not duplicate_user.valid?
  end

  test "password should be present and non-blank" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "x"*5
    assert_not @user.valid?
  end
end
