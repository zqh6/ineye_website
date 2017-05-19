
(function($){
    $.fn.ckSlide = function(opts){
        opts = $.extend({}, $.fn.ckSlide.opts, opts);
        this.each(function(){
            var slidewrap = $(this).find('.slide-wrapper');
            var slide = slidewrap.find('li');
            var count = slide.length;
            var that = this;
            var index = 0;
            var time = null;
            $(this).data('opts', opts);
            // next
            $(this).find('.next').on('click', function(){
                if(opts['isAnimate'] == true){
                    return;
                }
                var old = index;
                if(index >= count - 1){
                    index = 0;
                }else{
                    index++;
                }
                change.call(that, index, old,count);
                return false;
            });
            // prev
            $(this).find('.prev').on('click', function(){
                if(opts['isAnimate'] == true){
                    return;
                }
                
                var old = index;
                if(index <= 0){
                    index = count - 1;
                }else{                                      
                    index--;
                }
                change.call(that, index, old,count);
                return false;
            });
            $(this).find('.slidebox li').each(function(cindex){
                $(this).on('click.slidebox', function(){
                    if(opts.seamless){
                        change2.call(that,cindex);
                        index = cindex;
                    }else {
                        change.call(that, cindex, index,count);
                        index = cindex;
                    }
                });
            });
            
            // focus clean auto play
            $(this).on('mouseover', function(){
                if(opts.autoPlay){
                    clearInterval(time);
                }
                $(this).find('.ctrl-slide').css({opacity:0.6});
            });
            //  leave
            $(this).on('mouseleave', function(){
                if(opts.autoPlay){
                    startAtuoPlay();
                }
                $(this).find('.ctrl-slide').css({opacity:0.15});
            });
            startAtuoPlay();
            // auto play
            function startAtuoPlay(){
                if(opts.autoPlay){
                    time  = setInterval(function(){
                        var old = index;
                        if(index >= count - 1){
                            index = 0;
                        }else{
                            index++;
                        }
                        change.call(that, index, old,count);
                    }, 2000);
                }
            }
            // 修正box
            var box = $(this).find('.slidebox');
            box.css({
                'margin-left':-(box.width() / 2)
            });
            // dir
            switch(opts.dir){
                case "x":
                    opts['width'] = $(this).width();
                    slidewrap.css({
                        'width':count * opts['width']
                    });
                    slide.css({
                        'float':'left',
                        'position':'relative',
                        'width':$(this).width()
                    });
                    slidewrap.wrap('<div class="slide-dir"></div>');
                    slide.show();
                    break;
            }
        });
    };
    function change2(show){
        var opts = $(this).data('opts');
        var x = show * opts['width'];
        $(this).find('.slide-wrapper').animate({'margin-left':-x},
            function(){
                opts['isAnimate'] = false;
                if(opts.add){
                    $(this).find(".inner").eq(show).show();
                }
            });
        opts['isAnimate'] = true;
        $(this).find('.slidebox li').removeClass('current');
        $(this).find('.slidebox li').eq(show).addClass('current');


    }
    function change(show, hide,count){
        var opts = $(this).data('opts');
        if(opts.dir == 'x'){
            var x = show * opts['width'];
            var con = $(this).find(".slide-wrapper li").length;
            $(this).find('.slide-wrapper').stop();
            if(opts.add) {
                $(this).find(".inner").hide();
            };
            if(opts.seamless){
                $(this).find('.slide-wrapper').animate({'margin-left':parseInt($(this).find(".slide-wrapper").css("margin-left"))-opts['width']},
                    function(){
                        opts['isAnimate'] = false;
                        if(opts.add){
                            $(this).find(".inner").eq(show).show();
                        }
                        if(-parseInt($(this).css("margin-left")) >= (con)*opts['width']){
                            $(this).find("li").eq(0).css({
                                left:0
                            });
                            $(this).css({
                                'margin-left':0
                            });
                        }

                    });
                if(-parseInt($(this).find(".slide-wrapper").css("margin-left")) >= (con-1)*opts['width']){
                    $(this).find(".slide-wrapper li").eq(0).css({
                        left:(count)*opts['width']
                    })

                }
                opts['isAnimate'] = true;
            }else {
                $(this).find('.slide-wrapper').animate({'margin-left':-x},
                    function(){
                        opts['isAnimate'] = false;
                        if(opts.add){
                            $(this).find(".inner").eq(show).show();
                        }
                    });
            }
            opts['isAnimate'] = true;

        }else{
            $(this).find('.slide-wrapper li').eq(hide).stop().animate({opacity:0},2000);
            $(this).find('.slide-wrapper li').eq(show).show().css({opacity:0}).stop().animate({opacity:1},2000);
        }
       
        $(this).find('.slidebox li').removeClass('current');
        $(this).find('.slidebox li').eq(show).addClass('current');
    }
    $.fn.ckSlide.opts = {
        autoPlay: false,
        dir: null,
        isAnimate: false,
        add:false,
        seamless:false
    };
})(jQuery);