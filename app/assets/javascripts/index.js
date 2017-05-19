/**
 * Created by Administrator on 2017/5/10.
 */
console.log("into index");
$('.slide.topSlide').ckSlide({
    autoPlay:true,
});
console.log($('.slide.topSlide'));
console.log("11aaaaaaaaaaaa111");
$(".slide.slide-left").ckSlide({
    autoPlay:true,
    add:true,
    // seamless:true,
    dir:"x",
});
console.log($(".slide.slide-left"));


$(".aboutHos li div a img").animate({
    width: "540px",
    height: "340px"
})

$(".centerNav li").click(function () {
    var i = $(this).index();
    $(".middle .column").hide().eq(i).show();
    console.log(this);
    $(this).addClass("active").siblings().removeClass("active");
    if($(".middle .column").eq(i).hasClass("aboutHos")){
        $(".aboutHos li div a img").animate({
            width: "540px",
            height: "340px"
        })
    }else {
        $(".aboutHos li div a img").animate({
            width:0,
            height:0
        })
    }
})
console.log($(".banner"));
bannerListFn(
    $(".banner"),
    $(".img-btn-list"),
    $(".left-btn"),
    $(".right-btn"),
    2000,
    true
);
