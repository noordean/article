class Submission < ApplicationRecord
  has_one_attached :image
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :candidate_class, presence: true
  validates :school, presence: true
  validates :email, uniqueness: true, format: { with: /\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, message: "must be valid"}
  validates :phone_number, uniqueness: true, format: { with: /\A\d{11}\z/, message: 'must be valid'}
  validates :article, presence: true
  validate :filter_article_words
  validate :check_image_presence

  after_commit :update_number_of_errors, on: :create

  def filter_article_words
    article_size = article.split.size
    if (article_size < 50) || (article_size > 500)
    # if (article_size < 2) || (article_size > 10)
      errors.add(:base, "Article should contain between 50-500 words, but you submitted #{article_size} words.")
    end
  end

  def check_image_presence
    if image.attachment == nil
      errors.add(:base, "Your passport must be added")
    elsif (image.blob.byte_size/1000) > 500
      errors.add(:base, "Your passport can not be greater than 500kb")
    end
  end

  def shortlisted?(no_of_errors)
    (number_of_errors <= no_of_errors) && (age >= 18) && (candidate_class == "jss_3")
  end

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def update_number_of_errors
    first_part_of_article = article.truncate(500, separator: '.')
    no_of_errors = check_grammatical_errors(first_part_of_article)["corrections"].count
    no_of_errors += check_grammatical_errors(article[(first_part_of_article.size - 1)..article.size].truncate(500, separator: '.'))["corrections"].count

    self.update(number_of_errors: no_of_errors)
  end

  private

  def check_grammatical_errors(text)
    parser = Gingerice::Parser.new
    parser.parse text
  end
end
