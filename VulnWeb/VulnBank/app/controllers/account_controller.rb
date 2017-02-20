class AccountController < ApplicationController
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end
  
  def show
    @account = Account.find(params[:id])
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "Account Request Submitted"
      redirect_to @account
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "Account Updated"
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    @account.destroy
  end
  
  private
  def account_params
    params.require(:account).permit(:acct_number, :status, :balance, :owner)
  end
end
