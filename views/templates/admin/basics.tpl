{*
 * Google Merchant Feed - General Settings Form
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

<script type="text/javascript">
    {literal}
    var oBasicCallBack = [
        {
            'name': 'displayFeedListData',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=data',
            'toShow': 'bt_feed-list-settings-data',
            'toHide': 'bt_feed-list-settings-data',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedListPromo',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=promo',
            'toShow': 'bt_feed-list-settings-promo',
            'toHide': 'bt_feed-list-settings-promo',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedListStock',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=stock',
            'toShow': 'bt_feed-list-settings-stock',
            'toHide': 'bt_feed-list-settings-stock',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedExport',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedDisplay.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedDisplay.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=export',
            'toShow': 'bt_feed-settings-export',
            'toHide': 'bt_feed-settings-export',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedExclusion',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedDisplay.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedDisplay.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=exclusion',
            'toShow': 'bt_feed-settings-exclusion',
            'toHide': 'bt_feed-settings-exclusion',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedData',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedDisplay.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedDisplay.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=data',
            'toShow': 'bt_feed-settings-data',
            'toHide': 'bt_feed-settings-data',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedApparel',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedDisplay.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedDisplay.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=apparel',
            'toShow': 'bt_feed-settings-apparel',
            'toHide': 'bt_feed-settings-apparel',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        },
        {
            'name': 'displayFeedTax',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedDisplay.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedDisplay.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=tax',
            'toShow': 'bt_feed-settings-tax',
            'toHide': 'bt_feed-settings-tax',
            'bFancybox': false,
            'bFancyboxActivity': false,
            'sLoadbar': null,
            'sScrollTo': null,
            'oCallBack': {}
        }
    ];
    {/literal}
</script>

<div class="bootstrap">
    <form class="form-horizontal" action="{$sURI|escape:'htmlall':'UTF-8'}" method="post" id="bt_basics-form" name="bt_basics-form" {if $useJs}onsubmit="javascript: oGmcPro.form('bt_basics-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_basics-settings', 'bt_basics-settings', false, false, oBasicCallBack, 'Basics', 'loadingBasicsDiv'); return false;"{/if}>
        <input type="hidden" name="sAction" value="{$aQueryParams.basic.action|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sType" value="{$aQueryParams.basic.type|escape:'htmlall':'UTF-8'}" />

        <div class="card mb-3">
            <div class="card-header">
                <i class="material-icons">settings</i> {l s='General Settings' mod='googlemerchantfeed'}
            </div>
            <div class="card-body">
                {if !empty($bUpdate)}
                    {include file="`$sConfirmInclude`"}
                {elseif !empty($aErrors)}
                    {include file="`$sErrorInclude`"}
                {/if}

                {* Store URL *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Example: http://www.myshop.com - Even if your shop is located in a sub-directory, you should still only enter the fully qualified domain name. DO NOT include a trailing slash (/) at the end.' mod='googlemerchantfeed'}">
                            {l s='PrestaShop Store URL' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <input type="url" name="bt_link" class="form-control" value="{$sLink|escape:'htmlall':'UTF-8'}" required />
                    </div>
                </div>

                {* Product ID Format *}
                <div class="form-group row {if !empty($isGremarketing)}d-none{/if}" id="id_tag_product">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Choose how you want the product IDs to be built in the feed' mod='googlemerchantfeed'}">
                            {l s='Product ID Format in Feed' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_feed-tag-id" id="bt_feed-tag-id" class="form-control" onchange="toggleProductIdWarning();">
                            <option value="tag-id-basic" {if $feedTagId == 'tag-id-basic' || !empty($isGremarketing)}selected{/if}>
                                {l s='Use the IDs of the products in the back-office' mod='googlemerchantfeed'}
                            </option>
                            <option value="tag-id-product-ref" {if $feedTagId == 'tag-id-product-ref' && empty($isGremarketing)}selected{/if}>
                                {l s='Use the product references' mod='googlemerchantfeed'}
                            </option>
                            <option value="tag-id-ean" {if $feedTagId == 'tag-id-ean' && empty($isGremarketing)}selected{/if}>
                                {l s='Use the EAN codes' mod='googlemerchantfeed'}
                            </option>
                        </select>
                    </div>
                </div>

                <div id="tag_id_warning_not_basic" class="{if $feedTagId == 'tag-id-basic'}d-none{/if}">
                    <div class="form-group row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="alert alert-warning">
                                <i class="material-icons">warning</i>
                                {l s='Be careful: if you want to use product references or EAN codes, make sure that this information is filled in for all products (or product combinations) to be exported, and is unique for each of them. If the information is missing, the module will use the ID of the product in the back-office.' mod='googlemerchantfeed'}
                            </div>
                        </div>
                    </div>
                </div>

                {* Simple Product IDs *}
                <div id="tag_id_lang_basic" class="{if $feedTagId != 'tag-id-basic'}d-none{/if}">
                    <div class="form-group row">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "YES" to assign simple IDs (1, 2, 3, ...) to your products and "NO" if you want to add a customized prefix and the country code.' mod='googlemerchantfeed'}">
                                {l s='Use Simple Product IDs?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_simple_id" id="bt_simple_id_on" value="1" {if !empty($bSimpleId)}checked{/if} onclick="togglePrefixField(true);" />
                                <label for="bt_simple_id_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_simple_id" id="bt_simple_id_off" value="0" {if empty($bSimpleId)}checked{/if} onclick="togglePrefixField(false);" />
                                <label for="bt_simple_id_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row {if !empty($bSimpleId)}d-none{/if}" id="bt_prefix_string">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Enter a short prefix that represents your shop. This prefix is mandatory and must be unique for each of your shops.' mod='googlemerchantfeed'}">
                                {l s='Product ID prefix for your shop' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <input type="text" id="prefix-id" name="bt_prefix-id" class="form-control" value="{$sPrefixId|escape:'htmlall':'UTF-8'}" />
                        </div>
                    </div>
                </div>

                {* Number of products per cycle *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='This determines how many products are processed per AJAX / CRON cycle. Default is 200. It should not be higher than 1000 in any case.' mod='googlemerchantfeed'}">
                            {l s='Number of products per cycle' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <input type="number" name="bt_ajax-cycle" class="form-control" value="{$iProductPerCycle|escape:'htmlall':'UTF-8'}" min="50" max="1000" />
                    </div>
                </div>

                {* Product Photo Dimensions *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Choose the largest image size available. Google requires at least 250x250 and recommends at least 400x400 pixels.' mod='googlemerchantfeed'}">
                            {l s='Product Photo Dimensions' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_image-size" class="form-control">
                            {foreach from=$aImageTypes item=aImgType}
                                <option value="{$aImgType.name|escape:'htmlall':'UTF-8'}" {if $aImgType.name == $sImgSize}selected{/if}>
                                    {$aImgType.name|escape:'htmlall':'UTF-8'}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                {* Cover Image Position *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Indicate the position of the image you want to use as the cover image. Example: enter 2 if you want the 2nd image associated with the product to be used as the main image.' mod='googlemerchantfeed'}">
                            {l s='Cover Image Position' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <input type="number" name="bt_image-cover-position" class="form-control" value="{$coverPosition|escape:'htmlall':'UTF-8'}" min="1" />
                        <small class="form-text text-muted">{l s='Enter 1 to use default cover image' mod='googlemerchantfeed'}</small>
                    </div>
                </div>

                {* Export Additional Images *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='If you want to export only the cover image select "NO"' mod='googlemerchantfeed'}">
                            {l s='Export Additional Images?' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <span class="switch switch-primary">
                            <input type="radio" name="bt_add_images" id="bt_add_images_on" value="1" {if !empty($bAddImages)}checked{/if} />
                            <label for="bt_add_images_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                            <input type="radio" name="bt_add_images" id="bt_add_images_off" value="0" {if empty($bAddImages)}checked{/if} />
                            <label for="bt_add_images_off">{l s='No' mod='googlemerchantfeed'}</label>
                            <a class="slide-button btn"></a>
                        </span>
                    </div>
                </div>

                {* Include Product Dimensions *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        {l s='Include Product Dimensions?' mod='googlemerchantfeed'}
                    </label>
                    <div class="col-md-6">
                        <span class="switch switch-primary">
                            <input type="radio" name="bt_manage_product_size" id="bt_manage_product_size_on" value="1" {if !empty($bUseProductSize)}checked{/if} />
                            <label for="bt_manage_product_size_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                            <input type="radio" name="bt_manage_product_size" id="bt_manage_product_size_off" value="0" {if empty($bUseProductSize)}checked{/if} />
                            <label for="bt_manage_product_size_off">{l s='No' mod='googlemerchantfeed'}</label>
                            <a class="slide-button btn"></a>
                        </span>
                    </div>
                </div>

                {* Force Identifier Exists Tag *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='If you want to force the identifier_exists tag select YES' mod='googlemerchantfeed'}">
                            {l s='Force Identifier Exists Tag?' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <span class="switch switch-primary">
                            <input type="radio" name="bt_identifier_exist" id="bt_identifier_exist_on" value="1" {if !empty($bIdentifierExist)}checked{/if} />
                            <label for="bt_identifier_exist_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                            <input type="radio" name="bt_identifier_exist" id="bt_identifier_exist_off" value="0" {if empty($bIdentifierExist)}checked{/if} />
                            <label for="bt_identifier_exist_off">{l s='No' mod='googlemerchantfeed'}</label>
                            <a class="slide-button btn"></a>
                        </span>
                    </div>
                </div>

                {* Choose Your Home Category *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Please select the category that is the starting point of your tree view (it\'s usually your root or home category)' mod='googlemerchantfeed'}">
                            {l s='Choose Your Home Category' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_home-cat-id" class="form-control">
                            {foreach from=$aHomeCat item=aCat}
                                <option value="{$aCat.id_category|escape:'htmlall':'UTF-8'}" {if $aCat.id_category == $iHomeCatId}selected{/if}>
                                    {$aCat.name|escape:'htmlall':'UTF-8'}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                {* Select Your Product Type *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='In case where the product parent category wouldn\'t be found, the module needs to have a replacement value to enter in place of it.' mod='googlemerchantfeed'}">
                            {l s='Select Your Product Type' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        {foreach from=$aLangs item=aLang}
                            <div id="bt_home-cat-name_{$aLang.id_lang}" class="translatable-field row lang-{$aLang.id_lang}" {if $aLang.id_lang != $iCurrentLang}style="display:none"{/if}>
                                <div class="col-md-9">
                                    <input type="text" id="bt_home-cat-name_{$aLang.id_lang}" name="bt_home-cat-name_{$aLang.id_lang}" class="form-control"
                                        {if !empty($aHomeCatLanguages)}
                                            {foreach from=$aHomeCatLanguages key=idLang item=sLangTitle}
                                                {if $idLang == $aLang.id_lang} value="{$sLangTitle|escape:'htmlall':'UTF-8'}" {/if}
                                            {/foreach}
                                        {/if} />
                                </div>
                                <div class="col-md-3">
                                    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown">
                                        {$aLang.iso_code|escape:'htmlall':'UTF-8'} <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        {foreach from=$aLangs item=lang}
                                            <li><a href="javascript:hideOtherLanguage({$lang.id_lang});">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>

                {* Multiple Currencies *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='If your shop uses multiple currencies, you have to select "Yes" and modify the robot.txt file as explained in our FAQ.' mod='googlemerchantfeed'}">
                            {l s='Does Your Shop Support Multiple Currencies?' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <span class="switch switch-primary">
                            <input type="radio" name="bt_add-currency" id="bt_add-currency_on" value="1" {if !empty($bAddCurrency)}checked{/if} />
                            <label for="bt_add-currency_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                            <input type="radio" name="bt_add-currency" id="bt_add-currency_off" value="0" {if empty($bAddCurrency)}checked{/if} />
                            <label for="bt_add-currency_off">{l s='No' mod='googlemerchantfeed'}</label>
                            <a class="slide-button btn"></a>
                        </span>
                    </div>
                </div>

                {* General Condition of Products *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='In case where it wouldn\'t be found, the module needs to have a replacement value to enter in place of it.' mod='googlemerchantfeed'}">
                            {l s='What Is the General Condition of Your Products?' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_product-condition" class="form-control">
                            <option value="0" {if empty($sCondition)}selected{/if}>--</option>
                            {foreach from=$aAvailableCondition item=aCondition key=sCondName}
                                <option value="{$sCondName|escape:'htmlall':'UTF-8'}" {if $sCondition == $sCondName}selected{/if}>
                                    {$aCondition|escape:'htmlall':'UTF-8'}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                {* Product Name *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        {l s='Product Name Source' mod='googlemerchantfeed'}
                    </label>
                    <div class="col-md-6">
                        <select name="bt_prod-title" id="bt_prod-title" class="form-control" onchange="toggleAdvancedNameFields();">
                            <option value="title" {if $sProductTitle == 'title'}selected{/if}>
                                {l s='Use the product name' mod='googlemerchantfeed'}
                            </option>
                            <option value="meta" {if $sProductTitle == 'meta'}selected{/if}>
                                {l s='Use the product meta title' mod='googlemerchantfeed'}
                            </option>
                        </select>
                    </div>
                </div>

                {* Advanced Product Name *}
                <div class="form-group row" id="bt_advanced-prod-name-div">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='We advise you to add either the product category or the product brand in your product titles.' mod='googlemerchantfeed'}">
                            {l s='Advanced Product Name' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_advanced-prod-name" id="bt_advanced-prod-name" class="form-control" onchange="toggleAdvancedNameFields();">
                            <option value="0" {if $iAdvancedProductName == 0}selected{/if}>
                                {l s='Just the normal product name' mod='googlemerchantfeed'}
                            </option>
                            <option value="1" {if $iAdvancedProductName == 1}selected{/if}>
                                {l s='Current category name + Product name' mod='googlemerchantfeed'}
                            </option>
                            <option value="2" {if $iAdvancedProductName == 2}selected{/if}>
                                {l s='Product name + Current category name' mod='googlemerchantfeed'}
                            </option>
                            <option value="3" {if $iAdvancedProductName == 3}selected{/if}>
                                {l s='Brand name + Product name' mod='googlemerchantfeed'}
                            </option>
                            <option value="4" {if $iAdvancedProductName == 4}selected{/if}>
                                {l s='Product name + Brand name' mod='googlemerchantfeed'}
                            </option>
                            <option value="5" {if $iAdvancedProductName == 5}selected{/if}>
                                {l s='Free field + Product name + Free field' mod='googlemerchantfeed'}
                            </option>
                        </select>
                    </div>
                </div>

                {* Exclude exact phrases *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Enter the exact phrases one after the other by separating them with commas. Example: word1 word2,word3' mod='googlemerchantfeed'}">
                            {l s='Exclude exact phrases from product titles' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <textarea name="bt_excluded_words" class="form-control" rows="4">{$excludedWords|escape:'htmlall':'UTF-8'}</textarea>
                    </div>
                </div>

                {* Advanced Product Name: Prefix/Suffix *}
                <div id="bt_info-title-free-field" class="d-none">
                    <div class="form-group row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="alert alert-info">
                                <i class="material-icons">info</i>
                                {l s='The fields below let you create custom product titles thanks to a free choice of words to be placed before and/or after the product name.' mod='googlemerchantfeed'}
                            </div>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-3 form-control-label">{l s='Prefix' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            {foreach from=$aLangs item=aLang}
                                <div id="bt_advanced_prefix_name_{$aLang.id_lang}" class="translatable-field row lang-{$aLang.id_lang}" {if $aLang.id_lang != $iCurrentLang}style="display:none"{/if}>
                                    <div class="col-md-9">
                                        <input type="text" id="bt_advanced_prefix_name_{$aLang.id_lang}" name="bt_advanced_prefix_name_{$aLang.id_lang}" class="form-control"
                                            {if !empty($aProdNamePrefix)}
                                                {foreach from=$aProdNamePrefix key=idLang item=sLangTitle}
                                                    {if $idLang == $aLang.id_lang} value="{$sLangTitle|escape:'htmlall':'UTF-8'}" {/if}
                                                {/foreach}
                                            {/if} />
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown">
                                            {$aLang.iso_code|escape:'htmlall':'UTF-8'} <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            {foreach from=$aLangs item=lang}
                                                <li><a href="javascript:hideOtherLanguage({$lang.id_lang});">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-3 form-control-label">{l s='Suffix' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            {foreach from=$aLangs item=aLang}
                                <div id="bt_advanced_suffix_name_{$aLang.id_lang}" class="translatable-field row lang-{$aLang.id_lang}" {if $aLang.id_lang != $iCurrentLang}style="display:none"{/if}>
                                    <div class="col-md-9">
                                        <input type="text" id="bt_advanced_suffix_name_{$aLang.id_lang}" name="bt_advanced_suffix_name_{$aLang.id_lang}" class="form-control"
                                            {if !empty($aProdNameSuffix)}
                                                {foreach from=$aProdNameSuffix key=idLang item=sLangTitle}
                                                    {if $idLang == $aLang.id_lang} value="{$sLangTitle|escape:'htmlall':'UTF-8'}" {/if}
                                                {/foreach}
                                            {/if} />
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-toggle="dropdown">
                                            {$aLang.iso_code|escape:'htmlall':'UTF-8'} <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            {foreach from=$aLangs item=lang}
                                                <li><a href="javascript:hideOtherLanguage({$lang.id_lang});">{$lang.name|escape:'htmlall':'UTF-8'}</a></li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="alert alert-warning">
                                <i class="material-icons">warning</i>
                                {l s='Be careful: Google requires your product titles to be NO MORE than 150 characters long.' mod='googlemerchantfeed'}
                            </div>
                        </div>
                    </div>
                </div>

                {* Uppercase Letters Fix *}
                <div class="form-group row">
                    <label class="col-md-3 form-control-label">
                        <span class="label-tooltip" data-toggle="tooltip" title="{l s='Google will refuse your product feed if your product titles have too many UPPERCASE letters.' mod='googlemerchantfeed'}">
                            {l s='Do Your Titles Use Too Many Uppercase Letters?' mod='googlemerchantfeed'}
                        </span>
                    </label>
                    <div class="col-md-6">
                        <select name="bt_advanced-prod-title" id="bt_advanced-prod-title" class="form-control">
                            <option value="0" {if $iAdvancedProductTitle == 0}selected{/if}>
                                {l s='No' mod='googlemerchantfeed'}
                            </option>
                            <option value="1" {if $iAdvancedProductTitle == 1}selected{/if}>
                                {l s='Yes: Uppercase the first character of each title word' mod='googlemerchantfeed'}
                            </option>
                            <option value="2" {if $iAdvancedProductTitle == 2}selected{/if}>
                                {l s='Yes: Uppercase the title first character only' mod='googlemerchantfeed'}
                            </option>
                        </select>
                    </div>
                </div>

            </div> {* End card-body *}
            
            <div class="card-footer text-center">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="material-icons">save</i> {l s='Save' mod='googlemerchantfeed'}
                </button>
            </div>
        </div> {* End card *}
    </form>
</div>

{literal}
<script type="text/javascript">
    $(document).ready(function() {
        // Initialize tooltips
        $('.label-tooltip').tooltip();

        // Initial state setup on page load
        toggleProductIdWarning();
        togglePrefixField({/literal}{if !empty($bSimpleId)}true{else}false{/if}{literal});
        toggleAdvancedNameFields();

        // Helper function to toggle product ID warning
        window.toggleProductIdWarning = function() {
            var val = $('#bt_feed-tag-id').val();
            if (val === 'tag-id-basic') {
                $('#tag_id_warning_not_basic').addClass('d-none');
            } else {
                $('#tag_id_warning_not_basic').removeClass('d-none');
            }
        };

        // Helper function to toggle prefix field
        window.togglePrefixField = function(isSimple) {
            if (isSimple) {
                $('#bt_prefix_string').addClass('d-none');
                $('#prefix-id').val('');
            } else {
                $('#bt_prefix_string').removeClass('d-none');
            }
        };

        // Helper function to toggle advanced name fields (Replaces 50+ lines of repetitive if/else)
        window.toggleAdvancedNameFields = function() {
            var prodTitle = $('#bt_prod-title').val();
            var advName = $('#bt_advanced-prod-name').val();

            if (prodTitle === 'meta') {
                $('#bt_advanced-prod-name-div').addClass('d-none');
                $('#bt_info-title-free-field').addClass('d-none');
                return;
            } else {
                $('#bt_advanced-prod-name-div').removeClass('d-none');
            }

            $('#bt_info-title-free-field').addClass('d-none');

            if (advName === '5') {
                $('#bt_info-title-free-field').removeClass('d-none');
            }
        };
    });
</script>
{/literal}