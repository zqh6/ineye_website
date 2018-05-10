$(function(){
  $('.js-submit').on('click', function(){
    $.ajax(
      {
        url: "/administration-api/v1/sessions",
        type: "post",
        data: {
          "phone_number": $('.js-phone-number').val(),
          "password": $('.js-password').val()
        },
        dataType: "json"
      }
    )
      .done(function( data ) {
        if(data['success']){
          $('.js-error-vector').html("&nbsp;");
          reload_url = '/';
          if(undefined!=$('.js-callback').val() && null!=$('.js-callback').val() && ''!=$('.js-callback').val()){
            reload_url = $('.js-callback').val();
          }
          window.location.href = reload_url;
        }else{
          $('.js-error-vector').html(JSON.parse(xhr.responseText)['message']);
          return false;
        }
        return true;
      })
      .fail(function( xhr, status, errorThrown ) {
        $('.js-error-vector').html(JSON.parse(xhr.responseText)['message']);
        return false;
      })
      .always(function( xhr, status ) {
      });
  });
});
