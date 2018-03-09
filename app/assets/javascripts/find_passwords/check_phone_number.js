$(function(){
  $('.js-getcode').on('click', function(){
    $.ajax({
      url: '/all-api/validate_codes',
      type: "POST",
      dataType: "json",
      data: {
        "phone_number": $('.js-phone-number').val()
      }
    })
      .done(function( data ) {
        $('.js-error-vector').html('');
      })
      .fail(function( xhr, status, errorThrown ) {
        $('.js-error-vector').html(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });
  });

  $('.js-submit').on('click', function(){
    $.ajax({
      url: '/all-api/validate_codes/~',
      type: "PUT",
      dataType: "json",
      data: {
        "phone_number": $('.js-phone-number').val(),
        "validate_code": $('.js-validate-code').val()
      }
    })
      .done(function( data ) {
        window.location.href='/find_passwords/~/edit?function=set_new_password'
      })
      .fail(function( xhr, status, errorThrown ) {
        $('.js-error-vector').html(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });
  });
});