class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authorize_admin, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @submissions = Submission.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def send_message
    number_of_errors = DifficultyLevel.find_by(name: params[:difficulty_level])&.number_of_errors || 0

    successful_candidates = if params[:message_checkbox]
      Submission.where("#{params[:broadcast_method]}_sent": "NO").select { |s| s.shortlisted?(number_of_errors) }
    else
      Submission.all.select { |s| s.shortlisted?(number_of_errors) }
    end

    if (successful_candidates.size == 0)
      flash[:danger] = "Message not sent. No successful candidates detected."
      redirect_to root_path
    else
      if params[:broadcast_method] == "sms"
        SendSmsJob.perform_later(successful_candidates, params[:message])
      else
        SendEmailJob.perform_later(successful_candidates, params[:message])
      end

      flash[:success] = "Message successfully sent"
      redirect_to root_path
    end
  end

  def select_candidates
    @submissions = Submission.all
    number_of_errors = DifficultyLevel.find_by(name: "hard")&.number_of_errors || 0
    if params[:difficulty_level]&.to_i == 0
      number_of_errors = DifficultyLevel.find_by(name: "medium")&.number_of_errors || 2
    elsif params[:difficulty_level]&.to_i == -1
      number_of_errors = DifficultyLevel.find_by(name: "easy")&.number_of_errors || 5
    end

    if params[:candidate_type].to_i == 0
      @submissions = Submission.all.select { |s| s.shortlisted?(number_of_errors) }
    end

    if params[:candidate_type].to_i == -1
      @submissions = Submission.all.reject { |s| s.shortlisted?(number_of_errors) }
    end

    render "show"
  end

  def set_difficulty_level
    ["hard", "medium", "easy"].each do |d|
      level = DifficultyLevel.find_by(name: d)
      if level.nil?
        DifficultyLevel.new(name: d, number_of_errors: params[d.to_sym]).save!
      else
        level.update(number_of_errors: params[d.to_sym])
      end
    end

    flash[:success] = "Settings successfully saved"
    redirect_to root_path
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def authorize_admin
    unless is_admin?
      redirect_to root_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
