class SubmissionsController < ApplicationController
  before_action :set_submission, only: [:show, :edit, :update, :destroy]
  before_action :redirect_admin, only: [:new]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    submission = Submission.new(submission_params)
    submission.number_of_errors = check_grammatical_errors(submission.article)["corrections"].count

    if submission.save
      redirect_to root_path
      flash[:success] = "Article successfully submitted"
      # if submission.number_of_errors.to_i == 0 && submission.age.to_i >= 18
      #   UserMailer.with(submission: submission).success_email.deliver_later
      # end
    else
      redirect_to root_path
      flash[:danger] = submission.errors.full_messages.first
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    def check_grammatical_errors(text)
      parser = Gingerice::Parser.new
      parser.parse text
    end

    def redirect_admin
      if is_admin?
        redirect_to user_path(current_user)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:first_name, :middle_name, :last_name, :date_of_birth, :candidate_class, :school, :article, :email, :mobile_number_one, :mobile_number_two)
    end
end
