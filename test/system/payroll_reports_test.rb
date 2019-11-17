require "application_system_test_case"

class PayrollReportsTest < ApplicationSystemTestCase
  setup do
    @payroll_report = payroll_reports(:one)
  end

  test "visiting the index" do
    visit payroll_reports_url
    assert_selector "h1", text: "Payroll Reports"
  end

  test "creating a Payroll report" do
    visit payroll_reports_url
    click_on "New Payroll Report"

    fill_in "Date", with: @payroll_report.date
    fill_in "Employee", with: @payroll_report.employee_id
    fill_in "Hours worked", with: @payroll_report.hours_worked
    fill_in "Job groub", with: @payroll_report.job_groub
    fill_in "Report", with: @payroll_report.report_id
    click_on "Create Payroll report"

    assert_text "Payroll report was successfully created"
    click_on "Back"
  end

  test "updating a Payroll report" do
    visit payroll_reports_url
    click_on "Edit", match: :first

    fill_in "Date", with: @payroll_report.date
    fill_in "Employee", with: @payroll_report.employee_id
    fill_in "Hours worked", with: @payroll_report.hours_worked
    fill_in "Job groub", with: @payroll_report.job_groub
    fill_in "Report", with: @payroll_report.report_id
    click_on "Update Payroll report"

    assert_text "Payroll report was successfully updated"
    click_on "Back"
  end

  test "destroying a Payroll report" do
    visit payroll_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Payroll report was successfully destroyed"
  end
end
