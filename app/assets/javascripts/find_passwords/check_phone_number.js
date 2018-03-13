$(function(){
  $('.js-getcode').on('click', function(){
    var getCodeBtn = $(this);
    if(getCodeBtn.attr('data-ok')==1){
    $.ajax({
      url: '/all-api/validate_codes',
      type: "POST",
      dataType: "json",
      data: {
        "phone_number": $('.js-phone-number').val(),
        "find_password": true
      }
    })
      .done(function( data ) {
        $('.js-error-vector').html('');
        getCodeBtn.attr('data-ok', '0');
        var count = 60;
        var timeInterval = setInterval(function(){
          if(count==0){
            clearInterval(timeInterval);
          }
          if(count>0){
            getCodeBtn.html(count.toString()+'秒后再次获取');
            count--;
          }else{
            getCodeBtn.html('获取短信验证码');
            getCodeBtn.attr('data-ok', '1');
          }
        }, 1000);
      })
      .fail(function( xhr, status, errorThrown ) {
        $('.js-error-vector').html(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });
    }else{
      $('.js-error-vector').html('请稍候再获取短信验证码');
    }
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