class AuthorsController < ApplicationController

  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
    render json: author, status: :created

    # if author.valid?
    #   render json: author, status: :created
    # else
    #   render json: { errors: "Either the author name does not exist or email is invalid" }, status: :unprocessable_entity
    # end

rescue ActiveRecord::RecordInvalid => invalid
  render json: { errors: invalid.record.errors }, status: :unprocessable_entity
end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  
end
