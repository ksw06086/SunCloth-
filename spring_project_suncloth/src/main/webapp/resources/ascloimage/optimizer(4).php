/**
 * 비동기식 데이터 - 쿠폰 갯수
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Couponcnt');
CAPP_ASYNC_METHODS.Couponcnt = {
    __iCouponCount: null,

    __$target: $('.xans-layout-myshopcouponcount'),
    __$target2: $('#xans_myshop_coupon_cnt'),
    __$target3: CAPP_ASYNC_METHODS.$xansMyshopMain.find('.xans_myshop_main_coupon_cnt'),
    __$target4: $('#xans_myshop_bankbook_coupon_cnt'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }

            if (this.__$target2.length > 0) {
                return true;
            }

            if (this.__$target3.length > 0) {
                return true;
            }

            if (this.__$target4.length > 0) {
                return true;
            }

            if ( typeof EC_APPSCRIPT_SDK_DATA != "undefined" && jQuery.inArray('promotion', EC_APPSCRIPT_SDK_DATA ) > -1 ) {
                return true;
            }
        }

        return false;
    },
    
    restoreCache: function()
    {
        var sCookieName = 'couponcount_' + EC_SDE_SHOP_NUM;
        var re = new RegExp('(?:^| |;)' + sCookieName + '=([^;]+)');
        var aCookieValue = document.cookie.match(re);
        if (aCookieValue) {
            this.__iCouponCount = parseInt(aCookieValue[1], 10);
            return true;
        }
        
        return false;
    },
    setData: function(sData)
    {
        this.__iCouponCount = Number(sData);
    },

    execute: function()
    {
        this.__$target.html(this.__iCouponCount);

        if (SHOP.getLanguage() === 'ko_KR') {
            this.__$target2.html(this.__iCouponCount + '개');
        } else {
            this.__$target2.html(this.__iCouponCount);
        }

        this.__$target3.html(this.__iCouponCount);
        this.__$target4.html(this.__iCouponCount);
    },

    getData: function()
    {
        return {
            count: this.__iCouponCount
        };
    }
};
/**
 * 비동기식 데이터 - 적립금
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Mileage');
CAPP_ASYNC_METHODS.Mileage = {
    __sAvailMileage: null,
    __sUsedMileage: null,
    __sTotalMileage: null,
    __sUnavailMileage: null,
    __sReturnedMileage: null,

    __$target: $('#xans_myshop_mileage'),
    __$target2: $('#xans_myshop_bankbook_avail_mileage, #xans_myshop_summary_avail_mileage'),
    __$target3: $('#xans_myshop_bankbook_used_mileage, #xans_myshop_summary_used_mileage'),
    __$target4: $('#xans_myshop_bankbook_total_mileage, #xans_myshop_summary_total_mileage'),
    __$target5: $('#xans_myshop_summary_unavail_mileage'),
    __$target6: $('#xans_myshop_summary_returned_mileage'),
    __$target7: $('#xans_myshop_avail_mileage'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }

            if (this.__$target2.length > 0) {
                return true;
            }

            if (this.__$target3.length > 0) {
                return true;
            }

            if (this.__$target4.length > 0) {
                return true;
            }

            if (this.__$target5.length > 0) {
                return true;
            }

            if (this.__$target6.length > 0) {
                return true;
            }

            if (this.__$target7.length > 0) {
                return true;
            }

            if ( typeof EC_APPSCRIPT_SDK_DATA != "undefined" && jQuery.inArray('customer', EC_APPSCRIPT_SDK_DATA ) > -1 ) {
                return true;
            }
        }

        return false;
    },

    restoreCache: function()
    {
        // 특정 경로 룰의 경우 복구 취소
        if (PathRoleValidator.isInvalidPathRole()) {
            return false;
        }

        // 쿠키로부터 데이터 획득
        var sAvailMileage = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_avail_mileage_' + EC_SDE_SHOP_NUM);
        var sReturnedMileage = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_returned_mileage_' + EC_SDE_SHOP_NUM);
        var sUnavailMileage = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_unavail_mileage_' + EC_SDE_SHOP_NUM);
        var sUsedMileage = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_used_mileage_' + EC_SDE_SHOP_NUM);

        // 데이터가 하나라도 없는경우 복구 실패
        if (sAvailMileage === null
            || sReturnedMileage === null
            || sUnavailMileage === null
            || sUsedMileage === null
        ) {
            return false;
        }

        // 전체 마일리지 계산
        var sTotalMileage = (parseFloat(sAvailMileage) +
            parseFloat(sUnavailMileage) +
            parseFloat(sUsedMileage)).toString();

        // 단위정보를 계산하여 필드에 셋
        this.__sAvailMileage = parseFloat(sAvailMileage).toFixed(2);
        this.__sReturnedMileage = parseFloat(sReturnedMileage).toFixed(2);
        this.__sUnavailMileage = parseFloat(sUnavailMileage).toFixed(2);
        this.__sUsedMileage = parseFloat(sUsedMileage).toFixed(2);
        this.__sTotalMileage = parseFloat(sTotalMileage).toFixed(2);

        return true;
    },

    setData: function(aData)
    {
        this.__sAvailMileage = parseFloat(aData['avail_mileage'] || 0).toFixed(2);
        this.__sUsedMileage = parseFloat(aData['used_mileage'] || 0).toFixed(2);
        this.__sTotalMileage = parseFloat(aData['total_mileage'] || 0).toFixed(2);
        this.__sUnavailMileage = parseFloat(aData['unavail_mileage'] || 0).toFixed(2);
        this.__sReturnedMileage = parseFloat(aData['returned_mileage'] || 0).toFixed(2);
    },

    execute: function()
    {
        this.__$target.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sAvailMileage));
        this.__$target2.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sAvailMileage));
        this.__$target3.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sUsedMileage));
        this.__$target4.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sTotalMileage));
        this.__$target5.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sUnavailMileage));
        this.__$target6.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sReturnedMileage));
        this.__$target7.html(SHOP_PRICE_FORMAT.toShopMileagePrice(this.__sAvailMileage));
    },

    getData: function()
    {
        return {
            available_mileage: this.__sAvailMileage,
            used_mileage: this.__sUsedMileage,
            total_mileage: this.__sTotalMileage,
            returned_mileage: this.__sReturnedMileage,
            unavailable_mileage: this.__sUnavailMileage
        };
    }
};
/**
 * 비동기식 데이터 - 예치금
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Deposit');
CAPP_ASYNC_METHODS.Deposit = {
    __sTotalDeposit: null,
    __sAllDeposit: null,
    __sUsedDeposit: null,
    __sRefundWaitDeposit: null,
    __sMemberTotalDeposit: null,

    __$target: $('#xans_myshop_deposit'),
    __$target2: $('#xans_myshop_bankbook_deposit'),
    __$target3: $('#xans_myshop_summary_deposit'),
    __$target4: $('#xans_myshop_summary_all_deposit'),
    __$target5: $('#xans_myshop_summary_used_deposit'),
    __$target6: $('#xans_myshop_summary_refund_wait_deposit'),
    __$target7: $('#xans_myshop_total_deposit'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }

            if (this.__$target2.length > 0) {
                return true;
            }

            if (this.__$target3.length > 0) {
                return true;
            }

            if (this.__$target4.length > 0) {
                return true;
            }

            if (this.__$target5.length > 0) {
                return true;
            }

            if (this.__$target6.length > 0) {
                return true;
            }

            if (this.__$target7.length > 0) {
                return true;
            }

            if ( typeof EC_APPSCRIPT_SDK_DATA != "undefined" && jQuery.inArray('customer', EC_APPSCRIPT_SDK_DATA ) > -1 ) {
                return true;
            }
        }

        return false;
    },

    restoreCache: function()
    {
        // 특정 경로 룰의 경우 복구 취소
        if (PathRoleValidator.isInvalidPathRole()) {
            return false;
        }

        // 쿠키로부터 데이터 획득
        var sAllDeposit = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_all_deposit_' + EC_SDE_SHOP_NUM);
        var sUsedDeposit = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_used_deposit_' + EC_SDE_SHOP_NUM);
        var sRefundWaitDeposit = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_deposit_refund_wait_' + EC_SDE_SHOP_NUM);
        var sMemberTotalDeposit = CAPP_ASYNC_METHODS._getCookie('ec_async_cache_member_total_deposit_' + EC_SDE_SHOP_NUM);

        // 데이터가 하나라도 없는경우 복구 실패
        if (sAllDeposit === null
            || sUsedDeposit === null
            || sRefundWaitDeposit === null
            || sMemberTotalDeposit === null
        ) {
            return false;
        }

        // 사용 가능한 예치금 계산
        var sTotalDeposit = (parseFloat(sAllDeposit) -
            parseFloat(sUsedDeposit) -
            parseFloat(sRefundWaitDeposit)).toString();

        // 단위정보를 계산하여 필드에 셋
        this.__sTotalDeposit = parseFloat(sTotalDeposit).toFixed(2);
        this.__sAllDeposit = parseFloat(sAllDeposit).toFixed(2);
        this.__sUsedDeposit = parseFloat(sUsedDeposit).toFixed(2);
        this.__sRefundWaitDeposit = parseFloat(sRefundWaitDeposit).toFixed(2);
        this.__sMemberTotalDeposit = parseFloat(sMemberTotalDeposit).toFixed(2);

        return true;
    },

    setData: function(aData)
    {
        this.__sTotalDeposit = parseFloat(aData['total_deposit'] || 0).toFixed(2);
        this.__sAllDeposit = parseFloat(aData['all_deposit'] || 0).toFixed(2);
        this.__sUsedDeposit = parseFloat(aData['used_deposit'] || 0).toFixed(2);
        this.__sRefundWaitDeposit = parseFloat(aData['deposit_refund_wait'] || 0).toFixed(2);
        this.__sMemberTotalDeposit = parseFloat(aData['member_total_deposit'] || 0).toFixed(2);
    },

    execute: function()
    {
        this.__$target.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sTotalDeposit));
        this.__$target2.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sTotalDeposit));
        this.__$target3.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sTotalDeposit));
        this.__$target4.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sAllDeposit));
        this.__$target5.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sUsedDeposit));
        this.__$target6.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sRefundWaitDeposit));
        this.__$target7.html(SHOP_PRICE_FORMAT.toShopDepositPrice(this.__sMemberTotalDeposit));
    },

    getData: function()
    {
        return {
            total_deposit: this.__sTotalDeposit,
            used_deposit: this.__sUsedDeposit,
            refund_wait_deposit: this.__sRefundWaitDeposit,
            all_deposit: this.__sAllDeposit,
            member_total_deposit: this.__sMemberTotalDeposit
        };
    }
};
/**
 * 비동기식 데이터 - 관심상품 갯수
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Wishcount');
CAPP_ASYNC_METHODS.Wishcount = {
    __iWishCount: null,

    __$target: $('#xans_myshop_interest_prd_cnt'),
    __$target2: CAPP_ASYNC_METHODS.$xansMyshopMain.find('.xans_myshop_main_interest_prd_cnt'),

    isUse: function()
    {
        if (this.__$target.length > 0) {
            return true;
        }
        if (this.__$target2.length > 0) {
            return true;
        }

        if ( typeof EC_APPSCRIPT_SDK_DATA != "undefined" && jQuery.inArray('personal', EC_APPSCRIPT_SDK_DATA ) > -1 ) {
            return true;
        }

        return false;
    },

    restoreCache: function()
    {
        var sCookieName = 'wishcount_' + EC_SDE_SHOP_NUM;
        var re = new RegExp('(?:^| |;)' + sCookieName + '=([^;]+)');
        var aCookieValue = document.cookie.match(re);
        if (aCookieValue) {
            this.__iWishCount = parseInt(aCookieValue[1], 10);
            return true;
        }

        return false;
    },

    setData: function(sData)
    {
        this.__iWishCount = Number(sData);
    },

    execute: function()
    {
        if (SHOP.getLanguage() === 'ko_KR') {
            this.__$target.html(this.__iWishCount + '개');
        } else {
            this.__$target.html(this.__iWishCount);
        }

        this.__$target2.html(this.__iWishCount);
    },

    getData: function()
    {
        return {
            count: this.__iWishCount
        };
    }
};
/**
 * 비동기식 데이터 - 최근 본 상품
 */
