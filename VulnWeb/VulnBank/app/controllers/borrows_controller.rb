class BorrowsController < ApplicationController
  before_action :set_borrow, only: [:show, :edit, :update, :destroy, :accept, :decline]
  before_filter :setup_borrow, only: [ :update ]

  # GET /borrows
  # GET /borrows.json
  def index
    @borrows = []
    if current_user.admin?
        @borrows = Borrow.all
    else
        @borrows = Borrow.where(from_account: current_accounts.collect{|x| x.acct_number}) + Borrow.where(to_account: current_accounts.collect{|x| x.acct_number})      
    end
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
  
	@borrow = Borrow.request(borrow_params)
	
	if @borrow.nil?
      flash[:danger] = "Invalid Borrow Request (Nil)"
	  redirect_to :back
	  return
    end
	
	if @borrow.amount < 0
		flash[:danger] = "Invalid Borrow Request (Amount < 0)"
		redirect_to :back
		return
	end
	
	if @borrow.save
		flash[:success] = "Borrow Request Submitted"
		redirect_to @borrow
	else
		flash[:danger] = @borrow.errors.full_messages
		render 'index'
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
  
  def accept
  	@from_account = Account.find_by(acct_number: @borrow.from_account)
  	if @borrow == nil
  		flash[:danger] = "Request Does Not Exist!"
  		redirect_to :back
  	elsif @borrow.amount >= @from_account.balance
  		flash[:danger] = "Insufficient Balance"
  		redirect_to :back
  		return
  	else 
  		@to_account = Account.find_by(acct_number: @borrow.to_account)
  		@from_account = Account.find_by(acct_number: @borrow.from_account)
  		if @from_account.balance < @borrow.amount
  			flash[:danger] = "Insufficient Funds"
  		else 
  			@amount = @borrow.amount
  			new_balance_to = @to_account.balance += @amount
  			new_balance_from = @from_account.balance -= @amount
  			Account.where(acct_number: @borrow.to_account).update_all(balance: new_balance_to)
  			Account.where(acct_number: @borrow.from_account).update_all(balance: new_balance_from)
  			@to_account.save
  			@from_account.save
  			
  			flash[:success] = "Borrow Approved!"
  			Borrow.where(id: @borrow.id).update_all(status: "Complete")
  		end
  	end
  	redirect_to :back
  end
  
  def decline
	if @borrow == nil
		flash[:danger] = "Request Does Not Exist!"
	else
		flash[:success] = "Borrow Declined!"
		Borrow.where(id: @borrow.id).update_all(status: "Declined")
	end
	redirect_to :back
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
      params.require(:borrow).permit(:from_account, :to_account, :requestor, :requestee, :amount, :id)
    end
	
	def setup_borrow
      @user = User.find(session[:user_id])
      @friend = User.find(params[:friend_id])
    end
end
