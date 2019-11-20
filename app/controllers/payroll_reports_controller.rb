class PayrollReportsController < ApplicationController
  require 'report_organizer'
  include ReportOrganizer
  require 'update_user_jg'
  include UpdateUserJg
  require 'payroll_math'
  include PayrollMath
  require 'json'

  before_action :set_payroll_report, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token 

  # GET /payroll_reports
  # GET /payroll_reports.json
  def index
    @payroll_reports = PayrollReport.all.order(created_at: :desc)
  end

  # GET /payroll_reports/1
  # GET /payroll_reports/1.json
  def show
    @payroll_report = PayrollReport.includes(:rows).find(params[:id])
    @row_data = @payroll_report.rows.order(:id)
  end

  # GET /payroll_reports/new
  def new
    @payroll_report = PayrollReport.new
  end

  # GET /payroll_reports/1/edit
  def edit
  end

  # POST /payroll_reports
  # POST /payroll_reports.json
  def create
    name = params[:name]
    csv = params[:csv]
    csv = eval(csv)

    report_id = get_report_id(csv)
    employee_ids = get_employee_ids(csv)
    generate_new_employees(employee_ids)
    report_uniq_check = PayrollReport.find_by(report_id: report_id)
    if report_uniq_check.present?
      render json: "exists".to_json, status: :unprocessable_entity
    else
      @payroll_report = PayrollReport.new(name: name, report_id: report_id)
      
      organize_report(csv, @payroll_report)
      
      if @payroll_report.save!
        redirect_to payroll_reports_path
      else
        render :new
      end
    end
  end

  # PATCH/PUT /payroll_reports/1
  # PATCH/PUT /payroll_reports/1.json
  def update
    respond_to do |format|
      if @payroll_report.update(payroll_report_params)
        format.html { redirect_to @payroll_report, notice: 'Payroll report was successfully updated.' }
        format.json { render :show, status: :ok, location: @payroll_report }
      else
        format.html { render :edit }
        format.json { render json: @payroll_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payroll_reports/1
  # DELETE /payroll_reports/1.json
  def destroy
    @payroll_report.destroy
    respond_to do |format|
      format.html { redirect_to payroll_reports_url, notice: 'Payroll report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_job_groups
    job_groups = params[:job_groups]

    new_job_groups = find_if_job_group_exists_and_create_new(job_groups)

    if new_job_groups.present?
      render json: new_job_groups.to_json, status: :ok
    else
      render json: "exists".to_json, status: :ok
    end
  end

  def update_job_groups
    job_groups = eval(params[:job_groups])
    if check_values_of_job_groups(job_groups)
      update_existing_job_groups(job_groups)
      render json: "done".to_json, status: :ok
    else
      render json: "blanks".to_json, status: :unprocessable_entity
    end
  end

  def get_data
    @report_data = Row.where(payroll_report_id: params[:id])
    wage_data = returns_all_calculations_as_hash(@report_data)
    return_hash = {}
    return_hash[:wage_data] = wage_data
    return_hash[:report_data] = @report_data.order(:employee_id)
    render json: return_hash.to_json, status: :ok
  end

  def sum_of_employee_hours
    report = PayrollReport.includes(:rows).find(params[:report_id])
    employee = Employee.find_by(employee_id: params[:employee_id])
    job_group = JobGroup.find_by(name: params[:job_group])
    return_hash = total_hours_worked_and_money_owed(report.rows, employee, job_group)
    render json: return_hash.to_json, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payroll_report
      @payroll_report = PayrollReport.find(params[:id])
    end

    def get_employee_ids(csv)
      return csv.map { |i| i[:employee_id] if i[:employee_id].present? }.uniq.delete_if { |x| x == nil}
    end 

    def get_job_groups(csv)
      return csv.map { |r| r[:job_group] }.delete_if { |j| j == nil || j == ''}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payroll_report_params
      params.require(:payroll_report).permit(:name, :csv)
    end
end