CAPP_ASYNC_METHODS.aDatasetList.push('recent');
CAPP_ASYNC_METHODS.recent = {
    STORAGE_KEY: 'localRecentProduct' +  EC_SDE_SHOP_NUM,

    __$target: $('.xans-layout-productrecent'),

    __aData: null,

    isUse: function()
    {
        this.__$target.hide();

        if (this.__$target.find('.xans-record-').length > 0) {
            return true;
        }

        return false;
    },

    restoreCache: function()
    {
        this.__aData = [];

        var iTotalCount = CAPP_ASYNC_METHODS.RecentTotalCount.getData();
        if (iTotalCount == 0) {
            // 총 갯수가 없는 경우 복구할 것이 없으므로 복구한 것으로 리턴
            return true;
        }

        var sAdultImage = '';

        if (window.sessionStorage === undefined) {
            return false;
        }

        var sSessionStorageData = window.sessionStorage.getItem(this.STORAGE_KEY);
        if (sSessionStorageData === null) {
            return false;
        }

        var iViewCount = EC_FRONT_JS_CONFIG_SHOP.recent_count;

        this.__aData = [];
        var aStorageData = $.parseJSON(sSessionStorageData);
        var iCount = 1;
        var bDispRecent = true;
        for (var iKey in aStorageData) {
            var sProductImgSrc = aStorageData[iKey].sImgSrc;

            if (isFinite(iKey) === false) {
                continue;
            }

            var aDataTmp = [];
            aDataTmp.recent_img = getImageUrl(sProductImgSrc);
            aDataTmp.name = aStorageData[iKey].sProductName;
            aDataTmp.disp_recent = true;
            aDataTmp.is_adult_product = aStorageData[iKey].isAdultProduct;
            aDataTmp.link_product_detail = aStorageData[iKey].link_product_detail;

            //aDataTmp.param = '?product_no=' + aStorageData[iKey].iProductNo + '&cate_no=' + aStorageData[iKey].iCateNum + '&display_group=' + aStorageData[iKey].iDisplayGroup;
            aDataTmp.param = filterXssUrlParameter(aStorageData[iKey].sParam);
            if ( iViewCount < iCount ) {
                bDispRecent = false;
            }
            aDataTmp.disp_recent = bDispRecent;

            iCount++;
            this.__aData.push(aDataTmp);
        }

        return true;

        /**
         * get SessionStorage image url
         * @param sNewImgUrl DB에 저장되어 있는 tiny값
         */
        function getImageUrl(sImgUrl)
        {
            if ( typeof(sImgUrl) === 'undefined' || sImgUrl === null) {
                return;
            }
            var sNewImgUrl = '';

            if ( sImgUrl.indexOf('http://') >= 0 || sImgUrl.indexOf('https://')  >= 0 || sImgUrl.substr(0, 2) === '//') {
                sNewImgUrl = sImgUrl;
            } else {
                sNewImgUrl = '/web/product/tiny/' +  sImgUrl;
            }

            return sNewImgUrl;
        }

        /**
         * 파라미터 URL에서 XSS 공격 관련 파라미터를 필터링합니다. ECHOSTING-162977
         * @param string sParam 파라미터
         * @return string 필터링된 파라미터
         */
        function filterXssUrlParameter(sParam)
        {
            sParam = sParam || '';

            var sPrefix = '';
            if (sParam.substr(0, 1) === '?') {
                sPrefix = '?';
                sParam = sParam.substr(1);
            }

            var aParam = {};

            var aParamList = (sParam).split('&');
            $.each(aParamList, function() {
                var aMatch = this.match(/^([^=]+)=(.*)$/);
                if (aMatch) {
                    aParam[aMatch[1]] = aMatch[2];
                }
            });

            return sPrefix + $.param(aParam);
        }

    },

    setData: function(aData)
    {
        this.__aData = aData;

        // 쿠키엔 있지만 sessionStorage에 없는 데이터 복구
        if (window.sessionStorage) {

            var oNewStorageData = [];

            for ( var i = 0 ; i < aData.length ; i++) {
                if (aData[i].bNewProduct !== true) {
                    continue;
                }

                var aNewStorageData = {
                    'iProductNo': aData[i].product_no,
                    'sProductName': aData[i].name,
                    'sImgSrc': aData[i].recent_img,
                    'sParam': aData[i].param,
                    'link_product_detail': aData[i].link_product_detail
                };

                oNewStorageData.push(aNewStorageData);
            }

            if ( oNewStorageData.length > 0 ) {
                sessionStorage.setItem(this.STORAGE_KEY , $.toJSON(oNewStorageData));
            }
        }
    },

    execute: function()
    {
        var sAdult19Warning = EC_FRONT_JS_CONFIG_SHOP.adult19Warning;

        var aData = this.__aData;

        var aNodes = this.__$target.find('.xans-record-');
        var iRecordCnt = aNodes.length;
        var iAddedElementCount = 0;

        var aNodesParent = $(aNodes[0]).parent();
        for ( var i = 0 ; i < aData.length ; i++) {
            if (!aNodes[i]) {
                $(aNodes[iRecordCnt - 1]).clone().appendTo(aNodesParent);
                iAddedElementCount++;
            }
        }

        if (iAddedElementCount > 0) {
            aNodes = this.__$target.find('.xans-record-');
        }

        if (aData.length > 0) {
            this.__$target.show();
        }

        for ( var i = 0 ; i < aData.length ; i++) {
            assignVariables(aNodes[i], aData[i]);
        }

        // 종료 카운트 지정
        if (aData.length < aNodes.length) {
            iLength = aData.length;
            deleteNode();
        }

        recentBntInit(this.__$target);

        /**
         * 패치되지 않은 노드를 제거
         */
        function deleteNode()
        {
            for ( var i = iLength ; i < aNodes.length ; i++) {
                $(aNodes[i]).remove();
            }
        }

        /**
         * oTarget 엘레먼트에 aData의 변수를 어싸인합니다.
         * @param Element oTarget 변수를 어싸인할 엘레먼트
         * @param array aData 변수 데이터
         */
        function assignVariables(oTarget, aData)
        {
            var recentImage = aData.recent_img;

            if (sAdult19Warning === 'T' && CAPP_ASYNC_METHODS.member.getMemberIsAdult() === 'F' && aData.is_adult_product === 'T') {
                    recentImage = EC_FRONT_JS_CONFIG_SHOP.adult19BaseTinyImage;
            };

            var $oTarget = $(oTarget);

            var sHtml = $oTarget.html();

            sHtml = sHtml.replace('about:blank', recentImage)
                         .replace('##param##', aData.param)
                         .replace('##name##',aData.name)
                         .replace('##link_product_detail##', aData.link_product_detail);
            $oTarget.html(sHtml);

            if (aData.disp_recent === true) {
                $oTarget.removeClass('displaynone');
            }
        }

        function recentBntInit($target)
        {
            // 화면에 뿌려진 갯수
            var iDisplayCount = 0;
            // 보여지는 style
            var sDisplay = '';
            var iIdx = 0;
            //
            var iDisplayNoneIdx = 0;

            var nodes = $target.find('.xans-record-').each(function()
            {
                sDisplay = $(this).css('display');
                if (sDisplay != 'none') {
                    iDisplayCount++;
                } else {
                    if (iDisplayNoneIdx == 0) {
                        iDisplayNoneIdx = iIdx;
                    }

                }
                iIdx++;
            });

            var iRecentCount = nodes.length;
            var bBtnActive = iDisplayCount > 0;
            $('.xans-layout-productrecent .prev').unbind('click').click(function()
            {
                if (bBtnActive !== true) return;
                var iFirstNode = iDisplayNoneIdx - iDisplayCount;
                if (iFirstNode == 0 || iDisplayCount == iRecentCount) {
                    alert(__('최근 본 첫번째 상품입니다.'));
                    return;
                } else {
                    iDisplayNoneIdx--;
                    $(nodes[iDisplayNoneIdx]).hide();
                    $(nodes[iFirstNode - 1]).removeClass('displaynone');
                    $(nodes[iFirstNode - 1]).fadeIn('fast');

                }
            }).css(
            {
                cursor : 'pointer'
            });

            $('.xans-layout-productrecent .next').unbind('click').click(function()
            {
                if (bBtnActive !== true) return;
                if ( (iRecentCount ) == iDisplayNoneIdx || iDisplayCount == iRecentCount) {
                    alert(__('최근 본 마지막 상품입니다.'));
                } else {
                    $(nodes[iDisplayNoneIdx]).fadeIn('fast');
                    $(nodes[iDisplayNoneIdx]).removeClass('displaynone');
                    $(nodes[ (iDisplayNoneIdx - iDisplayCount)]).hide();
                    iDisplayNoneIdx++;
                }
            }).css(
            {
                cursor : 'pointer'
            });

        }

    }
};

