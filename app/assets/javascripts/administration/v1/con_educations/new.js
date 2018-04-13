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
    formData: {path: 'pdf/con_education_artiles', local: 'true'}
  });

  $('#fileupload').fileupload(
    'option',
    'redirect',
    window.location.href.replace(
      /\/[^\/]*$/,
      '/cors/result.html?%s'
    )
  );

  $('#article_type').on('change', function(){
    var value = $(this).val();
    if(value=='video'){
      $('.js-pdf-vector').hide();
      $('.js-content-vector').hide();
      $('.js-video-vector').show();
    }else if(value=='pdf'){
      $('.js-video-vector').hide();
      $('.js-content-vector').hide();
      $('.js-pdf-vector').show();
    }else if(value=='text'){
      $('.js-pdf-vector').hide();
      $('.js-video-vector').hide();
      $('.js-content-vector').show();
    }
  });

  $('.js-create').on('click', function(){
    var data = {};
    var articleType = $('#article_type').val();

    if(articleType=='pdf'){
      var pdfUploadDom = $('.js-one');
      var pdfCount = pdfUploadDom.length;
      if(pdfCount>1){
        alert('只能上传一个pdf');
        return;
      }
      if(pdfCount<=0){
        alert('必须上传pdf');
        return;
      }
      data['pdf_url'] = pdfUploadDom.attr('data-file-path');
    }else if(articleType=='video'){
      var videoUrl = $('#video_url').val();
      if(videoUrl==null || videoUrl==''){
        alert('请指定视频路径');
        return;
      }
      data['video_url'] = videoUrl;
    }else if(articleType=='text'){
      data['content'] = editor.html();
    }

    data['article_classify'] = $('#article_classify').val();
    data['article_type'] = $('#article_type').val();
    data['title'] = $('#title').val();
    data['published_at'] = $('#published_at').val();
    data['tags'] = $('#tag').val();

    var id = $('#id').val();
    if(id==null||id==''){
      var method = 'post';
      var path = '/administration-api/v1/con_educations';
    }else{
      var method = 'put';
      var path = '/administration-api/v1/con_educations/'+id.toString();
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
        window.location.href='/administration/v1/con_educations';
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

});
