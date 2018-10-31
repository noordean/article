json.extract! submission, :id, :first_name, :middle_name, :last_name, :age, :class, :school, :article, :email, :phone_number, :mobile_number_two, :created_at, :updated_at
json.url submission_url(submission, format: :json)
