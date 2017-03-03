class DepositsController < ApplicationController
  before_action :set_deposit, only: [:show, :edit, :update, :destroy, :approve]
  before_filter :setup_deposit

                  # GET /deposits
  # GET /deposits.json
  def index
    @deposits = []
    if current_user.admin?
        @deposits = Deposit.all
    else
        @deposits = Deposit.where(user_id: current_accounts.collect{|x| x.acct_number})
    end
  end

  # GET /deposits/1
  # GET /deposits/1.json
  def show
  end

  # GET /deposits/new
  def new
    @deposit = Deposit.new
  end

  # GET /deposits/1/edit
  def edit
  end

  # POST /deposits
  # POST /deposits.json
  def create
    @deposit = Deposit.new(deposit_params) 
    if @deposit.nil? || @deposit.amount < 0
      flash[:danger] = "No Deposit request passed to controller"
	  redirect_to :back
	  return
    else
      Deposit.request(@user, User.find(1))
    end
    
    if @deposit.amount.nil?
      flash[:danger] = "Invalid Deposit: No Amount"
      redirect_to "/deposits/new"
      return
    end
    
    respond_to do |format|
      if @deposit.save
        format.html { redirect_to @deposit, notice: 'Your request  has been sent. Pending Approval from the admin.' }
        format.json { render :show, status: :created, location: @deposit }
      else
        format.html { render :new }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def approve
     @account = Account.find_by_sql("SELECT * FROM accounts WHERE acct_number = id".gsub("id", @deposit.user_id.to_s))[0]
     new_balance = @account.balance += @deposit.amount
     Account.where(acct_number: @deposit.user_id).update_all(balance: new_balance)
     @account.save
            
     Deposit.where(:id => params[:id]).update_all(status: 'APPROVED')
     @deposit = Deposit.find(params[:id])
     flash[:success] = "Approved Deposit"
     redirect_to @deposit
  end
  
  def decline
   Deposit.where(:id => params[:id]).update_all(status: 'DECLINED')
   @deposit = Deposit.find(params[:id])
   flash[:success] = "Declined Deposit"
   redirect_to @deposit
 end

  # PATCH/PUT /deposits/1
  # PATCH/PUT /deposits/1.json
  def update
    respond_to do |format|
      if @deposit.update(deposit_params)
        format.html { redirect_to @deposit, notice: 'Deposit was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposit }
      else
        format.html { render :edit }
        format.json { render json: @deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposits/1
  # DELETE /deposits/1.json
  def destroy
    @deposit.destroy
    respond_to do |format|
      format.html { redirect_to deposits_url, notice: 'Deposit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deposit
      @deposit = Deposit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deposit_params
      params.require(:deposit).permit(:user_id, :date, :amount)
    end

    def setup_deposit
      @user = User.find(session[:user_id])
      @admin = User.find(1)
    end
end