class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
  	@book = Book.new
  	@user = current_user
  	@books = @user.books
  end

  def show
    @book = Book.new
    @book_id = Book.find(params[:id])
    @user = @book_id.user
  end

  def index
  	@book = Book.new
  	@books = Book.all
  	@user = current_user
  end

  def create
  	@book = Book.new(book_params)
  	@books = Book.all
  	@book.user_id = current_user.id
  	@user = current_user
  	if @book.save
  	  redirect_to book_path(@book.id), notice: "Book was successfully created."
  	else render action: :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book_id = Book.find(params[:id])
    @user = @book_id.user
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    end
  end

  def correct_user
    @book_id = Book.find(params[:id])
    @user = @book_id.user
    redirect_to books_path unless @user == current_user
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end


end
