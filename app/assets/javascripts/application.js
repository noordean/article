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
//= require jquery
//= require jquery3
//= require_tree .
//= require popper
//= require bootstrap

window.setTimeout(function () {
  $(".alert").fadeTo(2000, 0).slideUp(2000, function () {
    $(this).remove();
  });
}, 2000);

$(document).on('turbolinks:load', function () {
  $("#candidates-select").change(function (event) {
    // var category_id = event.target.value;
    // $.ajax({
    //   url: "/submissions/category/" + category_id,
    //   type: "GET"
    // }).done(function(result) {
    //   $("#number-of-candidates").html(result.length + " candidates");
    //   $("#submissions-body").html(renderSubmissionsBody(result));
    // });
    if (event.target.value == 1) {
      $("#difficulty-level").addClass("difficulty-level");
    } else {
      $("#difficulty-level").removeClass("difficulty-level");
    }
  });

  $("#broadcast-method").change(function (event) {
    if (event.target.value === "email") {
      $("#message-checkbox-label").html("Send to only candidates that have not recieved email");
    } else if (event.target.value === "sms") {
      $("#message-checkbox-label").html("Send to only candidates that have not recieved SMS");
    } else {
      $("#message-checkbox-label").html("Send to only candidates that have not recieved message");
    }
  });
  // function renderSubmissionsBody(submissions) {
  //   var htmlStr = "";
  //   if (submissions.length === 0) {
  //     return "<div>No Results</div>";
  //   }

  //   for (var i = 0; i < submissions.length; i++) {
  //     htmlStr += "<tr><td>" + submissions[i].first_name + "</td>" +
  //                 "<td>" + submissions[i].last_name + "</td>" +
  //                 "<td>" + submissions[i].school + "</td>" +
  //                 "<td>" + submissions[i].date_of_birth + "</td>" +
  //                 "<td>" + (submissions[i].candidate_class).split("_").join(" ").toUpperCase() + "</td>" +
  //                 "<td>" + submissions[i].phone_number + "</td>" +
  //                 "<td>" + submissions[i].number_of_errors + "</td></tr>"
  //   }

  //   return htmlStr;
  // }


  // Handles passport upload
  $('.photo_upload').on('change', function (e) {
    readURL(this);
  });

  function readURL(input) {
    var reader;
    if (input.files && input.files[0]) {
      reader = new FileReader();
    }
    reader.onload = function (e) {
      if (Math.floor(input.files[0].size / 1000) > 500) {
        var errorMsg = document.getElementById("passport-error-msg");
        $(".passport-error-msg").html("Your passport cannot be greater than 500kb");
        return;
      }
      var $swap;
      $(".passport-error-msg").html("");
      $('.image_preview').attr('src', e.target.result).removeClass('hidden');
      $swap = $('.swap');
      if ($swap) {
        $swap.removeClass('hidden');
      }
    };

    reader.readAsDataURL(input.files[0]);
  };

  // Handles article upload
  $("#article-input").on("change", function (evt) {
    var files = evt.target.files;
    var f = files[0];
    var extension = f.name.split('.').pop().toLowerCase();
    var reader = new FileReader();
    var self = this;
    reader.onload = (function (theFile) {
      if (extension !== "txt") {
        $(".article-file-error-msg").html("An invalid file detected.");
        $(self).val("");
        return;
      }
      $(".article-file-error-msg").html("");
      return function (e) {
        var formattedStr = e.target.result.replace(/(?:\r\n|\r|\n)/g, ' ')
        $('#article-text-area').val(formattedStr);
      };
    })(f);
    reader.readAsText(f);
  });
});
