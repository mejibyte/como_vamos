require 'test_helper'

class SolutionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solution" do
    assert_difference('Solution.count') do
      post :create, :solution => { }
    end

    assert_redirected_to solution_path(assigns(:solution))
  end

  test "should show solution" do
    get :show, :id => solutions(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => solutions(:one).id
    assert_response :success
  end

  test "should update solution" do
    put :update, :id => solutions(:one).id, :solution => { }
    assert_redirected_to solution_path(assigns(:solution))
  end

  test "should destroy solution" do
    assert_difference('Solution.count', -1) do
      delete :destroy, :id => solutions(:one).id
    end

    assert_redirected_to solutions_path
  end
end
