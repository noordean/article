class Submission < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :candidate_class, presence: true
  validates :school, presence: true
  validates :email, uniqueness: true, format: { with: /\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "must be valid"}
  validates :mobile_number_one, uniqueness: true, format: { with: /\A\d{11}\z/, message: 'must be valid'}
  validates :article, presence: true
end