/**
 * 비동기식 데이터 - 최근본상품 총 갯수
 */
CAPP_ASYNC_METHODS.aDatasetList.push('RecentTotalCount');
CAPP_ASYNC_METHODS.RecentTotalCount = {
    __iRecentCount: null,

    __$target: CAPP_ASYNC_METHODS.$xansMyshopMain.find('.xans_myshop_main_recent_cnt'),

    isUse: function()
    {
        if (this.__$target.length > 0) {
            return true;
        }

        return false;
    },

    restoreCache: function()
    {
        var sCookieName = 'recent_plist';
        if (EC_SDE_SHOP_NUM > 1) {
            sCookieName = 'recent_plist' + EC_SDE_SHOP_NUM;
        }
        var re = new RegExp('(?:^| |;)' + sCookieName + '=([^;]+)');
        var aCookieValue = document.cookie.match(re);
        if (aCookieValue) {
            this.__iRecentCount = decodeURI(aCookieValue[1]).split('|').length;
        } else {
            this.__iRecentCount = 0;
        }
    },

    execute: function()
    {
        this.__$target.html(this.__iRecentCount);
    },

    getData: function()
    {
        if (this.__iRecentCount === null) {
            // this.isUse값이 false라서 복구되지 않았는데 이 값이 필요한 경우 복구
            this.restoreCache();
        }

        return this.__iRecentCount;
    }
};
/**
 * 비동기식 데이터 - 주문정보
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Order');
CAPP_ASYNC_METHODS.Order = {
    __iOrderCount: null,
    __iOrderTotalPrice: null,
    __iGradeIncreaseValue: null,

    __$target: $('#xans_myshop_bankbook_order_count'),
    __$target2: $('#xans_myshop_bankbook_order_price'),
    __$target3: $('#xans_myshop_bankbook_grade_increase_value'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }

            if (this.__$target2.length > 0) {
                return true;
            }

            if (this.__$target3.length > 0) {
                return true;
            }
        }
        
        return false;        
    },

    restoreCache: function()
    {
        var sCookieName = 'order_' + EC_SDE_SHOP_NUM;
        var re = new RegExp('(?:^| |;)' + sCookieName + '=([^;]+)');
        var aCookieValue = document.cookie.match(re);
        if (aCookieValue) {
            var aData = jQuery.parseJSON(decodeURIComponent(aCookieValue[1]));
            this.__iOrderCount = aData.total_order_count;
            this.__iOrderTotalPrice = aData.total_order_price;
            this.__iGradeIncreaseValue = Number(aData.grade_increase_value);
            return true;
        }

        return false;
    },

    setData: function(aData)
    {
        this.__iOrderCount = aData['total_order_count'];
        this.__iOrderTotalPrice = aData['total_order_price'];
        this.__iGradeIncreaseValue = Number(aData['grade_increase_value']);
    },

    execute: function()
    {
        this.__$target.html(this.__iOrderCount);
        this.__$target2.html(this.__iOrderTotalPrice);
        this.__$target3.html(this.__iGradeIncreaseValue);
    },

    getData: function()
    {
        return {
            total_order_count: this.__iOrderCount,
            total_order_price: this.__iOrderTotalPrice,
            grade_increase_value: this.__iGradeIncreaseValue
        };
    }
};
/**
 * 비동기식 데이터 - Benefit
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Benefit');
CAPP_ASYNC_METHODS.Benefit = {
    __aBenefit: null,
    __$target: $('.xans-myshop-asyncbenefit'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }
        }

        return false;
    },

    setData: function(aData)
    {
        this.__aBenefit = aData;
    },

    execute: function()
    {
        var aFilter = ['group_image_tag', 'group_icon_tag', 'display_no_benefit', 'display_with_all', 'display_mobile_use_dc', 'display_mobile_use_mileage'];
        var __aData = this.__aBenefit;
        
        // 그룹이미지
        $('.myshop_benefit_group_image_tag').attr({alt: __aData['group_name'], src: __aData['group_image']});

        // 그룹아이콘
        $('.myshop_benefit_group_icon_tag').attr({alt: __aData['group_name'], src: __aData['group_icon']});

        if (__aData['display_no_benefit'] === true) {
            $('.myshop_benefit_display_no_benefit').removeClass('displaynone').show();
        }
        
        if (__aData['display_with_all'] === true) {
            $('.myshop_benefit_display_with_all').removeClass('displaynone').show();
        }
        
        if (__aData['display_mobile_use_dc'] === true) {
            $('.myshop_benefit_display_mobile_use_dc').removeClass('displaynone').show();
        } 
        
        if (__aData['display_mobile_use_mileage'] === true) {
            $('.myshop_benefit_display_mobile_use_mileage').removeClass('displaynone').show();
        }

        $.each(__aData, function(key, val) {
            if ($.inArray(key, aFilter) === -1) {
                $('.myshop_benefit_' + key).html(val);
            }
        });
    }    
};
/**
 * 비동기식 데이터 - 비동기장바구니 레이어
 */
CAPP_ASYNC_METHODS.aDatasetList.push('BasketLayer');
CAPP_ASYNC_METHODS.BasketLayer = {
    __sBasketLayerHtml: null,
    __$target: $('#ec_async_basket_layer_container'),

    isUse: function()
    {
        if (this.__$target.length > 0) {
            return true;
        }
        return false;
    },

    execute: function()
    {
        $.ajax({
            url: '/order/async_basket_layer.html?__popupPage=T',
            async: false,
            success: function(data) {
                var sBasketLayerHtml = data;
                var sBasketLayerStyle = '';
                var sBasketLayerBody = '';

                sBasketLayerHtml = sBasketLayerHtml.replace(/<script([\s\S]*?)<\/script>/gi,''); // 스크립트 제거
                sBasketLayerHtml = sBasketLayerHtml.replace(/<link([\s\S]*?)\/>/gi,''); // 옵티마이져 제거

                var regexStyle = /<style([\s\S]*?)<\/style>/; // Style 추출
                if (regexStyle.exec(sBasketLayerHtml) != null) sBasketLayerStyle = regexStyle.exec(sBasketLayerHtml)[0];

                var regexBody = /<body[\s\S]*?>([\s\S]*?)<\/body>/; // Body 추출
                if (regexBody.exec(sBasketLayerHtml) != null) sBasketLayerBody = regexBody.exec(sBasketLayerHtml)[1];

                CAPP_ASYNC_METHODS.BasketLayer.__sBasketLayerHtml = sBasketLayerStyle + sBasketLayerBody;
            }
        });
        this.__$target.html(this.__sBasketLayerHtml);
    }
};
/**
 * 비동기식 데이터 - Benefit
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Grade');
CAPP_ASYNC_METHODS.Grade = {
    __aGrade: null,
    __$target: $('#sGradeAutoDisplayArea'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }
        }

        return false;
    },

    setData: function(aData)
    {
        this.__aGrade = aData;
    },

    execute: function()
    {
        var __aData = this.__aGrade;
        var aFilter = ['bChangeMaxTypePrice', 'bChangeMaxTypePriceAndCount', 'bChangeMaxTypePriceOrCount', 'bChangeMaxTypeCount'];

        var aMaxDisplayJson = {
            "bChangeMaxTypePrice": [
                {"sId": "sChangeMaxTypePriceArea"}
            ],
            "bChangeMaxTypePriceAndCount": [
                {"sId": "sChangeMaxTypePriceAndCountArea"}
            ],
            "bChangeMaxTypePriceOrCount": [
                {"sId": "sChangeMaxTypePriceOrCountArea"}
            ],
            "bChangeMaxTypeCount": [
                {"sId": "sChangeMaxTypeCountArea"}
            ]
        };

        if ($('.sNextGroupIconArea').length > 0) {
            if (__aData['bDisplayNextGroupIcon'] === true) {
                $('.sNextGroupIconArea').removeClass('displaynone').show();
                $('.myshop_benefit_next_group_icon_tag').attr({alt: __aData['sNextGrade'], src: __aData['sNextGroupIcon']});
            } else {
                $('.sNextGroupIconArea').addClass('displaynone');
            }
        }

        var sIsAutoGradeDisplay = "F";
        $.each(__aData, function(key, val) {
            if ($.inArray(key, aFilter) === -1) {
                return true;
            }
            if (val === true) {
                if ($('#'+aMaxDisplayJson[key][0].sId).length > 0) {
                    $('#' + aMaxDisplayJson[key][0].sId).removeClass('displaynone').show();
                }
                sIsAutoGradeDisplay = "T";
            }
        });
        if (sIsAutoGradeDisplay == "T" && $('#sGradeAutoDisplayArea .sAutoGradeDisplay').length > 0) {
            $('#sGradeAutoDisplayArea .sAutoGradeDisplay').addClass('displaynone');
        }

        $.each(__aData, function(key, val) {
            if ($.inArray(key, aFilter) === -1) {
                if ($('.xans-member-var-' + key).length > 0) {
                    $('.xans-member-var-' + key).html(val);
                }
            }
        });
    }    
};
/**
 * 비동기식 데이터 - Benefit
 */
