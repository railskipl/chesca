/*
Copyright (c) 2009 Victor Stanciu - http://www.victorstanciu.ro

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

Zoomer = Class.create({
    initialize: function (element, options, preload) {
        
        this.element    = $(element);
        this.image      = this.element.down('img');
        this.source     = {
            small: this.image.src,
            large: this.element.href
        }

        // Restart when small image fully loaded
        if (!preload) {
            var image    = new Image();
            image.src    = this.source.small;
            image.onload = this.initialize.bind(this).curry(element, options, true);
            return;
        }

        this.selected   = this.source.small;

        this.options = Object.extend({
            trigger:        null,
            afterZoomIn:    null,
            afterZoomOut:   null
        }, options || {});

        this.position = this.element.cumulativeOffset();
        this.dimensions = {
            small: {
                width:  this.image.getWidth(),
                height: this.image.getHeight()
            }
        }

        this.scaleReport = 1;

        // Large image preloading
        this.preload        = new Image();
        this.preload.src    = this.source.large;
        this.preload.onload = this.loaded.bind(this);

        // Wrappers
        this.scroller = (new Element('div')).setStyle({
            overflow: 'auto',
            width: this.dimensions.small.width + 20 + 'px',
            height: this.dimensions.small.height + 20 + 'px'
        });

        this.element.wrap(this.scroller);

        this.wrapper = (new Element('div').setStyle({
            overflow: 'hidden',
            width: this.dimensions.small.width + 'px',
            height: this.dimensions.small.height + 'px'
        }));

        this.scroller.wrap(this.wrapper);


        // Zoom onclick on additional trigger
        if (this.options.trigger) {
            $(this.options.trigger).observe('click', this.click.bindAsEventListener(this));
        }
        
        this.element.observe('click',       this.click.bindAsEventListener(this));
        this.element.observe('mousemove',   this.move.bindAsEventListener(this));
    },


    click: function (event) {
        event.stop();
        switch (this.selected) {
            case this.source.small:
                if (this.element.loaded) {
                    this.image.src = this.selected = this.source.large;
                    this.element.show();                    
                    this.move(event);
                    if (this.options.afterZoomIn) {
                        this.options.afterZoomIn();
                    }
                } else {                    
                    this.element.hide();
                    // Periodically check if target image has loaded
                    this.click.bind(this).delay(0.5, event);
                }
            break;
            case this.source.large:
                this.image.src = this.selected = this.source.small;
                if (this.options.afterZoomOut) {
                    this.options.afterZoomOut();
                }
            break;
        }
    },


    move: function (event) {
        var x = event.pointerX() - this.position.left;
        var y = event.pointerY() - this.position.top;

        this.scroller.scrollLeft = x * this.scaleReport - x;
        this.scroller.scrollTop  = y * this.scaleReport - y;
    },


    loaded: function () {
        this.element.loaded = true;
        this.dimensions.large = {
            width:  this.preload.width,
            height: this.preload.height
        };

        this.scaleReport = this.dimensions.large.width / this.dimensions.small.width;
    }
});