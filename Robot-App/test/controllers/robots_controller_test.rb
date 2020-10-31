require 'test_helper'

class RobotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @robot = robots(:one)
  end

  test "should get index" do
    get robots_url
    assert_response :success
  end

  test "should get new" do
    get new_robot_url
    assert_response :success
  end

  test "should create robot" do
    assert_difference('Robot.count') do
      post robots_url, params: { robot: { is_placed: @robot.is_placed, table_cordinate: @robot.table_cordinate } }
    end

    assert_redirected_to robot_url(Robot.last)
  end

  test "should show robot" do
    get robot_url(@robot)
    assert_response :success
  end

  test "should get edit" do
    get edit_robot_url(@robot)
    assert_response :success
  end

  test "should update robot" do
    patch robot_url(@robot), params: { robot: { is_placed: @robot.is_placed, table_cordinate: @robot.table_cordinate } }
    assert_redirected_to robot_url(@robot)
  end

  test "should destroy robot" do
    assert_difference('Robot.count', -1) do
      delete robot_url(@robot)
    end

    assert_redirected_to robots_url
  end
end