CAPP_ASYNC_METHODS.aDatasetList.push('AutomaticGradeShow');
CAPP_ASYNC_METHODS.AutomaticGradeShow = {
    __aGrade: null,
    __$target: $('#sAutomaticGradeShowArea'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }
        }
        return false;
    },

    setData: function(aData)
    {
        this.__aGrade = aData;
    },

    execute: function()
    {
        var __aData = this.__aGrade;

        /**
         * 아이콘 표기 제외
        if ($('.sNextGroupIconArea').length > 0) {
            if (__aData['bDisplayNextGroupIcon'] === true) {
                $('.sNextGroupIconArea').removeClass('displaynone').show();
                $('.myshop_benefit_next_group_icon_tag').attr({alt: __aData['sNextGrade'], src: __aData['sNextGroupIcon']});
            } else {
                $('.sNextGroupIconArea').addClass('displaynone');
            }
        }
         */

        var sIsAutoGradeDisplay = "F";
        $.each(__aData, function(key, val) {
            if (val === true) {
                sIsAutoGradeDisplay = "T";
                return false;
            }
        });
        if (sIsAutoGradeDisplay == "T" && $('#sAutomaticGradeShowArea .sAutoGradeDisplay').length > 0) {
            $('#sAutomaticGradeShowArea .sAutoGradeDisplay').addClass('displaynone');
        }

        $.each(__aData, function(key, val) {
            if ($('.xans-member-var-' + key).length > 0) {
                $('.xans-member-var-' + key).html(val);
            }
        });
    }    
};
/**
 * 비동기식 데이터 - 비동기장바구니 레이어
 */
CAPP_ASYNC_METHODS.aDatasetList.push('MobileMutiPopup');
CAPP_ASYNC_METHODS.MobileMutiPopup = {
    __$target: $('div[class^="ec-async-multi-popup-layer-container"]'),

    isUse: function()
    {
        if (this.__$target.length > 0) {
            return true;
        }
        return false;
    },

    execute: function()
    {
        for (var i=0; i < this.__$target.length ; i++) {
            $.ajax({
                url: '/exec/front/popup/AjaxMultiPopup?index='+i,
                data : EC_ASYNC_MULTI_POPUP_OPTION[i],
                dataType: "json",
                success : function (oResult) {
                    switch (oResult.code) {
                        case '0000' :
                            if (oResult.data.length < 1) {
                                break;
                            }
                            $('.ec-async-multi-popup-layer-container-' + oResult.data.html_index).html(oResult.data.html_text);
                            if (oResult.data.type == 'P') {
                                BANNER_POPUP_OPEN.setPopupSetting();
                                BANNER_POPUP_OPEN.setPopupWidth();
                                BANNER_POPUP_OPEN.setPopupClose();
                            } else {
                                /**
                                 * 이중 스크롤 방지 클래스 추가(비동기) 
                                 *
                                 */
                                $('body').addClass('eMobilePopup');
                                $('body').width('100%');

                                BANNER_POPUP_OPEN.setFullPopupSetting();
                                BANNER_POPUP_OPEN.setFullPopupClose();
                            }
                            break;
                        default :
                            break;
                    }
                },
                error : function () {
                }
            });
        }
    }
};
/**
 * 비동기식 데이터 - 좋아요 상품 갯수
 */
CAPP_ASYNC_METHODS.aDatasetList.push('MyLikeProductCount');
CAPP_ASYNC_METHODS.MyLikeProductCount = {
    __iMyLikeCount: null,

    __$target: $('#xans_myshop_like_prd_cnt'),

    isUse: function()
    {
        if (this.__$target.length > 0 && SHOP.getLanguage() === 'ko_KR') {
            return true;
        }

        return false;
    },

    setData: function(sData)
    {
        this.__iMyLikeCount = Number(sData);
    },

    execute: function()
    {
        if (SHOP.getLanguage() === 'ko_KR') {
            this.__$target.html(this.__iMyLikeCount + '개');
        }
    }
};
/**
 * 라이브 링콘 on/off이미지
 */
CAPP_ASYNC_METHODS.aDatasetList.push('Livelinkon');
CAPP_ASYNC_METHODS.Livelinkon = {
    __$target: $('#ec_livelinkon_campain_on'),
    __$target2: $('#ec_livelinkon_campain_off'),

    isUse: function()
    {
        if (this.__$target.length > 0 && this.__$target2.length > 0) {
            return true;
        }
        return false;
    },

    execute: function()
    {
        var sCampaignid = '';
        if (EC_ASYNC_LIVELINKON_ID != undefined) {
            sCampaignid = EC_ASYNC_LIVELINKON_ID
        }
        $.ajax({
            url: '/exec/front/Livelinkon/Campaignajax?campaign_id='+sCampaignid,
            async: false,
            success: function(data) {
                if (data == 'on') {
                    CAPP_ASYNC_METHODS.Livelinkon.__$target.removeClass('displaynone').show();
                    CAPP_ASYNC_METHODS.Livelinkon.__$target2.removeClass('displaynone').hide();
                } else if (data == 'off') {
                    CAPP_ASYNC_METHODS.Livelinkon.__$target.removeClass('displaynone').hide();
                    CAPP_ASYNC_METHODS.Livelinkon.__$target2.removeClass('displaynone').show();
                } else {
                    CAPP_ASYNC_METHODS.Livelinkon.__$target.removeClass('displaynone').hide();
                    CAPP_ASYNC_METHODS.Livelinkon.__$target2.removeClass('displaynone').hide();
                }
            }
        });
    }
};
/**
 * 비동기식 데이터 - 마이쇼핑 > 주문 카운트 (주문 건수 / CS건수 / 예전주문)
 */
CAPP_ASYNC_METHODS.aDatasetList.push('OrderHistoryCount');
CAPP_ASYNC_METHODS.OrderHistoryCount = {
    __sTotalOrder: null,
    __sTotalOrderCs: null,
    __sTotalOrderOld: null,

    __$target: $('#ec_myshop_total_orders'),
    __$target2: $('#ec_myshop_total_orders_cs'),
    __$target3: $('#ec_myshop_total_orders_old'),

    isUse: function()
    {
        if (CAPP_ASYNC_METHODS.IS_LOGIN === true) {
            if (this.__$target.length > 0) {
                return true;
            }

            if (this.__$target2.length > 0) {
                return true;
            }

            if (this.__$target3.length > 0) {
                return true;
            }
        }

        return false;
    },

    setData: function(aData)
    {
        this.__sTotalOrder = aData['total_orders'];
        this.__sTotalOrderCs = aData['total_orders_cs'];
        this.__sTotalOrderOld = aData['total_orders_old'];

    },

    execute: function()
    {
        this.__$target.html(this.__sTotalOrder);
        this.__$target2.html(this.__sTotalOrderCs);
        this.__$target3.html(this.__sTotalOrderOld);
    }
};
var PathRoleValidator = (function() {
    /**
     * Milage, Deposit 의 경우 처리되지 말아야할 페이지 확인
     * @returns {boolean}
     */
    function isInvalidPathRole()
    {
        // path role
        var sCurrentPathRole = null;

        // // euckr 환경에서 path role 획득
        if (SHOP.getProductVer() === 1) {
            // path 와 role 매핑
            var aPathRoleMap = {
                '/myshop/index.html': 'MYSHOP_MAIN',
                '/myshop/mileage/historyList.html': 'MYSHOP_MILEAGE_LIST',
                '/myshop/deposits/historyList.html': 'MYSHOP_DEPOSIT_LIST',
                '/order/orderform.html': 'ORDER_ORDERFORM'
            };

            // 페이지 경로로부터 path role 획득
            sCurrentPathRole = aPathRoleMap[document.location.pathname];

            // utf8 환경에서 path role 획득
        } else {
            // 현재 페이지 path role 획득
            sCurrentPathRole = $('meta[name="path_role"]').attr('content');
        }

        // 처리되면 안되는 경로
        var aInvalidPathRole = [
            'MYSHOP_MAIN',
            'MYSHOP_MILEAGE_LIST',
            'MYSHOP_DEPOSIT_LIST',
            'ORDER_ORDERFORM'
        ];

        return $.inArray(sCurrentPathRole, aInvalidPathRole) >= 0;
    }

    return {
        isInvalidPathRole: isInvalidPathRole
    };
})();
$(document).ready(function()
{
	CAPP_ASYNC_METHODS.init();
});
var EC_MANAGE_PRODUCT_RECENT = {
    getRecentImageUrl : function()
    {
        var sStorageKey = 'localRecentProduct' + EC_SDE_SHOP_NUM;

        if (typeof(sessionStorage[sStorageKey]) !== 'undefined') {
            var sRecentData = sessionStorage.getItem(sStorageKey);
            var oJsonData = JSON.parse(sRecentData);
            var sImageSrc = '';

            if (oJsonData[0] !== undefined) {
                sImageSrc = oJsonData[0].sImgSrc;
            }
            
            document.location.replace('recentproduct://setinfo?simg_src=' + sImageSrc);
        }
    }
};

/*
 * jQuery Nivo Slider v2.7.1
 * http://nivo.dev7studios.com
 *
 * Copyright 2011, Gilbert Pellegrom
 * Free to use and abuse under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * March 2010
 */

