$(function(){

  $('#fileupload').fileupload({
    url: '/all-api/uploads'
  });

  //一选择文件的时候，自动上传
  $('#fileupload').fileupload('option', {
    dataType: 'json',
    type: 'POST',
    url: '/all-api/uploads',
    singleFileUploads: false,
    sequentialUploads: true,
    autoUpload: true,
    formData: {path: 'image/banners', oss: 'true'}
  });

  $('#fileupload').fileupload(
    'option',
    'redirect',
    window.location.href.replace(
      /\/[^\/]*$/,
      '/cors/result.html?%s'
    )
  );

  $('.js-create').on('click', function(){
    var data = {};

    data['serial'] = Number($('#serial').val());
    data['image_url'] = $('.js-files-vector').find('.js-one').attr('data-file-path');
    data['aim_at_platform'] = $('#aim_at_platform').val();
    data['state'] = $('#state').val()=='true' ? 1 : 0;
    data['link_url'] = $.trim($('#link_url').val());
    data['description'] = $.trim($('#description').val());

    var id = $('#id').val();
    if(id==null||id==''){
      var method = 'post';
      var path = '/administration-api/v1/banners';
    }else{
      var method = 'put';
      var path = '/administration-api/v1/banners/'+id.toString();
    }
    console.log(data);

    $.ajax({
      url: path,
      type: method,
      data: data,
      dataType: "json"
    })
    .done(function( data ) {
      if(data['success']){
        window.location.href='/administration/v1/banners';
      }else{
        alert(data['message']);
      }
    })
    .fail(function( xhr, status, errorThrown ) {
      alert(xhr.responseJSON.message);
      return false;
    })
    .always(function( xhr, status ) {
    });
  });

})
