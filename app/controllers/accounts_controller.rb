class AccountsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

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
    #if cannot? :create, @account
    #  flash[:notice] = 'Can not create another single account'
    #  render :new
    #else
    if @account.save
      redirect_to accounts_path, notice: 'Account was successfully created.'
    else
      render action: "new"
    end

    #end
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

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    case exception.action
      when :create
        render :new
      when :update
        render :edit
      else
        redirect_to accounts_path
    end
  end

  private

  # User context
  def accounts
    current_user.accounts
  end
end
