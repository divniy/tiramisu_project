class Web::User::RegistrationsController < Devise::RegistrationsController
  before_filter :only => [:new, :create] do
    @roles = Account.roles
  end

  def new
    resource = build_resource({})
    resource.accounts.build
    respond_with resource
  end

end