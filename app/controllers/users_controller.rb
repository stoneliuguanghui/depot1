class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:new, :create]
  def index

    @user = current_user
  end

  def edit
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save

        format.html { redirect_to users_url }
      else
        format.html { render :new }
      end
    end
  end

  def update
      @user=User.find(params[:id])
      current_password=params[:user][:current_password]
      user=User.authenticate(@user.name,current_password)
    respond_to do |format|
      if @user&&user&&@user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
          @user.destroy
          flash[:notice]="User #{@user.name} deleted"
    rescue Exception => e
          flash[:notice]=e.message
    end
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end


end
