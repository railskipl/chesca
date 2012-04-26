var currentButton = $('tabs').down('.button');

function cacheImages(images) {
  images.each(function(image) {
    new Image().src = image;
  });
}

$('main-image-zoomer').observe('click', function(event) {
  var thumbs = $('thumbnails-wrapper');
  thumbs.setStyle({ display: (thumbs.getStyle('display') == 'none') ? 'block' : 'none' });
});

zoomer = new Zoomer('main-image-zoomer');

if($('thumbnails-wrapper')) {
  $('thumbnails-wrapper').observe('mouseover', function(event) {
    var target = event.element();
    if(target.match('img')) {
      $('main-image').src = target.readAttribute('data-src');
      zoomer.source.small = zoomer.selected = target.readAttribute('data-src');
      zoomer.source.large = target.readAttribute('data-zoom');
    }
  });

  $('main-image').up('.images').observe('mouseover', function(event) {
    phaseIn($('thumbnails-wrapper'));
  });
  $('main-image').up('.images').observe('mouseout', function(event) {
    phaseOut($('thumbnails-wrapper'));
  });
}

$('tabs').down('.buttons').observe('mousedown', function(event) {
  event.stop();
});

$('tabs').observe('click', function(event) {
  var target = event.element();
  if(target.match('.button')) {
    currentButton.removeClassName('active');
    $(currentButton.readAttribute('data-tab')).setStyle({ display: 'none' });
    currentButton = target;
    currentButton.addClassName('active');
    $(currentButton.readAttribute('data-tab')).setStyle({ display: 'block' });
  }
});

if($('view-sizing-chart')) {
  $('view-sizing-chart').observe('click', function(event) {
    $('sizing-chart').setStyle({ display: 'block' });
  });
  $('sizing-chart').observe('click', function(event) {
    $('sizing-chart').setStyle({ display: 'none' });
  });
}

