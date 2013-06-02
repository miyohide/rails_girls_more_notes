require 'test_helper'

class SavingsControllerTest < ActionController::TestCase
  setup do
    @saving = savings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:savings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create saving" do
    assert_difference('Saving.count') do
      post :create, saving: { date: @saving.date, price: @saving.price }
    end

    assert_redirected_to saving_path(assigns(:saving))
  end

  test "should show saving" do
    get :show, id: @saving
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @saving
    assert_response :success
  end

  test "should update saving" do
    put :update, id: @saving, saving: { date: @saving.date, price: @saving.price }
    assert_redirected_to saving_path(assigns(:saving))
  end

  test "should destroy saving" do
    assert_difference('Saving.count', -1) do
      delete :destroy, id: @saving
    end

    assert_redirected_to savings_path
  end
end
