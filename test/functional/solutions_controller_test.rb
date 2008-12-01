require 'test_helper'

class SolutionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Solution.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Solution.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Solution.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to solution_url(assigns(:solution))
  end
  
  def test_edit
    get :edit, :id => Solution.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Solution.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Solution.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Solution.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Solution.first
    assert_redirected_to solution_url(assigns(:solution))
  end
  
  def test_destroy
    solution = Solution.first
    delete :destroy, :id => solution
    assert_redirected_to solutions_url
    assert !Solution.exists?(solution.id)
  end
end
