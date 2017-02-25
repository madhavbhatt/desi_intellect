class WithdrawalsController < ApplicationController
  before_action :set_withdrawal, only: [:show, :edit, :update, :destroy]

  # GET /withdrawals
  # GET /withdrawals.json
  def index
    @withdrawals = Withdrawal.all
  end

  # GET /withdrawals/1
  # GET /withdrawals/1.json
  def show
  end

  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
  end

  # GET /withdrawals/1/edit
  def edit
  end

  # POST /withdrawals
  # POST /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(withdrawal_params)
    if @withdrawal.nil?
      flash[:danger] = "No withdrawal request passed to controller"
    else
      Withdrawal.request(@user, @admin)
    end
    
    if @withdrawal.amount.nil?
      flash[:danger] = "Invalid Withdrawal: No Amount"
      redirect_to "/withdrawals/new"
      return
    end
    
    if @withdrawal.amount >= 1000
      flash[:danger] = "Withdrawal amount is greater than $1,000. Submitting to admin."
      redirect_to "/withdrawals"
      return
    end
    
    @account = Account.find_by_sql("SELECT * FROM accounts WHERE acct_number = id".gsub("id", @withdrawal.user_id.to_s))[0]
    new_balance = @account.balance -= @withdrawal.amount
    Account.where(acct_number: @withdrawal.user_id).update_all(balance: new_balance)
    @account.save
    
    respond_to do |format|
      if @withdrawal.save
        format.html { redirect_to @withdrawal, notice: 'Your request  has been sent. Pending Approval from the admin.' }
        format.json { render :show, status: :created, location: @withdrawal }
      else
        format.html { render :new }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdrawals/1
  # PATCH/PUT /withdrawals/1.json
  def update
    respond_to do |format|
      if @withdrawal.update(withdrawal_params)
        format.html { redirect_to @withdrawal, notice: 'Withdrawal was successfully updated.' }
        format.json { render :show, status: :ok, location: @withdrawal }
      else
        format.html { render :edit }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdrawals/1
  # DELETE /withdrawals/1.json
  def destroy
    @withdrawal.destroy
    respond_to do |format|
      format.html { redirect_to withdrawals_url, notice: 'Withdrawal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdrawal
      @withdrawal = Withdrawal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def withdrawal_params
      params.require(:withdrawal).permit(:user_id, :date, :amount)
    end

    def setup_deposit
      @user = User.find(session[:user_id])
      @admin = User.find(1)
    end

end
