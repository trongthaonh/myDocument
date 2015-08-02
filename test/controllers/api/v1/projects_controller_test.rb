require 'test_helper'

class API::V1::ProjectsControllerTest < ActionController::TestCase
  setup do
    @api_v1_project = api_v1_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_v1_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_project" do
    assert_difference('API::V1::Project.count') do
      post :create, api_v1_project: { comment: @api_v1_project.comment, name: @api_v1_project.name }
    end

    assert_redirected_to api_v1_project_path(assigns(:api_v1_project))
  end

  test "should show api_v1_project" do
    get :show, id: @api_v1_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_project
    assert_response :success
  end

  test "should update api_v1_project" do
    patch :update, id: @api_v1_project, api_v1_project: { comment: @api_v1_project.comment, name: @api_v1_project.name }
    assert_redirected_to api_v1_project_path(assigns(:api_v1_project))
  end

  test "should destroy api_v1_project" do
    assert_difference('API::V1::Project.count', -1) do
      delete :destroy, id: @api_v1_project
    end

    assert_redirected_to api_v1_projects_path
  end
end
