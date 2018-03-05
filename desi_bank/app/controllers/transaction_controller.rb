class TransactionController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end
  
  def show
    @transaction = Transaction.find(params[:id])
  end
  
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      flash[:success] = "Transaction creation successful!"
      redirect_to @transaction
    else
      render 'new'
    end
  end

  def destroy
    @transaction.destroy
  end
  
  private
  def transaction_params
    params.require(:transaction).permit(:amount, :from, :to, :status, :start, :effective)
  end
end
