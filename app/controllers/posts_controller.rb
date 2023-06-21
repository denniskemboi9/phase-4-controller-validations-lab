class PostsController < ApplicationController
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprecedented_entity

  def show
    post = Post.find(params[:id])
    
    render json: post
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post

  # # Its impossible to use custom errors here
  # rescue ActiveRecord::RecordInvalid => Invalid
  #   render json: {error: "The update is invalid"}, status: :unprocessable_entity

  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  # def render_unprecedented_entity
  #   render json: {error: "Post you're trying to update does not exist"}, status: :not_found
  # end

end
