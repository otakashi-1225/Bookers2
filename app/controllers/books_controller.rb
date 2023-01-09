class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @user = User.find(current_user.id)

    @books = Book.all
    @users = User.all

  end

  def show
    @new_book = Book.new

    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)

  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "successfully Create book!!"
      redirect_to book_path(@new_book.id)
    else
      @user = User.find(current_user.id)

      @books = Book.all
      @users = User.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    is_matching_login_user
  end

  def update
    @book = Book.find(params[:id])
    is_matching_login_user
    if @book.update(book_params)
      flash[:notice] = "successfully Update!!"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    is_matching_login_user
    if @book.destroy
      flash[:notice] = "successfully Destroy!!"
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end

  private

  def is_matching_login_user
    user_id = @book.user_id.to_i
    unless user_id == current_user.id
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
