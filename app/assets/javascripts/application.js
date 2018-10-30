// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap

$(document).ready(function() {
  $("#candidates-select").change(function(event) {
    var category_id = event.target.value;
    $.ajax({
      url: "/submissions/category/" + category_id,
      type: "GET"
    }).done(function(result) {
      $("#submissions-body").html(renderSubmissionsBody(result));
    });
  });

  // $("#submit-form").submit(function(e) {
  //   event.preventDefault()
  //   alert("hii")
  // })

  function renderSubmissionsBody(submissions) {
    var htmlStr = "";
    if (submissions.length === 0) {
      return "<div>No Results</div>";
    }

    for (var i = 0; i < submissions.length; i++) {
      htmlStr += "<tr><td>" + submissions[i].first_name + "</td>" +
                  "<td>" + submissions[i].last_name + "</td>" +
                  "<td>" + submissions[i].school + "</td>" +
                  "<td>" + submissions[i].date_of_birth + "</td>" +
                  "<td>" + submissions[i].candidate_class + "</td>" +
                  "<td>" + submissions[i].mobile_number_one + "</td>" +
                  "<td>" + submissions[i].number_of_errors + "</td></tr>"
    }

    return htmlStr;
  }
});
