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

  private

  # Account context
  def projects
    current_account.projects
  end

  # User context
  def current_account
    current_user.active_account
  end

end
