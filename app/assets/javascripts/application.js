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
//= require bootstrap-sprockets
//= require_tree .

$( document ).on('turbolinks:load', function() {
  $(document).on('click', '.js-button-next', function() {
    var form = $(this).closest('.js-form-step');
    var stepIndex = $(this).data('stepIndex');
    var data = $('form').serialize();

    $.ajax({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      url: '/shippings/validate_step',
      method: 'GET',
      dataType: 'JSON',
      data: data,
      success: function(response) {
        if (response.valid) {
          $('.js-form-step').slideUp();
          $('.js-form-step').eq(stepIndex + 1).slideDown();
          $('input[name="step_index"]').val(stepIndex + 1);
          form.find('.js-error-messages').html("");

          if (stepIndex == 1) {
            $('.js-form-step').last().html(response.confirmation);
          }
        } else {
          form.find('.js-error-messages').html(response.error_messages);
        }
      }
    });
  });

  $(document).on('click', '.js-button-pre', function() {
    var form = $(this).closest('.js-form-step');
    var stepIndex = $(this).data('stepIndex');
   
    $('.js-form-step').slideUp();
    $('.js-form-step').eq(stepIndex - 1).slideDown();
    $('input[name="step_index"]').val(stepIndex - 1);
    form.find('.js-error-messages').html("");
  });
});
