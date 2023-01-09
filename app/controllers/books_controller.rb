class BooksController < ApplicationController
  def index
    @new_book = Book.new
    @user = User.find(current_user.id)

    @books = Book.all
    @users = User.all

  end

  def show
    @new_book = Book.new
    @user = User.find(current_user.id)

    @books = Book.find(current_user.id)
  end

  def create
    @book  = Book.new(book_params)
    if @book.save
      flash[:notice] = "successfully Create book!!"
      redirect_to book_path(@book.id)
    else
      @new_book = Book.new
      @user = User.find(current_user.id)

      @books = Book.all
      @users = User.all
      render :index
    end
  end
  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully Update!!"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "successfully Destroy!!"
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
