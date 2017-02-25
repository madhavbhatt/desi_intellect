class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy]

  # GET /borrows
  # GET /borrows.json
  def index
    @borrows = Borrow.all
  end

  # GET /borrows/1
  # GET /borrows/1.json
  def show
  end

  # GET /borrows/new
  def new
    @borrow = Borrow.new
  end

  # GET /borrows/1/edit
  def edit
  end

  # POST /borrows
  # POST /borrows.json
  def create
    @borrow = Borrow.new(borrow_params)

    respond_to do |format|
      if @borrow.save
        format.html { redirect_to @borrow, notice: 'Borrow was successfully created.' }
        format.json { render :show, status: :created, location: @borrow }
      else
        format.html { render :new }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /borrows/1
  # PATCH/PUT /borrows/1.json
  def update
    respond_to do |format|
      if @borrow.update(borrow_params)
        format.html { redirect_to @borrow, notice: 'Borrow was successfully updated.' }
        format.json { render :show, status: :ok, location: @borrow }
      else
        format.html { render :edit }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrows/1
  # DELETE /borrows/1.json
  def destroy
    @borrow.destroy
    respond_to do |format|
      format.html { redirect_to borrows_url, notice: 'Borrow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_borrow
      @borrow = Borrow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def borrow_params
      params.require(:borrow).permit(:from, :to, :date, :admin_id, :status, :amount, :date)
    end
end
