require 'test_helper'

class PayrollReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payroll_report = payroll_reports(:one)
  end

  test "should get index" do
    get payroll_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_payroll_report_url
    assert_response :success
  end

  test "should create payroll_report" do
    assert_difference('PayrollReport.count') do
      post payroll_reports_url, params: { payroll_report: { date: @payroll_report.date, employee_id: @payroll_report.employee_id, hours_worked: @payroll_report.hours_worked, job_groub: @payroll_report.job_groub, report_id: @payroll_report.report_id } }
    end

    assert_redirected_to payroll_report_url(PayrollReport.last)
  end

  test "should show payroll_report" do
    get payroll_report_url(@payroll_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_payroll_report_url(@payroll_report)
    assert_response :success
  end

  test "should update payroll_report" do
    patch payroll_report_url(@payroll_report), params: { payroll_report: { date: @payroll_report.date, employee_id: @payroll_report.employee_id, hours_worked: @payroll_report.hours_worked, job_groub: @payroll_report.job_groub, report_id: @payroll_report.report_id } }
    assert_redirected_to payroll_report_url(@payroll_report)
  end

  test "should destroy payroll_report" do
    assert_difference('PayrollReport.count', -1) do
      delete payroll_report_url(@payroll_report)
    end

    assert_redirected_to payroll_reports_url
  end
end
