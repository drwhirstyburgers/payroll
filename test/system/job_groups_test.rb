require "application_system_test_case"

class JobGroupsTest < ApplicationSystemTestCase
  setup do
    @job_group = job_groups(:one)
  end

  test "visiting the index" do
    visit job_groups_url
    assert_selector "h1", text: "Job Groups"
  end

  test "creating a Job group" do
    visit job_groups_url
    click_on "New Job Group"

    fill_in "Name", with: @job_group.name
    fill_in "Wage", with: @job_group.wage
    click_on "Create Job group"

    assert_text "Job group was successfully created"
    click_on "Back"
  end

  test "updating a Job group" do
    visit job_groups_url
    click_on "Edit", match: :first

    fill_in "Name", with: @job_group.name
    fill_in "Wage", with: @job_group.wage
    click_on "Update Job group"

    assert_text "Job group was successfully updated"
    click_on "Back"
  end

  test "destroying a Job group" do
    visit job_groups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job group was successfully destroyed"
  end
end
