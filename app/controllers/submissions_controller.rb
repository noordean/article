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

  # def get_submissions
  #   submissions = Submission.all
  #   if params[:category_id].to_i == 0
  #     submissions = Submission.all.select { |s| s.shortlisted? }
  #   end

  #   if params[:category_id].to_i == -1
  #     submissions = Submission.all.reject { |s| s.shortlisted? }
  #   end

  #   render :json => submissions
  # end

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
    if submission.save
      redirect_to root_path
      flash[:success] = "Article successfully submitted"
    else
      submission_params.each do |name, value|
        cookies[name] = { :value => value, :expires => 2.seconds.from_now }
      end
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
      params.require(:submission).permit(:first_name, :middle_name, :last_name, :date_of_birth, :candidate_class, :school, :article, :email, :phone_number, :image, :article_file)
    end
end
