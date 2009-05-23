class ProjectsController < ApplicationController
  before_filter :require_user
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end
  
  def show
    
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to projects_path
    else
      render :action => :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Updated"
      redirect_to projects_path
    else
      render :action => :edit
    end
  end
  
  def destroy
    @project.destroy
    redirect_to projects_path
  end
  
  def updated
    @projects = Project.find(:all, :conditions => ["updated_at > ?", Time.now - 60])
    
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end
  end
  
  private
  
  def find_project
    @project = Project.find_by_id(params[:id])
  end
end
