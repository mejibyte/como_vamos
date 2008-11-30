require 'test_helper'

class JudgesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Judge.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Judge.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Judge.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to judge_url(assigns(:judge))
  end
  
  def test_edit
    get :edit, :id => Judge.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Judge.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Judge.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Judge.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Judge.first
    assert_redirected_to judge_url(assigns(:judge))
  end
  
  def test_destroy
    judge = Judge.first
    delete :destroy, :id => judge
    assert_redirected_to judges_url
    assert !Judge.exists?(judge.id)
  end
end
