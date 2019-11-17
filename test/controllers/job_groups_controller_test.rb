require 'test_helper'

class JobGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_group = job_groups(:one)
  end

  test "should get index" do
    get job_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_job_group_url
    assert_response :success
  end

  test "should create job_group" do
    assert_difference('JobGroup.count') do
      post job_groups_url, params: { job_group: { name: @job_group.name, wage: @job_group.wage } }
    end

    assert_redirected_to job_group_url(JobGroup.last)
  end

  test "should show job_group" do
    get job_group_url(@job_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_group_url(@job_group)
    assert_response :success
  end

  test "should update job_group" do
    patch job_group_url(@job_group), params: { job_group: { name: @job_group.name, wage: @job_group.wage } }
    assert_redirected_to job_group_url(@job_group)
  end

  test "should destroy job_group" do
    assert_difference('JobGroup.count', -1) do
      delete job_group_url(@job_group)
    end

    assert_redirected_to job_groups_url
  end
end
