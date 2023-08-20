class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:show, :update, :destroy]
  load_and_authorize_resource

  def index
    @job_applications = JobApplicationLoader.new(current_user).load
    render json: @job_applications
  end

  def show
    set_application_status_as_seen if current_user.admin?
    render json: @job_application
  end

  def create
    job_post_id = params[:job_post_id]
    job_application_params = {
      job_post_id: job_post_id,
      status: 1,
      user_id: current_user.id
    }

    job_application_creator = JobApplicationCreator.new(job_application_params)

    if job_application_creator.create
      render json: job_application_creator.job_application, status: :created
    else
      render json: job_application_creator.errors, status: :unprocessable_entity
    end
  end

  def update
    def update_job_application_params
      params.require(:job_application).permit(:status)
    end
    if @job_application.update(update_job_application_params)
      render json: @job_application
    else
      render json: @job_application.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job_application.destroy
  end

  private

  def set_application_status_as_seen
    @job_application.update(status: JobApplication.statuses[:seen])
  end

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def job_application_params
    params.require(:job_application).permit(:user_id, :job_post_id, :status)
  end
end

class JobApplicationLoader
  def initialize(user, params = {})
    @user = user
    @params = params
  end

  def load
    if @user.admin?
      JobApplication.all
    else
      JobApplication.where(user: @user)
    end
    end
  end

class JobApplicationCreator
  attr_reader :job_application, :errors

  def initialize(params)
    @params = params
    @errors = []
  end

  def create
    @job_application = JobApplication.new(@params)

    if @job_application.save
      true
    else
      @errors = @job_application.errors.full_messages
      false
    end
  end
end
