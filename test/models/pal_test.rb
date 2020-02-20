require 'test_helper'

class PalTest < ActiveSupport::TestCase
  test "should not create pal" do
    pal = Pal.new
    assert !pal.save
  end

  test 'should find article' do
    assert !Pal.exists?(:count => 'Яблоко')
  end

  test 'shoud not save with save fields' do
    pal = Pal.new
    pal.count = 'Франция'
    assert pal.save
  end
end

class UserTest < ActiveSupport::TestCase
  test 'should find user' do
    assert !User.exists?( email: 'test@mail.ru', encrypted_password: '123456')
  end
end
