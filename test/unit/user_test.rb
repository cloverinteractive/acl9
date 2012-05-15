require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup { @user = Factory.create :user }

  context "User can be assigned roles" do
    should "be able to be assigned a role" do
      assert @user.has_role!( :admin )
      assert @user.has_role?( :admin )
    end
  end

  context "User can own objects" do
    should "be able to own an object" do
      assert obj = Foo.create!
      assert @user.has_role!( :owner, obj )
      assert @user.has_role?( :owner, obj )
      assert @user.has_role?( :owner )
    end
  end

  context "When protected roles are not global" do
    setup { Acl9.config[:protect_global_roles] = true }

    should "protect global roles" do
      assert obj = Foo.create!
      assert @user.has_role!( :owner, obj )
      assert @user.has_role?( :owner, obj )
      assert ! @user.has_role?( :owner )
    end
  end
end
