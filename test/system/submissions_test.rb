require "application_system_test_case"

class SubmissionsTest < ApplicationSystemTestCase
  setup do
    @submission = submissions(:one)
  end

  test "visiting the index" do
    visit submissions_url
    assert_selector "h1", text: "Submissions"
  end

  test "creating a Submission" do
    visit submissions_url
    click_on "New Submission"

    fill_in "Age", with: @submission.age
    fill_in "Article", with: @submission.article
    fill_in "Class", with: @submission.class
    fill_in "Email", with: @submission.email
    fill_in "First Name", with: @submission.first_name
    fill_in "Last Name", with: @submission.last_name
    fill_in "Middle Name", with: @submission.middle_name
    fill_in "Mobile Number One", with: @submission.phone_number
    fill_in "Mobile Number Two", with: @submission.mobile_number_two
    fill_in "School", with: @submission.school
    click_on "Create Submission"

    assert_text "Submission was successfully created"
    click_on "Back"
  end

  test "updating a Submission" do
    visit submissions_url
    click_on "Edit", match: :first

    fill_in "Age", with: @submission.age
    fill_in "Article", with: @submission.article
    fill_in "Class", with: @submission.class
    fill_in "Email", with: @submission.email
    fill_in "First Name", with: @submission.first_name
    fill_in "Last Name", with: @submission.last_name
    fill_in "Middle Name", with: @submission.middle_name
    fill_in "Mobile Number One", with: @submission.mobile_number_one
    fill_in "Mobile Number Two", with: @submission.mobile_number_two
    fill_in "School", with: @submission.school
    click_on "Update Submission"

    assert_text "Submission was successfully updated"
    click_on "Back"
  end

  test "destroying a Submission" do
    visit submissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Submission was successfully destroyed"
  end
end
