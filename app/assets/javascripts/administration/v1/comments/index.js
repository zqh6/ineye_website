$(function(){
  $('.js-deny-one').on('click', denyOne);
  $('.js-approve-one').on('click', approveOne);

  function denyOne(){
    var id = $(this).attr('data-id');
    AMUI.dialog.confirm({
      title: '警告',
      content: '确认禁用这条评论吗？',
      onConfirm: function() {
        updateComment(id, 'D')
      },
      onCancel: function() {

      }
    });
  };

  function approveOne(){
    var id = $(this).attr('data-id');
    AMUI.dialog.confirm({
      title: '温馨提示',
      content: '确认通过这条评论吗？',
      onConfirm: function() {
        updateComment(id, 'A')
      },
      onCancel: function() {

      }
    });
  };

  function updateComment(id, state){
    $.ajax({
      url: "/all-api/comments/"+id,
      type: "patch",
      contentType: 'application/json',
      dataType: "json",
      data: JSON.stringify({
        'state': state,
        'function': 'audit'
      })
    })
    .done(function( data ) {
      if(data['success']){
        location.reload(true);
      }else{
        AMUI.dialog.alert({
          title: '温馨提示',
          content: data['message']
        });
      }
    })
    .fail(function( xhr, status, errorThrown ) {
      AMUI.dialog.alert({
        title: '温馨提示',
        content: data['message']
      });
    })
    .always(function( xhr, status ) {
    });
  };


});