(function($) {

	var NivoSlider = function(element, options){
		//Defaults are below
		var settings = $.extend({}, $.fn.nivoSlider.defaults, options);

		//Useful variables. Play carefully.
		var vars = {
			currentSlide: 0,
			currentImage: '',
			totalSlides: 0,
			running: false,
			paused: false,
			stop: false
		};

		//Get this slider
		var slider = $(element);
		slider.data('nivo:vars', vars);
		slider.css('position','relative');
		slider.addClass('nivoSlider');

		//Find our slider children
		var kids = slider.children();
		kids.each(function() {
			var child = $(this);
			var link = '';
			if(!child.is('img')){
				if(child.is('a')){
					child.addClass('nivo-imageLink');
					link = child;
				}
				child = child.find('img:first');
			}
			//Get img width & height
			var childWidth = child.width();
			if(childWidth == 0) childWidth = child.attr('width');
			var childHeight = child.height();
			if(childHeight == 0) childHeight = child.attr('height');
			//Resize the slider
			if(childWidth > slider.width()){
				slider.width(childWidth);
			}
			if(childHeight > slider.height()){
				slider.height(childHeight);
			}
			if(link != ''){
				link.css('display','none');
			}
			child.css('display','none');
			vars.totalSlides++;
		});

		//If randomStart
		if(settings.randomStart){
			settings.startSlide = Math.floor(Math.random() * vars.totalSlides);
		}

		//Set startSlide
		if(settings.startSlide > 0){
			if(settings.startSlide >= vars.totalSlides) settings.startSlide = vars.totalSlides - 1;
			vars.currentSlide = settings.startSlide;
		}

		//Get initial image
		if($(kids[vars.currentSlide]).is('img')){
			vars.currentImage = $(kids[vars.currentSlide]);
		} else {
			vars.currentImage = $(kids[vars.currentSlide]).find('img:first');
		}

		//Show initial link
		if($(kids[vars.currentSlide]).is('a')){
			$(kids[vars.currentSlide]).css('display','block');
		}

		//Set first background
		slider.css('background','url("'+ vars.currentImage.attr('src') +'") no-repeat');

		//Create caption
		slider.append(
			$('<div class="nivo-caption"><p></p></div>').css({ display:'none', opacity:settings.captionOpacity })
		);

		// Cross browser default caption opacity
		$('.nivo-caption', slider).css('opacity', 0);

		// Process caption function
		var processCaption = function(settings){
			var nivoCaption = $('.nivo-caption', slider);
			if(vars.currentImage.attr('title') != '' && vars.currentImage.attr('title') != undefined){
				var title = vars.currentImage.attr('title');
				if(title.substr(0,1) == '#') title = $(title).html();

				if(nivoCaption.css('opacity') != 0){
					nivoCaption.find('p').stop().fadeTo(settings.animSpeed, 0, function(){
						$(this).html(title);
						$(this).stop().fadeTo(settings.animSpeed, 1);
					});
				} else {
					nivoCaption.find('p').html(title);
				}
				nivoCaption.stop().fadeTo(settings.animSpeed, settings.captionOpacity);
			} else {
				nivoCaption.stop().fadeTo(settings.animSpeed, 0);
			}
		}

		//Process initial  caption
		processCaption(settings);

		//In the words of Super Mario "let's a go!"
		var timer = 0;
		if(!settings.manualAdvance && kids.length >= 1){
			timer = setInterval(function(){ nivoRun(slider, kids, settings, false); }, settings.pauseTime);
		}

		//Add Direction nav
		if(settings.directionNav){
			slider.append('<div class="nivo-directionNav"><a class="nivo-prevNav">'+ settings.prevText +'</a><a class="nivo-nextNav">'+ settings.nextText +'</a></div>');

			//Hide Direction nav
			if(settings.directionNavHide){
				$('.nivo-directionNav', slider).hide();
				slider.hover(function(){
					$('.nivo-directionNav', slider).show();
				}, function(){
					$('.nivo-directionNav', slider).hide();
				});
			}

			$('a.nivo-prevNav', slider).live('click', function(){
				if(vars.running) return false;
				clearInterval(timer);
				timer = '';
				vars.currentSlide -= 2;
				nivoRun(slider, kids, settings, 'prev');
			});

			$('a.nivo-nextNav', slider).live('click', function(){
				if(vars.running) return false;
				clearInterval(timer);
				timer = '';
				nivoRun(slider, kids, settings, 'next');
			});
		}

		//Add Control nav
		if(settings.controlNav){
			var nivoControl = $('<div class="nivo-controlNav"></div>');
			slider.append(nivoControl);
			for(var i = 0; i < kids.length; i++){
				if(settings.controlNavThumbs){
					var child = kids.eq(i);
					if(!child.is('img')){
						child = child.find('img:first');
					}
					if (settings.controlNavThumbsFromRel) {
						nivoControl.append('<a class="nivo-control" rel="'+ i +'"><span><img src="'+ child.attr('rel') + '" alt="" /></span></a>');
					} else {
						nivoControl.append('<a class="nivo-control" rel="'+ i +'"><span><img src="'+ child.attr('src') +'" alt="" /></span></a>');
					}
				} else {
					nivoControl.append('<a class="nivo-control" rel="'+ i +'">'+ (i + 1) +'</a>');
				}

			}
			//Set initial active link
			$('.nivo-controlNav a:eq('+ vars.currentSlide +')', slider).addClass('active');

			$('.nivo-controlNav a', slider).live('click', function(){
				if(vars.running) return false;
				if($(this).hasClass('active')) return false;
				clearInterval(timer);
				timer = '';
				slider.css('background','url("'+ vars.currentImage.attr('src') +'") no-repeat');
				vars.currentSlide = $(this).attr('rel') - 1;
				nivoRun(slider, kids, settings, 'control');
			});
		}

		//Keyboard Navigation
		if(settings.keyboardNav){
			$(window).keypress(function(event){
				//Left
				if(event.keyCode == '37'){
					if(vars.running) return false;
					clearInterval(timer);
					timer = '';
					vars.currentSlide-=2;
					nivoRun(slider, kids, settings, 'prev');
				}
				//Right
				if(event.keyCode == '39'){
					if(vars.running) return false;
					clearInterval(timer);
					timer = '';
					nivoRun(slider, kids, settings, 'next');
				}
			});
		}

		//For pauseOnHover setting
		if(settings.pauseOnHover){
			slider.hover(function(){
				vars.paused = true;
				clearInterval(timer);
				timer = '';
			}, function(){
				vars.paused = false;
				//Restart the timer
				if(timer == '' && !settings.manualAdvance){
					timer = setInterval(function(){ nivoRun(slider, kids, settings, false); }, settings.pauseTime);
				}
			});
		}

		//Event when Animation finishes
		slider.bind('nivo:animFinished', function(){
			vars.running = false;
			//Hide child links
			$(kids).each(function(){
				if($(this).is('a')){
					$(this).css('display','none');
				}
			});
			//Show current link
			if($(kids[vars.currentSlide]).is('a')){
				$(kids[vars.currentSlide]).css('display','block');
			}
			//Restart the timer
			if(timer == '' && !vars.paused && !settings.manualAdvance){
				timer = setInterval(function(){ nivoRun(slider, kids, settings, false); }, settings.pauseTime);
			}
			//Trigger the afterChange callback
			settings.afterChange.call(this);
		});

		// Add slices for slice animations
		var createSlices = function(slider, settings, vars){
			for(var i = 0; i < settings.slices; i++){
				var sliceWidth = Math.round(slider.width()/settings.slices);
				if(i == settings.slices-1){
					slider.append(
						$('<div class="nivo-slice"></div>').css({
							left:(sliceWidth*i)+'px', width:(slider.width()-(sliceWidth*i))+'px',
							height:'0px',
							opacity:'0',
							background: 'url("'+ vars.currentImage.attr('src') +'") no-repeat -'+ ((sliceWidth + (i * sliceWidth)) - sliceWidth) +'px 0%'
						})
					);
				} else {
					slider.append(
						$('<div class="nivo-slice"></div>').css({
							left:(sliceWidth*i)+'px', width:sliceWidth+'px',
							height:'0px',
							opacity:'0',
							background: 'url("'+ vars.currentImage.attr('src') +'") no-repeat -'+ ((sliceWidth + (i * sliceWidth)) - sliceWidth) +'px 0%'
						})
					);
				}
			}
		}

		// Add boxes for box animations
		var createBoxes = function(slider, settings, vars){
                    var boxWidth = Math.round(slider.width()/settings.boxCols);
                    var boxHeight = Math.floor(slider.height()/settings.boxRows);
                    var mModulusHeight = slider.height() % settings.boxRows;
                    boxHeight = boxHeight + mModulusHeight;

                    for(var rows = 0; rows < settings.boxRows; rows++){
                        for(var cols = 0; cols < settings.boxCols; cols++){
                            if(cols == settings.boxCols-1){
                                slider.append(
                                    $('<div class="nivo-box"></div>').css({
                                        opacity:0,
                                        left:(boxWidth*cols)+'px',
                                        top:(boxHeight*rows)+'px',
                                        width:(slider.width()-(boxWidth*cols))+'px',
                                        height:boxHeight+'px',
                                        background: 'url("'+ vars.currentImage.attr('src') +'") no-repeat -'+ ((boxWidth + (cols * boxWidth)) - boxWidth) +'px -'+ ((boxHeight + (rows * boxHeight)) - boxHeight) +'px'
                                    })
                                );
                            } else {
                                slider.append(
                                    $('<div class="nivo-box"></div>').css({
                                        opacity:0,
                                        left:(boxWidth*cols)+'px',
                                        top:(boxHeight*rows)+'px',
                                        width:boxWidth+'px',
                                        height:boxHeight+'px',
                                        background: 'url("'+ vars.currentImage.attr('src') +'") no-repeat -'+ ((boxWidth + (cols * boxWidth)) - boxWidth) +'px -'+ ((boxHeight + (rows * boxHeight)) - boxHeight) +'px'
                                    })
                                );
                            }
                        }
                    }
		}

		// Private run method
		var nivoRun = function(slider, kids, settings, nudge){
			//Get our vars
			var vars = slider.data('nivo:vars');

			//Trigger the lastSlide callback
			if(vars && (vars.currentSlide == vars.totalSlides - 1)){
				settings.lastSlide.call(this);
			}

			// Stop
			if((!vars || vars.stop) && !nudge) return false;

			//Trigger the beforeChange callback
			settings.beforeChange.call(this);

			if(!nudge){
				slider.css('background', 'url("'+ vars.currentImage.attr('src') +'") no-repeat');
			} else {
				if(nudge == 'prev'){
					slider.css('background', 'url("'+ vars.currentImage.attr('src') +'") no-repeat');
				}
				if(nudge == 'next'){
					slider.css('background', 'url("'+ vars.currentImage.attr('src') +'") no-repeat');
				}
			}

			vars.currentSlide++;
			//Trigger the slideshowEnd callback
			if(vars.currentSlide == vars.totalSlides){
				vars.currentSlide = 0;
				settings.slideshowEnd.call(this);
			}
			if(vars.currentSlide < 0) vars.currentSlide = (vars.totalSlides - 1);
			//Set vars.currentImage
			if($(kids[vars.currentSlide]).is('img')){
				vars.currentImage = $(kids[vars.currentSlide]);
			} else {
				vars.currentImage = $(kids[vars.currentSlide]).find('img:first');
			}

			//Set active links
			if(settings.controlNav){
				$('.nivo-controlNav a', slider).removeClass('active');
				$('.nivo-controlNav a:eq('+ vars.currentSlide +')', slider).addClass('active');
			}

			//Process caption
			processCaption(settings);

			// Remove any slices from last transition
			$('.nivo-slice', slider).remove();

			// Remove any boxes from last transition
			$('.nivo-box', slider).remove();

			var currentEffect = settings.effect;
			//Generate random effect
			if(settings.effect == 'random'){
				var anims = new Array('sliceDownRight','sliceDownLeft','sliceUpRight','sliceUpLeft','sliceUpDown','sliceUpDownLeft','fold','fade',
					'boxRandom','boxRain','boxRainReverse','boxRainGrow','boxRainGrowReverse');
				currentEffect = anims[Math.floor(Math.random()*(anims.length + 1))];
				if(currentEffect == undefined) currentEffect = 'fade';
			}

			//Run random effect from specified set (eg: effect:'fold,fade')
			if(settings.effect.indexOf(',') != -1){
				var anims = settings.effect.split(',');
				currentEffect = anims[Math.floor(Math.random()*(anims.length))];
				if(currentEffect == undefined) currentEffect = 'fade';
			}

			//Custom transition as defined by "data-transition" attribute
			if(vars.currentImage.attr('data-transition')){
				currentEffect = vars.currentImage.attr('data-transition');
			}

			//when kids is 1, unset current background before change
			if (kids.length === 1 && $.inArray(currentEffect, ['fade', 'fold', 'slideInRight', 'sliceDown', 'sliceDownLeft', 'boxRandom','boxRain','boxRainReverse','boxRainGrow','boxRainGrowReverse', 'sliceDownRight']) !== -1) {
				if(!nudge){
					slider.css('background', 'none');
				} else {
					if(nudge == 'prev'){
						slider.css('background', 'none');
					}
					if(nudge == 'next'){
						slider.css('background', 'none');
					}
				}
			}

			//Run effects
			vars.running = true;
			if(currentEffect == 'sliceDown' || currentEffect == 'sliceDownRight' || currentEffect == 'sliceDownLeft'){
				createSlices(slider, settings, vars);
				var timeBuff = 0;
				var i = 0;
				var slices = $('.nivo-slice', slider);
				if(currentEffect == 'sliceDownLeft') slices = $('.nivo-slice', slider)._reverse();

				slices.each(function(){
					var slice = $(this);
					slice.css({ 'top': '0px' });
					if(i == settings.slices-1){
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed, '', function(){ slider.trigger('nivo:animFinished'); });
						}, (100 + timeBuff));
					} else {
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed);
						}, (100 + timeBuff));
					}
					timeBuff += 50;
					i++;
				});
			}
			else if(currentEffect == 'sliceUp' || currentEffect == 'sliceUpRight' || currentEffect == 'sliceUpLeft'){
				createSlices(slider, settings, vars);
				var timeBuff = 0;
				var i = 0;
				var slices = $('.nivo-slice', slider);
				if(currentEffect == 'sliceUpLeft') slices = $('.nivo-slice', slider)._reverse();

				slices.each(function(){
					var slice = $(this);
					slice.css({ 'bottom': '0px' });
					if(i == settings.slices-1){
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed, '', function(){ slider.trigger('nivo:animFinished'); });
						}, (100 + timeBuff));
					} else {
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed);
						}, (100 + timeBuff));
					}
					timeBuff += 50;
					i++;
				});
			}
			else if(currentEffect == 'sliceUpDown' || currentEffect == 'sliceUpDownRight' || currentEffect == 'sliceUpDownLeft'){
				createSlices(slider, settings, vars);
				var timeBuff = 0;
				var i = 0;
				var v = 0;
				var slices = $('.nivo-slice', slider);
				if(currentEffect == 'sliceUpDownLeft') slices = $('.nivo-slice', slider)._reverse();

				slices.each(function(){
					var slice = $(this);
					if(i == 0){
						slice.css('top','0px');
						i++;
					} else {
						slice.css('bottom','0px');
						i = 0;
					}

					if(v == settings.slices-1){
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed, '', function(){ slider.trigger('nivo:animFinished'); });
						}, (100 + timeBuff));
					} else {
						setTimeout(function(){
							slice.animate({ height:'100%', opacity:'1.0' }, settings.animSpeed);
						}, (100 + timeBuff));
					}
					timeBuff += 50;
					v++;
				});
			}
			else if(currentEffect == 'fold'){
				createSlices(slider, settings, vars);
				var timeBuff = 0;
				var i = 0;

				$('.nivo-slice', slider).each(function(){
					var slice = $(this);
					var origWidth = slice.width();
					slice.css({ top:'0px', height:'100%', width:'0px' });
					if(i == settings.slices-1){
						setTimeout(function(){
							slice.animate({ width:origWidth, opacity:'1.0' }, settings.animSpeed, '', function(){ slider.trigger('nivo:animFinished'); });
						}, (100 + timeBuff));
					} else {
						setTimeout(function(){
							slice.animate({ width:origWidth, opacity:'1.0' }, settings.animSpeed);
						}, (100 + timeBuff));
					}
					timeBuff += 50;
					i++;
				});
			}
			else if(currentEffect == 'fade'){
				createSlices(slider, settings, vars);

				var firstSlice = $('.nivo-slice:first', slider);
				firstSlice.css({
					'height': '100%',
					'width': slider.width() + 'px'
				});

				firstSlice.animate({ opacity:'1.0' }, (settings.animSpeed*2), '', function(){ slider.trigger('nivo:animFinished'); });
			}
			else if(currentEffect == 'slideInRight'){
				createSlices(slider, settings, vars);

				var firstSlice = $('.nivo-slice:first', slider);
				firstSlice.css({
					'height': '100%',
					'width': '0px',
					'opacity': '1'
				});

				firstSlice.animate({ width: slider.width() + 'px' }, (settings.animSpeed*2), '', function(){ slider.trigger('nivo:animFinished'); });
			}
			else if(currentEffect == 'slideInLeft'){
				createSlices(slider, settings, vars);

				var firstSlice = $('.nivo-slice:first', slider);
				firstSlice.css({
					'height': '100%',
					'width': '0px',
					'opacity': '1',
					'left': '',
					'right': '0px'
				});

				firstSlice.animate({ width: slider.width() + 'px' }, (settings.animSpeed*2), '', function(){
					// Reset positioning
					firstSlice.css({
						'left': '0px',
						'right': ''
					});
					slider.trigger('nivo:animFinished');
				});
			}
			else if(currentEffect == 'boxRandom'){
				createBoxes(slider, settings, vars);

				var totalBoxes = settings.boxCols * settings.boxRows;
				var i = 0;
				var timeBuff = 0;

				var boxes = shuffle($('.nivo-box', slider));
				boxes.each(function(){
					var box = $(this);
					if(i == totalBoxes-1){
						setTimeout(function(){
							box.animate({ opacity:'1' }, settings.animSpeed, '', function(){ slider.trigger('nivo:animFinished'); });
						}, (100 + timeBuff));
					} else {
						setTimeout(function(){
							box.animate({ opacity:'1' }, settings.animSpeed);
						}, (100 + timeBuff));
					}
					timeBuff += 20;
					i++;
				});
			}
			else if(currentEffect == 'boxRain' || currentEffect == 'boxRainReverse' || currentEffect == 'boxRainGrow' || currentEffect == 'boxRainGrowReverse'){
				createBoxes(slider, settings, vars);

				var totalBoxes = settings.boxCols * settings.boxRows;
				var i = 0;
				var timeBuff = 0;

				// Split boxes into 2D array
				var rowIndex = 0;
				var colIndex = 0;
				var box2Darr = new Array();
				box2Darr[rowIndex] = new Array();
				var boxes = $('.nivo-box', slider);
				if(currentEffect == 'boxRainReverse' || currentEffect == 'boxRainGrowReverse'){
					boxes = $('.nivo-box', slider)._reverse();
				}
				boxes.each(function(){
					box2Darr[rowIndex][colIndex] = $(this);
					colIndex++;
					if(colIndex == settings.boxCols){
						rowIndex++;
						colIndex = 0;
						box2Darr[rowIndex] = new Array();
					}
				});

				// Run animation
				for(var cols = 0; cols < (settings.boxCols * 2); cols++){
					var prevCol = cols;
					for(var rows = 0; rows < settings.boxRows; rows++){
						if(prevCol >= 0 && prevCol < settings.boxCols){
							/* Due to some weird JS bug with loop vars 
							 being used in setTimeout, this is wrapped
							 with an anonymous function call */
							(function(row, col, time, i, totalBoxes) {
								var box = $(box2Darr[row][col]);
								var w = box.width();
								var h = box.height();
								if(currentEffect == 'boxRainGrow' || currentEffect == 'boxRainGrowReverse'){
									box.width(0).height(0);
								}
								if(i == totalBoxes-1){
									setTimeout(function(){
										box.animate({ opacity:'1', width:w, height:h }, settings.animSpeed/1.3, '', function(){ slider.trigger('nivo:animFinished'); });
									}, (100 + time));
								} else {
									setTimeout(function(){
										box.animate({ opacity:'1', width:w, height:h }, settings.animSpeed/1.3);
									}, (100 + time));
								}
							})(rows, prevCol, timeBuff, i, totalBoxes);
							i++;
						}
						prevCol--;
					}
					timeBuff += 100;
				}
			}
		}

		// Shuffle an array
		var shuffle = function(arr){
			for(var j, x, i = arr.length; i; j = parseInt(Math.random() * i), x = arr[--i], arr[i] = arr[j], arr[j] = x);
			return arr;
		}

		// For debugging
		var trace = function(msg){
			if (this.console && typeof console.log != "undefined")
				console.log(msg);
		}

		// Start / Stop
		this.stop = function(){
			if(!$(element).data('nivo:vars').stop){
				$(element).data('nivo:vars').stop = true;
				trace('Stop Slider');
			}
		}

		this.start = function(){
			if($(element).data('nivo:vars').stop){
				$(element).data('nivo:vars').stop = false;
				trace('Start Slider');
			}
		}

		//Trigger the afterLoad callback
		settings.afterLoad.call(this);

		return this;
	};

	$.fn.nivoSlider = function(options) {

		return this.each(function(key, value){
			var element = $(this);
			// Return early if this element already has a plugin instance
			if (element.data('nivoslider')) return element.data('nivoslider');
			// Pass options to plugin constructor
			var nivoslider = new NivoSlider(this, options);
			// Store plugin object in this element's data
			element.data('nivoslider', nivoslider);
		});

	};

	//Default settings
	$.fn.nivoSlider.defaults = {
		effect: 'random',
		slices: 15,
		boxCols: 8,
		boxRows: 4,
		animSpeed: 500,
		pauseTime: 3000,
		startSlide: 0,
		directionNav: true,
		directionNavHide: true,
		controlNav: true,
		controlNavThumbs: false,
		controlNavThumbsFromRel: false,
		controlNavThumbsSearch: '.jpg',
		controlNavThumbsReplace: '_thumb.jpg',
		keyboardNav: true,
		pauseOnHover: true,
		manualAdvance: false,
		captionOpacity: 0.8,
		prevText: 'Prev',
		nextText: 'Next',
		randomStart: false,
		beforeChange: function(){},
		afterChange: function(){},
		slideshowEnd: function(){},
		lastSlide: function(){},
		afterLoad: function(){}
	};

	$.fn._reverse = [].reverse;

})(jQuery);
$(document).ready(function(){
    $(".nivohref").bind("click", function(e){
        //e.preventDefault();

        //화면 이미지를  클릭 했을시 연산 부분 
        var $aTag = $(this),
            iSeq = $aTag.attr("rel"),
            sHref = $aTag.attr("href"),
            sTarget = $aTag.attr('target'),
            sendArgs = {};

        if ( sHref ) {
            sendArgs['seq'] = iSeq;
            sendArgs['sequence'] = $aTag.index();
            sendArgs['slideSeq'] = $aTag.parents(".nivoSlider").eq(0).attr("rel");
            $.ajax({
                type: "POST",
                url: "/cstore-api/photoslide2/Clickcount",
                async: false,
                data: sendArgs
            });
            if ( sTarget == "_parent") {
                parent.location.href = sHref;

                return false;
            } else if ( sTarget == "_blank" ){

                return true;
            } else {
                location.href = sHref;

                return false;
            }
        }
    });
});

