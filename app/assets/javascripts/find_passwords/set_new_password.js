$(function(){
  $('.js-submit').on('click', function(){
    $.ajax({
      url: '/all-api/find_passwords/~',
      type: "PUT",
      dataType: "json",
      data: {
        "password1": $('.js-password1').val(),
        "password2": $('.js-password2').val()
      }
    })
      .done(function( data ) {
        window.location.href='/find_passwords/~/edit?function=finish'
      })
      .fail(function( xhr, status, errorThrown ) {
        $('.js-error-vector').html(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });
  });
});