class UsersController < ApplicationController
  def index
    @new_book = Book.new
    @user = User.find(current_user.id)

    @users = User.all
  end

  def show
    @new_book = Book.new
    @user = User.find(current_user.id)

    @books = Book.all
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