$(document).ready(function(){
    var prevClick = -1;
    var popupWin;

    /**
     * opens poup window
     * @param {String} url
     * @param {Integer} iWidth
     * @param {Integer} iHeight
     * @return {void}
     */
    function open_popup(url, iWidth, iHeight)
    {
        var sPopupName = 'PopupName';
        var sPopipOption = "scrollbars=1, resizable=1, width="+iWidth+" height="+iHeight;
        window.open(url, sPopupName, sPopipOption).focus();
    }

    $(".xans-bannermanage2 a").bind("click", function(e){
        e.preventDefault();
        history.pushState("prev_page", "Previous Page", location.href);
            var mode = $(this).parents('.xans-bannermanage2').attr('id');
            var $a = $(this),
                sHref = $a.attr('href'),
                sRel = $a.find('.banner_image').attr("rel"),
                imgSeq = sRel.split("-"),
                target = $a.attr("target"),
                sendArgs = {},
                aaa = null,
                openWindow = [];

            if ( sHref ) {
                sendArgs['seq'] =  imgSeq[0];
                sendArgs['dataSeq'] = imgSeq[1];

                if (target === "_blank") {
                    var iWidth = $a.find(".popup_size_width").val();
                    var iHeight = $a.find(".popup_size_height").val();
                    open_popup(sHref, iWidth, iHeight);
                }

                $.post( "/cstore-api/bannermanage2/Clickcount?mode=" +mode, sendArgs, function(req) {
                    if ( target === "_parent" ) {
                        parent.location.href = sHref;
                    } else if (target !== '_parent' && target !== '_blank') {
                        location.href = sHref;
                    }
                    return;
                });
            }

        return false;
    });
});

