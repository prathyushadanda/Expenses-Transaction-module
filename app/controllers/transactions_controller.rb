class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = current_user.transactions.new
  end

  def edit;
  end

  def create
    @transaction = current_user.transactions.new(transaction_params)
    @transaction.save
    redirect_to transactions_path, notice: 'Transaction was successfully created.'
  end

  def update
    @transaction.update_attributes(transaction_params)
    redirect_to transactions_path, notice: 'Transaction was successfully updated.'
  end

  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def expense_reports; end

  def generate_reports

    get_transactions(params)
    report_content = TransactionReports::Engine.new.transaction_reports_statement(@transactions)
    report_content.write "public/report_content.xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => "Transaction Reports.xls", disposition: 'attachment'
  end


  def bank_statement; end

  def generate_bank_statement
    get_transactions(params)
    report_content = TransactionReports::Engine.new.bank_statement(@transactions)
    report_content.write "public/report_content.xls"
    send_file "public/report_content.xls", :type => "application/vnd.ms-excel", :filename => "Bank Statement.xls", disposition: 'attachment'
  end

  def get_transactions(params)
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    raise 'Start Date cant be blank' unless start_date
    raise 'End Date cant be blank' unless end_date
    @transactions = current_user.transactions.where(date: start_date..end_date)
  end

  private
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:date, :amount, :category_id)
  end
end

