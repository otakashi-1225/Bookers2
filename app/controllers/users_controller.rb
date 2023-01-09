class UsersController < ApplicationController
  def index
    @new_book = Book.new
    @user = User.find(current_user.id)

    @users = User.all
  end

  def show
    @new_book = Book.new
    @user = User.find(params[:id])

    @books = Book.where(user_id: params[:id])
  end

  def edit
    is_matching_login_user
    @user = User.find(current_user.id)
  end

  def update
    is_matching_login_user
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private

  def is_matching_login_user
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
