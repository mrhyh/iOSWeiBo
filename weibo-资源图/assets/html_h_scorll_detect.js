(function(x, y, w) {

    var iw = window.innerWidth;
    var sc = iw / w;

    var newX = x * sc;
    var newY = y * sc;

    var el = document.elementFromPoint(newX, newY);

    var preEl = null;
    var scrollable = null;
    
    while (el) {
        if (el.scrollWidth > el.clientWidth * 1.1) {
            var styles = window.getComputedStyle(el);
            var overflow = styles.overflow + styles.overflowX;
            
            if ((/(auto|scroll)/).test(overflow)) {
                scrollable = el;
                break;
            } else if ((/(visible)/).test(overflow)) {
                var st = window.getComputedStyle(preEl);
                if(st == null){
                	break;
                }
                var transform = st.getPropertyCSSValue('-webkit-transform') || st.getPropertyCSSValue('transform');
                if (transform && transform.length) {
                    var transValues = transform[0];
                    if (transValues.length == 6) {
                        var xValue = transValues[4];
                        var x = parseInt(xValue.cssText);
                        if (!isNaN(x) && x < 0) {
                            scrollable = el;
                            break;
                        }
                    }
                }
            } else if ((/(hidden)/).test(overflow)) {
                var st = window.getComputedStyle(preEl);
                var transform = st.getPropertyCSSValue('-webkit-transform') || st.getPropertyCSSValue('transform');
                if (transform && transform.length) {
                    var transValues = transform[0];
                    if (transValues.length == 6) {
                        var xValue = transValues[4];
                        var x = parseInt(xValue.cssText);
                        if (!isNaN(x) && x != 0) {
                            scrollable = el;
                            break;
                        }
                    }
                }
            }
        }
        preEl = el;
        el = el.parentElement;
    }

    var params = (scrollable != null);

    WeiboJSBridge.invoke('htmlHScrollDetect', {
        'result': params
    });
    return params;
})