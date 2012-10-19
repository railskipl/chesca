$(window).load(function() {
  $('#slider').nivoSlider({
    effect:'fade',
  slices:15,
  animSpeed:500,
  pauseTime:3000,
  display:false,
  directionNav:true, //Next & Prev
  directionNavHide:true, //Only show on hover
  controlNav:false, //1,2,3...
  pauseOnHover:true, //Stop animation while hovering
  beforeChange: function(){},
  afterChange: function(){}
  });
});
