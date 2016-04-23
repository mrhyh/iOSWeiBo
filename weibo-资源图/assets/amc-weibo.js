var amc = {};
amc.userAgent = navigator.userAgent.toLowerCase();
amc.isFlybird = amc.userAgent.indexOf("flybird") >= 0;
amc.isAndroid = amc.userAgent.indexOf("android") >= 0; // 是否为android平台

amc.isIOS = (amc.isFlybird && (!amc.isAndroid));

// 资源路径
amc.path = amc.isAndroid ? "com.alipay.android.app/" : "AlipaySDK.bundle/";
amc.rpc = flybird.rpcData;

amc.res = {};
amc.res.navBack = amc.path + 'alipay_msp_back';
amc.res.user = amc.path + 'alipay_msp_user';
amc.res.arrowRight = amc.path + 'alipay_msp_arrow_right';
amc.res.bankLogo = amc.path + 'alipay_msp_bank_logo';

amc.specs = {};
amc.specs.navHeight =  amc.isAndroid ? 48 : 41;
amc.specs.bodyHeight = window.innerHeight - amc.specs.navHeight;

amc.BLUE = 'blue';
amc.GREEN = 'green';
amc.RED = 'red';

amc.BLUE_CARD = 'amc-card-blue';
amc.GREEN_CARD = 'amc-card-green';
amc.RED_CARD = 'amc-card-red';

amc.fn = {};
amc.fn.cardColor = function(color){
    switch(color){
        case amc.RED:
            return amc.RED_CARD;
        case amc.GREEN:
            return amc.GREEN_CARD;
        default:
            return amc.BLUE_CARD;
    }
};
amc.fn.getTag = function(id) {
    return document.getElementById(id);
};

amc.fn.create = function(tagName, className, parent){
    var tag = document.createElement(tagName);
    if(tag && className) {
        tag.className = className;
    }
    
    if(tag && parent){
        parent.appendChild(tag);
    }
    
    return tag;
};

amc.fn.isString = function(str){
    return ((str instanceof String) || typeof str == 'string');
};

amc.fn.show = function(tag)
{
    if(tag){
        tag = amc.fn.isString(tag) ? document.getElementById(tag) : tag;
        
        if(tag){
            tag.style.display = '-webkit-box';
        }
    }
};

amc.fn.hide = function(tag)
{
    if(tag){
        tag = amc.fn.isString(tag) ? document.getElementById(tag) : tag;
        
        if(tag){
            tag.style.display = 'none';
        }
    }
};