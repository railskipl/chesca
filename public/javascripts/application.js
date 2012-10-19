Application = {
    initialize: function() {
        this._installEventListeners();
    },

    _installEventListeners: function() {
        // Detect products onhover
        if ($$('.product')) {
            $('body').observe('mouseover', function(event) {
                var target = event.element();

                if (target.match('.product') || (target.match('.product *') && (target = target.up('.product')))) {
                    Application._onProductHover(target);
                }
            });
        }
    },

    _onProductHover: function(product) {
    //product.setStyle({borderWidth: '4px', width: '152px', height: '258px'});
    //product.morph({borderWidth: '10px', width: '140px', height: '246px'}, {duration: 0.5});
    }
};

Application.initialize();
var NewsFeedSlider = {
    maxCount: 0,
    currentIndex: 0,
    slideClass: 'news_slide',
    idPrefix: "feed",
    phaseOut: function(){
        new Effect.Fade(NewsFeedSlider.currentSlide(),{ duration: 2.0 });
    },
    init : function(options){
        options = options || {}
        if(options.className)
            NewsFeedSlider.slideClass = options.className;
        if(options.idPrefix)
            NewsFeedSlider.idPrefix = options.idPrefix;
        $$("."+NewsFeedSlider.slideClass).each(function(ele){
            Element.hide(ele);//new Effect.Fade(ele);
        });
        NewsFeedSlider.maxCount = $$("."+NewsFeedSlider.slideClass).length;
        if(NewsFeedSlider.maxCount==0)
            return;
        NewsFeedSlider.setCurrentIndex();
        NewsFeedSlider.phaseIn()
        //new Effect.Appear(NewsFeedSlider.currentSlide());
        setTimeout(function(){
            NewsFeedSlider.playSliding();
        },6000);

    },
    phaseIn : function(){
        new Effect.Appear(NewsFeedSlider.currentSlide(),{ duration: 3.0 });
    },
    currentSlide: function(){
        return $(NewsFeedSlider.idPrefix+"-"+NewsFeedSlider.currentIndex);
    },
    setCurrentIndex: function(){
        NewsFeedSlider.currentIndex = (NewsFeedSlider.currentIndex==NewsFeedSlider.maxCount) ? 1 : (NewsFeedSlider.currentIndex + 1)
    },
    playSliding: function(){
        NewsFeedSlider.phaseOut();
        NewsFeedSlider.setCurrentIndex();
        setTimeout(function(){
            NewsFeedSlider.phaseIn();
        },2000);
        setTimeout(function(){
            NewsFeedSlider.playSliding();
        },10000);
    }
}