/**
 * 카테고리 마우스 오버 이미지
 * 카테고리 서브 메뉴 출력
 */

$(document).ready(function(){

    var methods = {
        aCategory    : [],
        aSubCategory : {},

        get: function()
        {
             $.ajax({
                url : '/exec/front/Product/SubCategory',
                dataType: 'json',
                success: function(aData) {

                    if (aData == null || aData == 'undefined') return;
                    for (var i=0; i<aData.length; i++)
                    {
                        var sParentCateNo = aData[i].parent_cate_no;

                        if (!methods.aSubCategory[sParentCateNo]) {
                            methods.aSubCategory[sParentCateNo] = [];
                        }

                        methods.aSubCategory[sParentCateNo].push( aData[i] );
                    }
                }
            });
        },

        getParam: function(sUrl, sKey) {

            var aUrl         = sUrl.split('?');
            var sQueryString = aUrl[1];
            var aParam       = {};

            if (sQueryString) {
                var aFields = sQueryString.split("&");
                var aField  = [];
                for (var i=0; i<aFields.length; i++) {
                    aField = aFields[i].split('=');
                    aParam[aField[0]] = aField[1];
                }
            }
            return sKey ? aParam[sKey] : aParam;
        },

        getParamSeo: function(sUrl) {
            var aUrl         = sUrl.split('/');
            return aUrl[3] ? aUrl[3] : null;
        },

        show: function(overNode, iCateNo) {

            if (methods.aSubCategory[iCateNo].length == 0) {
                return;
            }

            var aHtml = [];
            aHtml.push('<ul>');
            $(methods.aSubCategory[iCateNo]).each(function() {
                aHtml.push('<li><a href="'+this.link_product_list+'">'+this.name+'</a></li>');
            });
            aHtml.push('</ul>');


            var offset = $(overNode).offset();
            $('<div class="sub-category"></div>')
                .appendTo(overNode)
                .html(aHtml.join(''))
                .find('li').mouseover(function(e) {
                    $(this).addClass('over');
                }).mouseout(function(e) {
                    $(this).removeClass('over');
                });
        },

        close: function() {
            $('.sub-category').remove();
        }
    };

    methods.get();


    $('.xans-layout-category li').mouseenter(function(e) {
        var $this = $(this).addClass('on'),
        iCateNo = Number(methods.getParam($this.find('a').attr('href'), 'cate_no'));

        if (!iCateNo) {
            iCateNo = Number(methods.getParamSeo($this.find('a').attr('href')));
        }

        if (!iCateNo) {
           return;
        }

        methods.show($this, iCateNo);
     }).mouseleave(function(e) {
        $(this).removeClass('on');

          methods.close();
     });
});
function pfade2(target, option) {
	this.obj = $(target);
	this.timeout = null;
	this.overFlag = false;

	this.type = option.type ? option.type : 'basic';
	this.intval = option.time ? Number(option.time) : 5100;
	this.delay = option.delay ? Number(option.delay) : 0;
	this.btn = option.btn ? option.btn : null;
	this.debug = option.debug ? option.debug : null;

	this.init = function() {
		$(this.obj).removeClass('highlight');
		$(this.obj).first().addClass('highlight');

		$(this.btn).removeClass('highlight');
		$(this.btn).first().addClass('highlight');

		$(this.btn).bind('click', {obj:this}, function(e) {
			var _this = this;
			var pos = 0;
			$(e.data.obj.btn).each(function(i) {
				if(this == _this) {
					pos = i;
				}
			});

			if(e.data.obj.timeout) clearTimeout(e.data.obj.timeout);
			e.data.obj.chg(pos);

			return false;
		});


		$(this.obj).bind('mouseenter', {obj:this}, function(e) {
			e.data.obj.overFlag = true;
			if(e.data.obj.timeout) clearTimeout(e.data.obj.timeout);
		});
		$(this.btn).bind('mouseenter', {obj:this}, function(e) {
			e.data.obj.overFlag = true;
			if(e.data.obj.timeout) clearTimeout(e.data.obj.timeout);

			$(this).click();
		});

		$(this.obj).bind('mouseleave', {obj:this}, function(e) {
			e.data.obj.overFlag = false;
			e.data.obj.initTime();
		});
		$(this.btn).bind('mouseleave', {obj:this}, function(e) {
			e.data.obj.overFlag = false;
			e.data.obj.initTime();

			
		});

		var intval = this.intval + this.delay;
		this.initTime(intval);
	};

	this.initTime = function(intval) {
		if(this.overFlag) {
			return false;
		}

		var _this = this;
		var intval = intval ? intval : _this.intval;

		if(_this.timeout) clearTimeout(_this.timeout);

		$(document).ready(function() {
			_this.timeout = setTimeout(function() { _this.next(_this); }, intval);
		});
	};

	this.next = function() {
		var c = this.getCurrent();
		var n = this.getNext();

		this.fade(c, n);
	};

	this.chg = function(pos) {
		var c = this.getCurrent();
		var p = $(this.obj).eq(pos);

		if(c[0] == p[0]) {
			return false;
		}

		this.fade(c, p);
	};

	this.fade = function(before, after) {
		$(before).css('z-index', 1).removeClass('highlight').fadeOut();
		$(after).css('z-index', 2).addClass('highlight').fadeIn('fast'); //slow

		this.sync(after[0]);
		this.initTime();
	};

	this.sync = function(after) {
		if($(this.btn).length > 0) {
			for(var i=0; i<$(this.obj).length; i++) {
				if($(this.obj)[i] == after) {
					break;
				}
			}

			$(this.btn).removeClass('highlight');
			$(this.btn).eq(i).addClass('highlight');

			if(this.type == 'tab') {
				$('div[class^=tab_screen]', this.btn).show();
				$('div[class^=tab_screen]', $(this.btn).eq(i)).hide();
			} 
		}
	};

	this.getCurrent = function() {
		for(var i=0; i<$(this.obj).length; i++) {
			if($(this.obj).eq(i).hasClass('highlight')) {
				return $(this.obj).eq(i);
			}
		}

		return false;
	};

	this.getNext = function() {
		var next = null;
		for(var i=0; i<$(this.obj).length; i++) {
			if($(this.obj).eq(i).hasClass('highlight')) {
				next = $(this.obj).eq(i+1);
				break;
			}
		}

		if(next.length < 1) {
			next = $(this.obj).first();
		}

		return next;
	};

	this.init();
}


