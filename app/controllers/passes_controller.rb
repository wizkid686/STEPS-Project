class PassesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  def new
    @pass = Pass.new
  end

  def create
    @pass = current_user.passes.build(pass_params)
    if @pass.save
      flash[:success] = "Pass Created Successfully!"
      redirect_to current_user
    else
      render 'new'
    end
  end

  def destroy 
    @pass.destroy
    flash[:success] = "Pass deleted"
    redirect_to request.refferer || root_url
  end

  def show
  end

  def index
    @passes = Pass.all    
  end

  def my_passes
    @passes = Pass.where(:user => current_user.id)
  end

  def edit
    @pass = Pass.find_by(id: params[:id])
    @user = Pass.user
  end

  def update
    @pass = current_user.passes.find_by(id: params[:id])
    if @pass.update_attributes(pass_params)
      flash[:success] = "Pass Updated"
    else
      render 'edit'
    end
  end

  private

    def pass_params
      params.require(:pass).permit( :destination, :time_out, :returning, :return_time, :student_id, :course)
    end

    def correct_user
      @pass = current_user.passes.find_by(id: params[:id])
      redirect_to root_url if @pass.nil?
    end
end
