class AccountsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @accounts = accounts
  end

  def new
    @account = Account.new
  end

  def edit
    @account = accounts.find(params[:id])
  end

  def create
    @account = accounts.build(params[:account])
    if @account.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    send :edit
    if @account.update_attributes(params[:account])
      redirect_to accounts_path, notice: 'Account was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    send :edit
    @account.destroy
    redirect_to accounts_path
  end

  def activate
    send :edit
    @account.activate
    redirect_to accounts_path, notice: 'Account was successfully activated.'
  end

  private

  def accounts
    current_user.accounts
  end
end
