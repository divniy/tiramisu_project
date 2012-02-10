class ProjectsController < ApplicationController

  def index
    @projects = projects.all
  end

  def new
    @project = Project.new
  end

  def edit
    @project = projects.find(params[:id])
  end

  def create
    @project = projects.build(params[:project])
    if @project.save
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    send :edit
    if @project.update_attributes(params[:project])
      redirect_to projects_path, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    send :edit
    @project.destroy
    redirect_to projects_path
  end

  #private

  def projects
    account.projects
  end

  def account
    current_user.accounts.active
  end

end
