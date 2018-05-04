/*
 *= require_self
 */

$(function(){
	$('.js-delete-one-new').on('click',function(){
   var newId = $(this).attr('data-new-id');
		AMUI.dialog.confirm({
			title: '警告',
			content: '确认删除吗？',
			onConfirm: function() {
				$.ajax({
					url: "/administration-api/v1/new/"+newId,
					type: "delete",
					data: {
					},
					dataType: "json"
				})
					.done(function( data ) {
						if(data['success']){
							window.location.href='/administration/v1/new';
						}else{
							alert(data['message']);
						}
					})
					.fail(function( xhr, status, errorThrown ) {
						console.log(xhr['responseJSON']);
						return false;
					})
					.always(function( xhr, status ) {
					});
		 }, onCancel: function() {  } });
	});
})
