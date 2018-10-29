class Submission < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :candidate_class, presence: true
  validates :school, presence: true
  validates :email, uniqueness: true, format: { with: /\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "must be valid"}
  validates :mobile_number_one, uniqueness: true, format: { with: /\A\d{11}\z/, message: 'must be valid'}
  validates :article, presence: true
  validate :filter_article_words

  def filter_article_words
    article_size = article.split.size
    if (article_size < 2) || (article_size > 15)
      errors.add(:base, "Article should contain between 250-500 words")
    end
  end

  def shortlisted?
    number_of_errors == 0 && age >= 18
  end

  def age
    # date_of_birth.strftime("%d/%m/%Y")
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end
end
