if (window.Prototype) {
  /*
   * Options:
   *
   * - onCreateImage: callback
   * - onPreloadFinish: callback
   * - effectOptions: hash
   *
   */
  function Slideglide(container, imageUrls, options) {
    // Extend container
    this.container = $(container);

    // Initialize options
    this.options = options || {};

    // Extract original afterFinish callback
    this.originalAfterFinish = options.effectOptions && options.effectOptions.afterFinish;

    // This flag indicates if the initial image preload has
    // finished
    this.preloaded = false;
    this.imagesToPreload = imageUrls.length * 2;

    // Container for images
    this.images = [];

    // The sum of all thumbnail widths plus margins
    this.collapsedWidth = 0;

    // This will contain the current event in course
    // when animating
    this.ongoingEffect = null;

    this.selectedImage = null;

    this._initializeContainerStyle();
    this._initializeSlider();
    this._initializeImages(imageUrls);
  };

  //Slideglide.WIDTH_INCREMENT_STYLE_RULES = 'margin-left margin-right padding-left padding-right border-left-width border-right-width'.split(/\s+/);

  Slideglide.prototype = {

    /***************************************************************************
     * Public methods
     ***************************************************************************/

    nextImage: function() {
      if (!this.selectedImage) return;
      this.selectImage(this.selectedImage.next('img') || this.slider.down('img'));
    },

    prevImage: function() {
      if (!this.selectedImage) return;
      this.selectImage(this.selectedImage.previous('img') || this.slider.down('img:last-child'));
    },

    addImage: function(thumbnailUrl, fullsizeUrl) {
      // Create a closure alias for the calling context (used in callbacks below)
      var _this = this;

      var thumbnail = $(new Image);
      var fullsize  = new Image;

      // Run custom initialization of the image element if available
      if (this.options.onCreateImage) {
        this.options.onCreateImage(thumbnail);
      }

      // Define an onload callback for the thumbnail
      thumbnail.onload = function() {
        
        // Add the width of this image to the computed total "collapsed width" of the slider...
        // We need to take into account margins, paddings and borders
        //_this.collapsedWidth += thumbnail.width + _this._computeExcessWidth(thumbnail);

        // Keep the original width around
        thumbnail.thumbnailWidth = thumbnail.width;
        thumbnail.thumbnailHeight = thumbnail.height;

        if (!_this.preloaded) _this._preloadCheck();

        // Get rid of the callback once it ran
        thumbnail.onload = null;

      }

      // Define an onload callback for the fullsize image
      // This is only needed for the initial preload
      fullsize.onload = function() {
        
        // Keep the width of the fullsize image for resizing later
        // The height shouldn't be needed as the aspect ratio will be kept
        // by the browser
        thumbnail.fullsizeWidth = fullsize.width;
        thumbnail.fullsizeHeight = fullsize.height;

        if (!_this.preloaded) _this._preloadCheck();

      }

      // Keep a reference to the image paths
      // This relies on the images being cached in memory
      // TODO: check if disabling browser cache affects this, otherwise find a workaround
      thumbnail.fullsizeSrc = fullsizeUrl;
      thumbnail.thumbnailSrc = thumbnailUrl;

      // Load the images
      thumbnail.src = thumbnailUrl;
      fullsize.src  = fullsizeUrl;

      // Ensure we have "vertical-align: middle" set
      if (thumbnail.getStyle('vertical-align') != 'middle') {
        thumbnail.style.verticalAlign = 'middle';
      }

      // Add the image to the slider
      this.slider.appendChild(thumbnail);

    },

    /***************************************************************************
     * Private methods
     ***************************************************************************/

    // Check if all initial images were preloaded
    _preloadCheck: function() {
      if (!--this.imagesToPreload) {
        this.options.onPreloadFinish && this.options.onPreloadFinish();
        this._insertSlider();
      }
    },

    // Plug the slider inside its container (making it visible)
    _insertSlider: function() {
      // Insert slider
      this.container.appendChild(this.slider);

      // Select first image
      this.selectImage(this.slider.getElementsByTagName('img')[0]);
    },

    // Make sure the container has the needed CSS properties
    // for the slideshow effect
    _initializeContainerStyle: function() {
      this.container.setStyle({
        overflow: 'hidden'
      }).makePositioned();
    },

    // Create the slider element and insert it in the container
    _initializeSlider: function() {
      this.slider = new Element('div', {'class': 'slideglide_slider'}).setStyle({
        display:    'inline-block',
        position:   'relative',
        whiteSpace: 'nowrap',
        height:     this.container.offsetHeight + 'px',
        lineHeight: this.container.offsetHeight + 'px'
      });

      // Register onclick event to select images
      var _this = this;
      this.slider.observe('click', function(event) {
        if (event.element().match('img')) {
          _this.selectImage(event.element());
        }
      });

      // If we're on IE...
      /*@cc_on
        // We use a span here because IE6 will only accept inline-block for naturally inline elements
        this.slider.appendChild(new Element('span', {style: 'display: inline-block; height: 100%; width: 0px;'}).update('&#8205;'));
      @*/

      //this.container.insert({bottom: this.slider});
    },

    // URLs must be given in [[thumbnail-url, fullsize-url], ...] format
    _initializeImages: function(imageUrls) {
      var _this = this;
      imageUrls.each(function(imageUrl) {
        _this.addImage(imageUrl[0], imageUrl[1]);
      });
    },

    // Compute the sum of all width-affecting CSS rules for the given element
    _computeExcessWidth: function(element) {
      return Slideglide.WIDTH_INCREMENT_STYLE_RULES.inject(0, function(r, p) { return r + parseInt(element.getStyle(p)); });
    }
  };

  // Conditional transition effect (depending on the presence of Scriptaculous)
  if (window.Effect) {

    // Scriptaculous-powered animated transitions
    Slideglide.prototype.selectImage = function(image) {
      
      if (image == this.selectedImage) return;

      // Stop any previously running effect
      if (this.ongoingEffect) {
        this.ongoingEffect.cancel();
      }

      // Create an array to store all parallel effects before firing them
      var effects = [];

      // Compute offset correction
      // If the current selected image is at the left of the new image
      // then it will affect the left offset of the new image, so we need
      // to account for that to keep everything well centered
      var offsetCorrection = 0;
      if (this.selectedImage) {
        if (image.previousSiblings().include(this.selectedImage)) {
          offsetCorrection = this.selectedImage.fullsizeWidth - this.selectedImage.thumbnailWidth;
        }
      }

      // Move slider
      effects.push(new Effect.Morph(this.slider, {
        style: {
          left: (this.container.offsetWidth / 2) - (image.fullsizeWidth / 2) - image.offsetLeft + offsetCorrection + 'px'
        },

        sync: true
      }));

      // Enlarge image
      effects.push(new Effect.Morph(image, {
        style: {
          width: image.fullsizeWidth + 'px',
          height: image.fullsizeHeight + 'px'
        },

        sync: true
      }));

      // Restore old selected image
      if (this.selectedImage) {
        var selectedImage = this.selectedImage;
        
        effects.push(new Effect.Morph(selectedImage, {
          style: {
            width: selectedImage.thumbnailWidth + 'px',
            height: selectedImage.thumbnailHeight + 'px'
          },

          afterFinish: function() {
            selectedImage.src = selectedImage.thumbnailSrc;
            selectedImage.removeClassName('selected');
          },

          sync: true
        }));
      }

      var _this = this;

      // Roll camera!
      this.ongoingEffect = new Effect.Parallel(effects, Object.extend(this.options.effectOptions || {}, {
        afterFinish: function() {
          _this.ongoingEffect = null;

          image.src = image.fullsizeSrc;
          image.addClassName('selected');

          // Run user's custom afterFinish
          _this.originalAfterFinish && _this.originalAfterFinish();
        }
      }));

      this.selectedImage = image;
    };

  } else {

    // If we don't have Scriptaculous loaded, fallback to static image switching
    Slideglide.prototype.selectImage = function(image) {

      if (image == this.selectedImage) return;

      // Restore previously selected image to original size
      if (this.selectedImage) {
        this.selectedImage.src = this.selectedImage.thumbnailSrc;
        this.selectedImage.removeClassName('selected');
      }

      image.src = image.fullsizeSrc;
      image.addClassName('selected');

      this.slider.style.left = (this.container.offsetWidth / 2) - (image.fullsizeWidth / 2) - image.offsetLeft + 'px';

      // Update selected image pointer
      this.selectedImage = image;

    };
  }
} else {
  alert('Prototype lib not found! Please include it before including slideglide.js.')
}
