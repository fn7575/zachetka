require 'test_helper'

class PalsControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to log in' do
    get '/pals/input', params: { v1: 10 }
    assert_response :redirect
    post new_user_session_path, params: { email: 'test@mail.ru', password: '123456' }
  end

end

