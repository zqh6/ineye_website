$(function(){

  $('.am-icon-plus').trigger("click");
  function initstopmsg(){

  }
  function initstop(){
    if($(".time-area .add-timegroup").length>0){
      for (var i =0;i<$(".time-area .add-timegroup").length;i++){
        if($(".time-area .add-timegroup").length>0){
          $(".surestop button").show();
        }
      }
    }else{
      $(".surestop button").hide();
    }
  }
  initstop();
  $(".surestop button").hide();
  function initNun(){
    if($(".time-area .add-timegroup").length>0){
      indexNum =[];
      for (var i =0;i<$(".time-area .add-timegroup").length;i++){
        indexNum.push(i);
      }
      $(".surestop button").show();
    }else{
      indexNum = 0;

    }
    return indexNum;
  }
  var thisIndex = initNun();
  var time =
        "<div class=\"add-timegroup clear-both\">"+
        "<div class=\"am-input-group am-datepicker-date am-u-sm-4 am-u-md-4 am-u-lg-4 my-datepicker\" data-am-datepicker=\"{format: 'dd-mm-yyyy'}\" id='my-datepicker'>"+
          "<input type=\"text\" class=\"am-form-field inputBorder\" placeholder=\"日历组件\"  readonly>"+
          "<span class=\"am-input-group-btn am-datepicker-add-on\">"+
           " <button class=\"am-btn am-btn-default\" type=\"button\"><span class=\"am-icon-calendar\"></span> </button>"+
          "</span>"+
        "</div>"+
        "<select data-am-selected class='timechoose'>"+
          "<option value=\"am\" selected>上午</option>"+
          "<option value=\"pm\" >下午</option>"+
          "<option value=\"am_and_pm\" >全天</option>"+
        "</select>"+
        "<span class=\"minusbtn\"><i class=\"am-icon-minus cursor\"></i></span>"+
      "</div>"

  $(".addBtn").on("click",".am-icon-plus",function(){
      $(time).appendTo($(".time-area"));
      $('.my-datepicker').datepicker({format: 'yyyy-mm-dd'});
      $(".add-timegroup").each(function(i){
          $(this).attr("dex",thisIndex[i]);
      })
      thisIndex = initNun();
      initstop();
      console.log(thisIndex);

  })


  //减少排版记录的时候，删除插件创建的日历html
  $(".time-area").on("click",".am-icon-minus",function(e){

    var dex = $(this).parent().parent().attr("dex")
    for(var i = 0;i<$(".time-area .add-timegroup").length;i++){
      if($(".time-area .add-timegroup").eq(i).attr("dex") == dex){
        $("body .am-datepicker").eq(i).remove();

      }
    }
    setTimeout(function(){
      $(".add-timegroup").each(function(i){
        console.log($(this)+"thisIndex="+thisIndex[i]);
        $(this).removeAttr("dex").attr("dex",thisIndex[i]);
        thisIndex = initNun();
        console.log(thisIndex);
      })
    },10);

    $(this).parent().parent().remove();
    initstop();

  })

  //专家停诊（自己操作）
  $(".surestop button").on("click",function(){
    var stoplist=[];
    for(var i=0;i<$(".time-area .add-timegroup").length;i++){

      if($(".time-area .add-timegroup").eq(i).find(".am-form-field").val().trim()!="" && $(".time-area .add-timegroup").eq(i).find(".am-form-field").val() != null){
        stoplist.push({
          leave_day:$(".time-area .add-timegroup").eq(i).find(".am-form-field").val(),
          am_pm_code:$(".time-area .add-timegroup").eq(i).find(".timechoose").val()
        })
      }
    }
    console.log($(".stopserver").find("input[type=hidden]").val());
    $.ajax({
      url: '/administration-api/v1/ask_for_leaves',
      type: "POST",
      contentType: 'application/json',
      dataType: "json",
      data: JSON.stringify({
          user_id: $(".stopserver").find("input[type=hidden]").val(),
          leave_info: stoplist
        })
      })
      .done(function( data ){
        window.location.reload();
      })
      .fail(function( xhr, status, errorThrown ) {
        alert(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });


  })
  //专家删除停诊记录

  $(".delete-stopserver span").on("click",function(){
    var id=$(this).parent().attr("data-ask-for-leave-id");
    $.ajax({
      url: '/administration-api/v1/ask_for_leaves/'+id,
      type: "DELETE",
      contentType: 'application/json',
      dataType: "json",
      data: JSON.stringify({})
      })
      .done(function( data ){
        window.location.reload();
      })
      .fail(function( xhr, status, errorThrown ) {
        alert(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });


  })

  //专家修改自己排版
  $(".savecheduling").on("click",function(){
    console.log($(".doctorself select").length);
    var doctorworks=[];
    for(var i =0;i<$(".doctorself select").length;i++){
      var selectValue = $(".doctorself select").eq(i).val();
      if(selectValue!="" && selectValue!=null && selectValue!='none'){
        doctorworks.push({
          office_time_id: $(".doctorself select").eq(i).parents("tr").find(".worktime").attr("data-office-time-id"),
          week: $(".doctorself select").eq(i).attr("data-week-code"),
          outpatient_service_type: $(".doctorself select").eq(i).val()
        })
      }

    }

    $.ajax({
      url: '/administration-api/v1/schedulings',
      type: "POST",
      contentType: 'application/json',
      dataType: "json",
      data: JSON.stringify({
          function: "own",
          scheduling_info: doctorworks,
        })
      })
      .done(function( data ){
      })
      .fail(function( xhr, status, errorThrown ) {
        alert(xhr.responseJSON.message);
      })
      .always(function( xhr, status ) {
      });



  })


})



