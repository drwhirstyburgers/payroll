class JobGroupsController < ApplicationController
  before_action :set_job_group, only: [:show, :edit, :update, :destroy]

  # GET /job_groups
  # GET /job_groups.json
  def index
    @job_groups = JobGroup.all
  end

  # GET /job_groups/1
  # GET /job_groups/1.json
  def show
  end

  # GET /job_groups/new
  def new
    @job_group = JobGroup.new
  end

  # GET /job_groups/1/edit
  def edit
  end

  # POST /job_groups
  # POST /job_groups.json
  def create
    @job_group = JobGroup.new(job_group_params)

    respond_to do |format|
      if @job_group.save
        format.html { redirect_to @job_group, notice: 'Job group was successfully created.' }
        format.json { render :show, status: :created, location: @job_group }
      else
        format.html { render :new }
        format.json { render json: @job_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_groups/1
  # PATCH/PUT /job_groups/1.json
  def update
    respond_to do |format|
      if @job_group.update(job_group_params)
        format.html { redirect_to @job_group, notice: 'Job group was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_group }
      else
        format.html { render :edit }
        format.json { render json: @job_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_groups/1
  # DELETE /job_groups/1.json
  def destroy
    @job_group.destroy
    respond_to do |format|
      format.html { redirect_to job_groups_url, notice: 'Job group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_group
      @job_group = JobGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_group_params
      params.require(:job_group).permit(:name, :wage)
    end
end
