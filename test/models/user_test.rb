require 'test_helper'

describe User do
  before do
    @user = users(:avi)
  end

  describe "attribute validations" do

    it "is invalid without first name" do
      @user.first_name = nil
      assert_not @user.valid?
    end

    it "is invalid without last name" do
      @user.last_name = nil
      assert_not @user.valid?
    end

    it "is invalid without email address" do
      @user.email = nil
      assert_not @user.valid?
    end

    it "is invalid if email address is not unique" do
      @user.email = "admin@admin.com"
      assert_not @user.valid?
    end

  end

end