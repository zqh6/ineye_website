 //    正文、照片、文档、视频切换
    $(".educationList li").click(function () {
        $(this).addClass("on").siblings().removeClass("on");
        $(".eduContentCon .edModule").removeClass("show").eq($(this).index()).addClass("show");
    })




    window.onload = function(){
        getContent()

    }
    var locationHref = window.location.href;
    locationHref = locationHref.substr(locationHref.lastIndexOf("/"),locationHref.length);

    function getContent(elm){
        $.ajax({
            url: '/all-api/comments/~',
            type: "GET",
            contentType: 'application/json',
            dataType: "json",
            data: {
                post_link: "/con_education"+locationHref,
                state:"A"
            }
        })
            .done(function( data ) {
                var data = data.collection;
                var childComment = [];
                var innerStr = "<p class='allComment'>全部评论<span class='num'>"+data.length+"</span></p>";
                for(var i = data.length-1;i >= 0; i--){
                    childComment[i] ="";
                    innerStr+="<div class='flow oneComment' parent_id = "+ data[i].id +"  >"
                        +"<div class='fl'>"
                        +"<img src= '../../assets/edu_user.png' />"
                        +"</div>"
                        +"<div class='fl comContent' parent_id = "+ data[i].id +" >"
                        +"<p class='identity'>"+ data[i].created_at
                        +"<span>游客</span></p>"
                        +"<div class='flow'>"
                        +"<div class='fl '>"+ data[i].content +"</div>"
                        +"<div class='commentSubBtn fr userComment' >"
                        +"<img src= '../../assets/comment_before.png'  onclick=\"addChiComment("+ data[i].id +")\" /></div></div></div>"
                    childComment[i]+= "<div class= 'childComments' >"
                    for(var s =0;s<data[i].sons.length;s++){

                        if(data[i].sons.length>0){
                            childComment[i]+="<div class='comContent' parent_id = "+ data[i].sons[s].id +" >"
                                +"<p class='identity'>"+ data[i].sons[s].created_at
                                +"<span>游客</span></p>"
                                +"<div class='flow'>"
                                +"<p class='fl'>"+ data[i].sons[s].content +"</p>"
                                +"<div class='commentSubBtn fr userComment' >"
                                +"<img src= '../../assets/comment_before.png'  onclick=\"addChiComment("+ data[i].sons[s].id +","+data[i].sons[s].id+")\" />"
                                +"</div>"
                                +"</div>"
                                +"</div>"
                        }else{
                            childComment[i]='';
                        }


                    }
                    childComment[i]+="</div>"
                    innerStr+=childComment[i]
                        +"</div>"
                        +"</div>"
                        +"</div>"

                }
                elm = elm?elm:$(".comContainer");
                elm.html(innerStr);
            })
            .fail(function( xhr, status, errorThrown ) {

                console.log('失败');
            })
            .always(function( xhr, status ) {
            });
    }

    //去除所有的标签和空格后返回字符串,用于判断客户不正当输入
    function teststring(str){
            return str.replace(/&nbsp;/ig, "").replace(/<[^>]*>/g,"");

        }




    function postComment(parId,num){ //parId父级的id num为了确定是顶级评论框还是子级评论框，不传值的情况下是最高级别的评论，传值是子级的。
        var index = num?1:0;
        var time = num?1000:0;
        console.log(teststring($(".w-e-text").html()).trim()=="")
        if((index==0&&(/^[ ]+$/.test($(".w-e-text").html())||teststring($(".w-e-text").html()).trim()==""))||(index==1&&(/^[ ]+$/.test($(".commentInner").eq(index).val())||$(".commentInner").eq(index).val()==""))){
            $(".erroContent").eq(index).html("评论的内容不能为空");
        }else{
            $(".erroContent").eq(index).html("添加评论成功");

            $.ajax({
                url: '/all-api/comments',
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                data: JSON.stringify({
                    parent_id: parId?parId:null,
                    content: num?$(".commentInner").eq(1).val():$(".w-e-text").html(),
                    post_link: "/con_education"+locationHref,
                })
            })
                .done(function( data ) {
                    var data = data.collection;
                    setTimeout(function(){
                        getContent();
                    },time);
                })
                .fail(function( xhr, status, errorThrown ) {
                    console.log('失败');
                })
                .always(function( xhr, status ) {
                });

        }
    }

    $(".commentSubBtn").click(function(){
        postComment();

    })
    var openFlag = true; //判断前后是否是对一条信息评论，第二次点击时候清除评论区域。
    function addChiComment(elem,num){//一个值是二级评论，两个值是三级评论
        // console.log(this);
        var pos = parseInt(elem);
        for(var j = 0; j<$(".comContent").length;j++){
            if($(".comContent").eq(j).attr("parent_id")== pos){
                // console.log(j+" "+pos)
                if($(".comContent").eq(j).find(".commentInnerCon").length>0){
                    // console.log("同一个");
                    openFlag = false;
                }

            }
            $(".comContent").eq(j).find(".commentInnerCon").remove();
        }
        var num = num?num:elem;
        var str  =  "<div class=\"commentCon commentInnerCon\">"
            +"<textarea class=\"commentInner\" ></textarea>"
            +"<div class=\"flow\">"
            +"<p class=\"erroContent\"></p>"
            +"<div class=\"commentSubBtn fr\" onclick=\" postComment("+ num +",1)\" >评论</div>"
            +"</div></div>"
        for(var j = 0; j<$(".comContent").length;j++){
            if($(".comContent").eq(j).attr("parent_id")== pos){
                $(str).appendTo($(".comContent")[j]);
                if(!openFlag){
                    $(".comContent").eq(j).find(".commentInnerCon").remove();
                    openFlag = true;
                }
             }
        }

    }

// 让图片具有显示评论框和隐藏评论框的功能
// 点击评论字样的时候，如果它父级元素下有评论框，就隐藏它。



//    展示图片
    baguetteBox.run('.tz-gallery');
