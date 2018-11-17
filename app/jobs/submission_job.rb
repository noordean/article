class SubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission)
    sentences = submission.article.split(".")
    no_of_errors = 0
    sentences.each do |s|
      no_of_errors += check_grammatical_errors(s)["corrections"].count
    end

    submission.update(number_of_errors: no_of_errors)
  end

  def check_grammatical_errors(text)
    parser = Gingerice::Parser.new
    parser.parse text
  end
end
