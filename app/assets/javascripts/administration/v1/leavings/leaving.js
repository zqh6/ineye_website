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
              "<option value=\"a\" selected>上午</option>"+
              "<option value=\"b\" >下午</option>"+
              "<option value=\"b\" >全天</option>"+
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
