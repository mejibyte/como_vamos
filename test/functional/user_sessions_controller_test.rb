require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => UserSession.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    UserSession.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    UserSession.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to user_session_url(assigns(:user_session))
  end
  
  def test_edit
    get :edit, :id => UserSession.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    UserSession.any_instance.stubs(:valid?).returns(false)
    put :update, :id => UserSession.first
    assert_template 'edit'
  end
  
  def test_update_valid
    UserSession.any_instance.stubs(:valid?).returns(true)
    put :update, :id => UserSession.first
    assert_redirected_to user_session_url(assigns(:user_session))
  end
  
  def test_destroy
    user_session = UserSession.first
    delete :destroy, :id => user_session
    assert_redirected_to user_sessions_url
    assert !UserSession.exists?(user_session.id)
  end
end
