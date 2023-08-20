class JobPostsController < ApplicationController
  before_action :set_job_post, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /job_posts
  def index
    def apply_filters(query, filters)
    if filters[:title]
      query = query.where("title ILIKE ?", "%#{filters[:title]}%")
    end
    query
  end
    @job_posts = apply_filters(JobPost.all, filter_params)
    render json: @job_posts
  end

  # GET /job_posts/1
  def show
    render json: @job_post
  end

  # POST /job_posts
def create
  @job_post = JobPost.new(job_post_params)
  if @job_post.save
    render json: @job_post, status: :created, location: @job_post
  else
    render json: @job_post.errors, status: :unprocessable_entity
  end
end

  # PATCH/PUT /job_posts/1
  def update
    if @job_post.update(job_post_params)
      render json: @job_post
    else
      render json: @job_post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /job_posts/1
  def destroy
    @job_post.job_applications.destroy_all
    @job_post.destroy
    head :no_content
  end


  private
    def set_job_post
      @job_post = JobPost.find_by(id: params[:id])
      unless @job_post
        render json: { error: 'Not found' }, status: :not_found
      end
    end

    def job_post_params
      params.require(:job_post).permit(:title, :description)
    end

    def filter_params
      params.permit(:title, :created_at)
    end
end
