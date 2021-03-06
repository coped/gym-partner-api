require 'test_helper'

class Api::AuthControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:first_user)
        @auth_header = auth_header(@user)
    end

    test 'should respond with JWT and user when provided with correct credentials' do
        post api_v1_login_path, params: { login: { email: @user.email,
                                                 password: 'foobar' } }
        assert_equal 'success', json_response['status']
        assert_includes json_response['payload'], 'jwt'
    end

    test 'should not respond with JWT and user when provided with incorrect credentials' do
        post api_v1_login_path, params: { login: { email: 'nonexistent@email.com',
                                                 password: 'foobar' } }
        assert_equal 'error', json_response['status']
        assert json_response['messages'].present?
        assert_nil json_response['payload']
    end

    test 'should response with success upon delete' do
        delete api_v1_logout_path, headers: @auth_header
        assert_equal 'success', json_response['status']
    end
end