/** 베스트상품 롤링 실행 */ 
new pfade2($('.best_main > div.best_list'), {
	'btn':$('.best_main > ul.tab_cate > li[class^=tab_sbu]')
});
/**
 * 움직이는 배너 Jquery Plug-in
 * @author  cafe24
 */

(function($){

    $.fn.floatBanner = function(options) {
        options = $.extend({}, $.fn.floatBanner.defaults , options);

        return this.each(function() {
            var aPosition = $(this).position();
            var jbOffset = $(this).offset();
            var node = this;

            $(window).scroll(function() {
                var _top = $(document).scrollTop();
                _top = (aPosition.top < _top) ? _top : aPosition.top;

                setTimeout(function () {
                    var newinit = $(document).scrollTop();

                    if ( newinit > jbOffset.top ) {
                        _top -= jbOffset.top;
                        var container_height = $("#wrap").height();
                        var quick_height = $(node).height();
                        var cul = container_height - quick_height;
                        if(_top > cul){
                            _top = cul;
                        }
                    }else {
                        _top = 0;
                    }

                    $(node).stop().animate({top: _top}, options.animate);
                }, options.delay);
            });
        });
    };

    $.fn.floatBanner.defaults = {
        'animate'  : 500,
        'delay'    : 500
    };

})(jQuery);

/**
 * 문서 구동후 시작
 */
$(document).ready(function(){
    $('#banner:visible, #quick:visible').floatBanner();

    //placeholder
    $(".ePlaceholder input, .ePlaceholder textarea").each(function(i){
        var placeholderName = $(this).parents().attr('title');
        $(this).attr("placeholder", placeholderName);
    });
    /* placeholder ie8, ie9 */
    $.fn.extend({
        placeholder : function() {
            //IE 8 버전에는 hasPlaceholderSupport() 값이 false를 리턴
           if (hasPlaceholderSupport() === true) {
                return this;
            }
            //hasPlaceholderSupport() 값이 false 일 경우 아래 코드를 실행
            return this.each(function(){
                var findThis = $(this);
                var sPlaceholder = findThis.attr('placeholder');
                if ( ! sPlaceholder) {
                   return;
                }
                findThis.wrap('<label class="ePlaceholder" />');
                var sDisplayPlaceHolder = $(this).val() ? ' style="display:none;"' : '';
                findThis.before('<span' + sDisplayPlaceHolder + '>' + sPlaceholder + '</span>');
                this.onpropertychange = function(e){
                    e = event || e;
                    if (e.propertyName == 'value') {
                        $(this).trigger('focusout');
                    }
                };
                //공통 class
                var agent = navigator.userAgent.toLowerCase();
                if (agent.indexOf("msie") != -1) {
                    $(".ePlaceholder").css({"position":"relative"});
                    $(".ePlaceholder span").css({"position":"absolute", "padding":"0 4px", "color":"#878787"});
                    $(".ePlaceholder label").css({"padding":"0"});
                }
            });
        }
    });

    $(':input[placeholder]').placeholder(); //placeholder() 함수를 호출

    //클릭하면 placeholder 숨김
    $('body').delegate('.ePlaceholder span', 'click', function(){
        $(this).hide();
    });

    //input창 포커스 인 일때 placeholder 숨김
    $('body').delegate('.ePlaceholder :input', 'focusin', function(){
        $(this).prev('span').hide();
    });

    //input창 포커스 아웃 일때 value 가 true 이면 숨김, false 이면 보여짐
    $('body').delegate('.ePlaceholder :input', 'focusout', function(){
        if (this.value) {
            $(this).prev('span').hide();
        } else {
            $(this).prev('span').show();
        }
    });

    //input에 placeholder가 지원이 되면 true를 안되면 false를 리턴값으로 던져줌
    function hasPlaceholderSupport() {
        if ('placeholder' in document.createElement('input')) {
            return true;
        } else {
            return false;
        }
    }
});

/**
 *  썸네일 이미지 엑박일경우 기본값 설정
 */
$(window).load(function() {
    $("img.thumb,img.ThumbImage,img.BigImage").each(function($i,$item){
        var $img = new Image();
        $img.onerror = function () {
                $item.src="//img.echosting.cafe24.com/thumb/img_product_big.gif";
        }
        $img.src = this.src;
    });
});

/**
 *  tooltip
 */
$('.eTooltip').each(function(i){
    $(this).find('.btnClose').attr('tabIndex','-1');
});
//tooltip input focus
$('.eTooltip').find('input').focus(function() {
    var targetName = returnTagetName(this);
    targetName.siblings('.ec-base-tooltip').show();
});
$('.eTooltip').find('input').focusout(function() {
    var targetName = returnTagetName(this);
    targetName.siblings('.ec-base-tooltip').hide();
});
function returnTagetName(_this){
    var ePlacename = $(_this).parent().attr("class");
    var targetName;
    if(ePlacename == "ePlaceholder"){ //ePlaceholder 대응
        targetName = $(_this).parents();
    }else{
        targetName = $(_this);
    }
    return targetName;
}

/**
 *  eTab
 */
 $("body").delegate(".eTab a", "click", function(e){
    // 클릭한 li 에 selected 클래스 추가, 기존 li에 있는 selected 클래스는 삭제.
    var _li = $(this).parent("li").addClass("selected").siblings().removeClass("selected"),
    _target = $(this).attr("href"),
    _siblings = $(_target).attr("class"),
    _arr = _siblings.split(" "),
    _classSiblings = "."+_arr[0];

    //클릭한 탭에 해당하는 요소는 활성화, 기존 요소는 비활성화 함.
    $(_target).show().siblings(_classSiblings).hide();


    //preventDefault 는 a 태그 처럼 클릭 이벤트 외에 별도의 브라우저 행동을 막기 위해 사용됨.
    e.preventDefault();
});


$(".banner_image").hover(function(){
    var title = $(this).attr("title");
    $(this).attr("title");
    $(this).attr("title","");
});

$(document).ready(function() {
    //커뮤니티
    $("#snbBoard").hover(function(){
        $(this).find('.snbBbox').show();
    },function(){
        $(this).find('.snbBbox').hide();
    });   
    
    // boxhover
    $(".ec-base-product ul.boxhover > li").hover(function(){
        $(this).find('.description').fadeIn(100);
    },function(){
        $(this).find('.description').fadeOut(100);
    }); 
});


(function($) {
    $(function(){
        $(window).scroll(function(){
            var fixmenu = $(window).scrollTop();
            var fixsnb = 250;
            var fixup = 250;
            
            if(fixmenu >= fixsnb){
                $("#sidebar").addClass("effect")
            }else{
                $("#sidebar").removeClass("effect")
            }

            if(fixmenu >= fixup){
                $("#gotop").fadeIn();
            }else{
                $("#gotop").fadeOut();
            }
        });

        $("#gotop .top").click(function(){
            $('html,body').animate({scrollTop:$("body").offset().top}, 350); return false;
        });
        $("#gotop .bottom").click(function(){
            $('html,body').animate({scrollTop:$("#footer .inner").offset().top }, 350); return false;
        });
    });
})(jQuery);

//window popup script
function winPop(url) {
    window.open(url, "popup", "width=300,height=300,left=10,top=10,resizable=no,scrollbars=no");
}
/**
 * document.location.href split
 * return array Param
 */
function getQueryString(sKey)
{
    var sQueryString = document.location.search.substring(1);
    var aParam       = {};

    if (sQueryString) {
        var aFields = sQueryString.split("&");
        var aField  = [];
        for (var i=0; i<aFields.length; i++) {
            aField = aFields[i].split('=');
            aParam[aField[0]] = aField[1];
        }
    }

    aParam.page = aParam.page ? aParam.page : 1;
    return sKey ? aParam[sKey] : aParam;
};

$(document).ready(function(){
    // tab
    $.eTab = function(ul){
        $(ul).find('a').click(function(){
            var _li = $(this).parent('li').addClass('selected').siblings().removeClass('selected'),
                _target = $(this).attr('href'),
                _siblings = '.' + $(_target).attr('class');
            $(_target).show().siblings(_siblings).hide();
            return false
        });
    }
    if ( window.call_eTab ) {
        call_eTab();
    };
});
(function($){
$.fn.extend({
    center: function() {
        this.each(function() {
            var
                $this = $(this),
                $w = $(window);
            $this.css({
                position: "absolute",
                top: ~~(($w.height() - $this.outerHeight()) / 2) + $w.scrollTop() + "px",
                left: ~~(($w.width() - $this.outerWidth()) / 2) + $w.scrollLeft() + "px"
            });
        });
        return this;
    }
});
$(function() {
    var $container = function(){/*
<div id="modalContainer">
    <iframe id="modalContent" scroll="0" scrolling="no" frameBorder="0"></iframe>
</div>');
*/}.toString().slice(14,-3);
    $('body')
    .append($('<div id="modalBackpanel"></div>'))
    .append($($container));
    function closeModal () {
        $('#modalContainer').hide();
        $('#modalBackpanel').hide();
    }
    $('#modalBackpanel').click(closeModal);
    zoom = function ($piProductNo, $piCategoryNo, $piDisplayGroup) {
        var $url = '/product/image_zoom.html?product_no=' + $piProductNo + '&cate_no=' + $piCategoryNo + '&display_group=' + $piDisplayGroup;
        $('#modalContent').attr('src', $url);
        $('#modalContent').bind("load",function(){
            $(".header .close",this.contentWindow.document.body).bind("click", closeModal);
        });
        $('#modalBackpanel').css({width:$("body").width(),height:$("body").height(),opacity:.4}).show();
        $('#modalContainer').center().show();
    }
});
})(jQuery);
