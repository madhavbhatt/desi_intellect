class AccountsController < ApplicationController
  
  def index
    @accounts = []
    if current_user.admin?
        @accounts = Account.all
    else
        @accounts = current_accounts
    end
    if @accounts.empty?
      flash.now[:danger] = "No Accounts Found"
    end
  end

  def new
    @account = Account.new
  end
  
  def show
    @account = Account.find(params[:id])
  end
  
  def create
    id = get_account_id()
    @account = Account.create(:acct_number => id,:status => "CLOSED",:balance => 0.00,:owner => current_user.id.to_s)
    if @account.save
      flash[:success] = "Account Request Submitted"
      redirect_to @account
    else
      flash[:danger] = @account.errors.full_messages
      render 'index'
    end
  end
  
  #controller function to activate an Account
  def activate
    Account.where(:id => params[:id]).update_all(status: 'ACTIVE')
    @account = Account.find(params[:id])
    flash[:success] = "Activated Account #" + @account.acct_number.to_s
    redirect_to @account
  end
  
  #controller function to close an Account
  def close
    Account.where(:id => params[:id]).update_all(status: 'CLOSED')
    @account = Account.find(params[:id])
    flash[:success] = "Closed Account #" + @account.acct_number.to_s
    redirect_to @account
  end

  def destroy
    @account.destroy
  end
  
  private
  
  #Account IDs are unique 9 digit numbers
  def get_account_id
    num = rand(111111111..999999999)
    id = sprintf("%09d", num)
    id.to_s
  end
  
end
