class BooksController < ApplicationController
  before_action :find_books, only: [ :show, :edit, :update, :destroy]

  def index
    @books = Book.all.order("created_at DESC")
  end

  def new
    @book = Book.new
  end

  def edit

  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render 'edit'
    end
  end

  def destroy

  end

  def show
    @book = Book.find(params[:id])
  end

  def find_books
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  protected
    def book_params
      params.require(:book).permit(:title, :description, :author)
    end
end

