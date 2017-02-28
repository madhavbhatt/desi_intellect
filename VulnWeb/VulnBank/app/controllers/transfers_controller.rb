class TransfersController < ApplicationController
  before_action :set_transfer, only: [:show, :edit, :update, :destroy]

  # GET /transfers
  # GET /transfers.json
  def index
    @transfers = Transfer.all
  end

  # GET /transfers/1
  # GET /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers
  # POST /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)
    # @balance -= User.amount
    if @transfer.nil?
      flash[:danger] = "No Deposit request passed to controller"
    else
      Transfer.request(@user, @admin)
    end
    
    if @transfer.to.nil? || @transfer.to == ""
      flash[:danger] = "Invalid Transfer: No Participant"
      redirect_to "/transfers/new"
      return
    end
    
    if @transfer.amount.nil?
      flash[:danger] = "Invalid Transfer: No Amount"
      redirect_to "/transfers/new"
      return
    end
    
    respond_to do |format|
      if @transfer.save
        format.html { redirect_to @transfer, notice: 'Your request  has been sent. Pending Approval from the admin.' }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def approve
    @to_account = Account.find_by_sql("SELECT * FROM accounts WHERE acct_number = id".gsub("id", @transfer.to))[0]
    new_balance = @to_account.balance += @transfer.amount
    Account.where(acct_number: @transfer.to).update_all(balance: new_balance)
    @to_account.save
    
    @from_account = Account.find_by_sql("SELECT * FROM accounts WHERE acct_number = id".gsub("id", @transfer.from))[0]
    new_balance2 = @from_account.balance -= @transfer.amount
    Account.where(acct_number: @transfer.from).update_all(balance: new_balance2)
    @from_account.save
          
   Transfer.where(:id => params[:id]).update_all(status: 'APPROVED')
   @transfer = Transfer.find(params[:id])
   flash[:success] = "Approved Transfer"
   redirect_to @transfer
 end
 
 def decline
   Transfer.where(:id => params[:id]).update_all(status: 'DECLINED')
   @transfer = Transfer.find(params[:id])
   flash[:success] = "Declined Transfer"
   redirect_to @transfer
 end

  # PATCH/PUT /transfers/1
  # PATCH/PUT /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: 'Transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1
  # DELETE /transfers/1.json
  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, notice: 'Transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:from, :to, :amount, :start, :effective)
    end

    def setup_deposit
      @user = User.find(session[:user_id])
      @admin = User.find(1)
    end
end
