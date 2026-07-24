{*
 * Google Shopping Export PRO - Feed Settings Form
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

{if $sDisplay == 'export' || $sDisplay == 'data'}
<script type="text/javascript">
    {literal}
    var oFeedSettingsCallBack = [
        {
            'name': 'displayFeedList',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=data',
            'toShow': 'bt_feed-list-settings-data', 'toHide': 'bt_feed-list-settings-data',
            'bFancybox': false, 'bFancyboxActivity': false, 'sLoadbar': null, 'sScrollTo': null, 'oCallBack': {}
        },
        {
            'name': 'displayFeedListPromo',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=promo',
            'toShow': 'bt_feed-list-settings-promo', 'toHide': 'bt_feed-list-settings-promo',
            'bFancybox': false, 'bFancyboxActivity': false, 'sLoadbar': null, 'sScrollTo': null, 'oCallBack': {}
        },
        {
            'name': 'displayFeedListStock',
            'url': '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
            'params': '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}{literal}={/literal}{$sController|escape:'htmlall':'UTF-8'}{literal}&sAction={/literal}{$aQueryParams.feedList.action|escape:'htmlall':'UTF-8'}{literal}&sType={/literal}{$aQueryParams.feedList.type|escape:'htmlall':'UTF-8'}{literal}&sDisplay=stock',
            'toShow': 'bt_feed-list-settings-stock', 'toHide': 'bt_feed-list-settings-stock',
            'bFancybox': false, 'bFancyboxActivity': false, 'sLoadbar': null, 'sScrollTo': null, 'oCallBack': {}
        }
    ];
    {/literal}
</script>
{/if}

<div class="bootstrap">
    <form class="form-horizontal" method="post" id="bt_feed-{$sDisplay|escape:'htmlall':'UTF-8'}-form" name="bt_feed-{$sDisplay|escape:'htmlall':'UTF-8'}-form" 
        {if $useJs}onsubmit="javascript: oGmcPro.form('bt_feed-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_feed-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt_feed-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, {if $sDisplay == 'export' || $sDisplay == 'data'}oFeedSettingsCallBack{else}null{/if}, 'Feed{$sDisplay|escape:'htmlall':'UTF-8'}', 'loadingFeedDiv'); return false;"{/if}>
        
        <input type="hidden" name="sAction" value="{$aQueryParams.feed.action|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sType" value="{$aQueryParams.feed.type|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sDisplay" id="sDisplay" value="{if !empty($sDisplay)}{$sDisplay|escape:'htmlall':'UTF-8'}{else}export{/if}" />

        <div class="card mb-4">
            <div class="card-body">
                {if !empty($bUpdate)}
                    {include file="`$sConfirmInclude`"}
                {elseif !empty($aErrors)}
                    {include file="`$sErrorInclude`"}
                {/if}

                {* ========================================================= *}
                {* USE CASE - Export                                         *}
                {* ========================================================= *}
                {if $sDisplay == 'export'}
                    <h3 class="subtitle"><i class="material-icons">publish</i> {l s='Export method' mod='googlemerchantfeed'}</h3>
                    
                    <div {if !empty($bExportMode)}class="d-none"{/if}>
                        {if $iMaxPostVars != false && $iShopCatCount > $iMaxPostVars}
                            <div class="alert alert-warning">
                                <i class="material-icons">warning</i>
                                {l s='Warning: apparently the number of variables that can be sent via a form is limited by your server, and the total number of your categories is greater than this maximum number of possible variables.' mod='googlemerchantfeed'}<br />
                                <strong>{$iShopCatCount|escape:'htmlall':'UTF-8'}</strong> {l s='categories out of' mod='googlemerchantfeed'} <strong>{$iMaxPostVars|escape:'htmlall':'UTF-8'}</strong> {l s='possible variables (PHP directive => max_input_vars)' mod='googlemerchantfeed'}
                            </div>
                        {/if}
                    </div>

                    <div class="form-group row mb-3" id="optionplus">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='You can choose to export your products by categories or by brands.' mod='googlemerchantfeed'}">
                                {l s='Select your export method' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <select name="bt_export" id="bt_export" class="form-control" onchange="toggleExportMethod();">
                                <option value="0" {if empty($bExportMode)}selected{/if}>{l s='Export by categories' mod='googlemerchantfeed'}</option>
                                <option value="1" {if !empty($bExportMode)}selected{/if}>{l s='Export by brands' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    {* Categories Tree *}
                    <div id="bt_categories" {if !empty($bExportMode)}class="d-none"{/if}>
                        <div class="form-group row mb-3">
                            <label class="col-md-3 form-control-label">
                                <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select the categories you want to export.' mod='googlemerchantfeed'}">
                                    {l s='Categories' mod='googlemerchantfeed'}
                                </span>
                            </label>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.categoryBox', 'check');">
                                        <i class="material-icons">check_box</i> {l s='Check All' mod='googlemerchantfeed'}
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.categoryBox', 'uncheck');">
                                        <i class="material-icons">indeterminate_check_box</i> {l s='Uncheck All' mod='googlemerchantfeed'}
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <tbody>
                                            {foreach from=$aFormatCat name=category key=iKey item=aCat}
                                                <tr>
                                                    <td style="width: 10%;">{$aCat.id_category|escape:'htmlall':'UTF-8'}</td>
                                                    <td style="width: 10%; text-align: center;">
                                                        <input type="checkbox" name="bt_category-box[]" class="categoryBox form-check-input" id="bt_category-box_{$aCat.iNewLevel|escape:'htmlall':'UTF-8'}" value="{$aCat.id_category|escape:'htmlall':'UTF-8'}" {if !empty($aCat.bCurrent)}checked{/if} />
                                                    </td>
                                                    <td>
                                                        <i class="material-icons text-muted" style="vertical-align: middle; margin-right: 5px;">{if !empty($aCat.bCurrent)}folder_open{else}folder{/if}</i>
                                                        <span style="margin-left: {$aCat.iNewLevel|escape:'htmlall':'UTF-8'}5px;">{$aCat.name|escape:'htmlall':'UTF-8'}</span>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    {* Brands Tree *}
                    <div id="bt_brands" {if empty($bExportMode)}class="d-none"{/if}>
                        <div class="form-group row mb-3">
                            <label class="col-md-3 form-control-label">
                                <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select the brands you want to export.' mod='googlemerchantfeed'}">
                                    {l s='Brands' mod='googlemerchantfeed'}
                                </span>
                            </label>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.brandBox', 'check');">
                                        <i class="material-icons">check_box</i> {l s='Check All' mod='googlemerchantfeed'}
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.brandBox', 'uncheck');">
                                        <i class="material-icons">indeterminate_check_box</i> {l s='Uncheck All' mod='googlemerchantfeed'}
                                    </button>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover">
                                        <tbody>
                                            {foreach from=$aFormatBrands name=brand key=iKey item=aBrand}
                                                <tr>
                                                    <td style="width: 10%;">{$aBrand.id|escape:'htmlall':'UTF-8'}</td>
                                                    <td style="width: 10%; text-align: center;">
                                                        <input type="checkbox" name="bt_brand-box[]" class="brandBox form-check-input" id="bt_brand-box_{$aBrand.id|escape:'htmlall':'UTF-8'}" value="{$aBrand.id|escape:'htmlall':'UTF-8'}" {if !empty($aBrand.checked)}checked{/if} />
                                                    </td>
                                                    <td>
                                                        <i class="material-icons text-muted" style="vertical-align: middle; margin-right: 5px;">{if !empty($aBrand.checked)}folder_open{else}folder{/if}</i>
                                                        {$aBrand.name|escape:'htmlall':'UTF-8'}
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                {* ========================================================= *}
                {* USE CASE - Exclusion                                      *}
                {* ========================================================= *}
                {if $sDisplay == 'exclusion'}
                    <ul class="nav nav-tabs mb-3" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link {if empty($aExclusionRules)}active{/if}" data-toggle="tab" href="#exclusion-basic" role="tab">
                                <i class="material-icons">settings</i> {l s='General exclusion' mod='googlemerchantfeed'}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {if !empty($aExclusionRules)}active{/if}" data-toggle="tab" href="#exclusion-advanced" role="tab">
                                <i class="material-icons">code</i> {l s='Advanced exclusion' mod='googlemerchantfeed'}
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane {if empty($aExclusionRules)}active{/if}" id="exclusion-basic">
                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='If YES: all products, even out of stock, will be exported. If NO: only in-stock products.' mod='googlemerchantfeed'}">
                                        {l s='Export out of stock products?' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_export-oos" id="bt_export-oos_on" value="1" {if !empty($bExportOOS)}checked{/if} onchange="toggleOosOptions(true);" />
                                        <label for="bt_export-oos_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_export-oos" id="bt_export-oos_off" value="0" {if empty($bExportOOS)}checked{/if} onchange="toggleOosOptions(false);" />
                                        <label for="bt_export-oos_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row mb-3 {if empty($bExportOOS)}d-none{/if}" id="bt_div_product_oos">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='If YES: out of stock products authorized for orders will be exported.' mod='googlemerchantfeed'}">
                                        {l s='Do not export when you deny orders for out-of-stock products?' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_product-oos-order" id="bt_product-oos-order_on" value="1" {if !empty($bProductOosOrder)}checked{/if} />
                                        <label for="bt_product-oos-order_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_product-oos-order" id="bt_product-oos-order_off" value="0" {if empty($bProductOosOrder)}checked{/if} />
                                        <label for="bt_product-oos-order_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='If YES: products without EAN13/JAN, UPC, or ISBN will NOT be exported.' mod='googlemerchantfeed'}">
                                        {l s='Do NOT export products without EAN13/JAN, UPC, or ISBN?' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_excl-no-ean" id="bt_excl-no-ean_on" value="1" {if !empty($bExcludeNoEan)}checked{/if} />
                                        <label for="bt_excl-no-ean_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_excl-no-ean" id="bt_excl-no-ean_off" value="0" {if empty($bExcludeNoEan)}checked{/if} />
                                        <label for="bt_excl-no-ean_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='If YES: products without MPN (manufacturer) code will NOT be exported.' mod='googlemerchantfeed'}">
                                        {l s='Do NOT export products without a manufacturer (MPN) reference?' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_excl-no-mref" id="bt_excl-no-mref_on" value="1" {if !empty($bExcludeNoMref)}checked{/if} />
                                        <label for="bt_excl-no-mref_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_excl-no-mref" id="bt_excl-no-mref_off" value="0" {if empty($bExcludeNoMref)}checked{/if} />
                                        <label for="bt_excl-no-mref_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Any product whose CURRENT price is lower than this value will be excluded.' mod='googlemerchantfeed'}">
                                        {l s='Do NOT export products with price lower than:' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-2">
                                    <input type="number" step="0.01" name="bt_min-price" class="form-control" value="{if !empty($iMinPrice)}{$iMinPrice|floatval}{/if}" />
                                    <small class="text-muted">{l s='Tax excluded' mod='googlemerchantfeed'}</small>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Any product whose CURRENT weight is higher than this value will be excluded.' mod='googlemerchantfeed'}">
                                        {l s='Do NOT export products with weight greater than:' mod='googlemerchantfeed'}
                                    </span>
                                </label>
                                <div class="col-md-2">
                                    <input type="number" step="0.01" name="bt_max-weight" class="form-control" value="{if !empty($iMaxWeight)}{$iMaxWeight|floatval}{/if}" />
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane {if !empty($aExclusionRules)}active{/if}" id="exclusion-advanced">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="mb-0">{l s='Exclusion Rules' mod='googlemerchantfeed'}</h4>
                                <a id="handleExclusion" class="fancybox.ajax btn btn-primary" href="{$sURI|escape:'htmlall':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.exclusionRule.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.exclusionRule.type|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">add</i> {l s='Add exclusion rule' mod='googlemerchantfeed'}
                                </a>
                            </div>
                            
                            <p class="alert alert-warning">
                                <i class="material-icons">warning</i>
                                {l s='Be careful: after having created custom rules, if you want to change the "About products with combinations" option value, you will have to delete all created rules and re-create them.' mod='googlemerchantfeed'}
                            </p>

                            {if !empty($aExclusionRules)}
                                <div class="mb-3">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.RulesBox', 'check');">
                                        <i class="material-icons">check_box</i> {l s='Check All' mod='googlemerchantfeed'}
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.RulesBox', 'uncheck');">
                                        <i class="material-icons">indeterminate_check_box</i> {l s='Unselect All' mod='googlemerchantfeed'}
                                    </button>
                                    <button class="btn btn-success btn-sm" onclick="bulkActionRules(1, 'activate')">
                                        <i class="material-icons">check_circle</i> {l s='Activate selection' mod='googlemerchantfeed'}
                                    </button>
                                    <button class="btn btn-warning btn-sm" onclick="bulkActionRules(0, 'deactivate')">
                                        <i class="material-icons">cancel</i> {l s='Deactivate selection' mod='googlemerchantfeed'}
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="bulkActionRules(null, 'delete')">
                                        <i class="material-icons">delete</i> {l s='Delete selection' mod='googlemerchantfeed'}
                                    </button>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="text-center" style="width: 5%;"></th>
                                                <th class="text-center" style="width: 10%;">#</th>
                                                <th class="text-center" style="width: 10%;"><b>{l s='Status' mod='googlemerchantfeed'}</b></th>
                                                <th><b>{l s='Rule\'s name' mod='googlemerchantfeed'}</b></th>
                                                <th class="text-center" style="width: 15%;"><b>{l s='View affected products' mod='googlemerchantfeed'}</b></th>
                                                <th class="text-center" style="width: 20%;"><b>{l s='Actions' mod='googlemerchantfeed'}</b></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$aExclusionRules key=key item=sRule}
                                                <tr>
                                                    <td class="text-center">
                                                        <input id="bt_rules-box_{$sRule.id|escape:'htmlall':'UTF-8'}" name="bt_rules-box" class="RulesBox form-check-input" type="checkbox" value="{$sRule.id|escape:'htmlall':'UTF-8'}" />
                                                    </td>
                                                    <td class="text-center">{$sRule.id|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center">
                                                        {if $sRule.status == 1}
                                                            <a href="#" onclick="toggleRuleStatus({$sRule.id|escape:'htmlall':'UTF-8'}, 0); return false;">
                                                                <i class="material-icons text-success" title="{l s='Deactivate' mod='googlemerchantfeed'}">check_circle</i>
                                                            </a>
                                                        {else}
                                                            <a href="#" onclick="toggleRuleStatus({$sRule.id|escape:'htmlall':'UTF-8'}, 1); return false;">
                                                                <i class="material-icons text-danger" title="{l s='Activate' mod='googlemerchantfeed'}">cancel</i>
                                                            </a>
                                                        {/if}
                                                    </td>
                                                    <td>{$sRule.name|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center">
                                                        <a id="handleExclusionProducts" class="fancybox.ajax btn btn-info btn-sm" href="{$sURI|escape:'htmlall':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.exclusionRuleProducts.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.exclusionRuleProducts.type|escape:'htmlall':'UTF-8'}&iRuleId={$sRule.id|escape:'htmlall':'UTF-8'}">
                                                            <i class="material-icons">visibility</i>
                                                        </a>
                                                    </td>
                                                    <td class="text-center">
                                                        <a id="handleExclusion" class="fancybox.ajax btn btn-info btn-sm" href="{$sURI|escape:'htmlall':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.exclusionRule.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.exclusionRule.type|escape:'htmlall':'UTF-8'}&iRuleId={$sRule.id|escape:'htmlall':'UTF-8'}">
                                                            <i class="material-icons">edit</i>
                                                        </a>
                                                        <a href="#" onclick="deleteRule({$sRule.id|escape:'htmlall':'UTF-8'}); return false;">
                                                            <i class="material-icons text-danger" title="{l s='Delete' mod='googlemerchantfeed'}">delete</i>
                                                        </a>
                                                        {if $sRule.status == 1}
                                                            <a href="#" onclick="toggleRuleStatus({$sRule.id|escape:'htmlall':'UTF-8'}, 0); return false;">
                                                                <i class="material-icons text-warning" title="{l s='Deactivate' mod='googlemerchantfeed'}">pause_circle_filled</i>
                                                            </a>
                                                        {else}
                                                            <a href="#" onclick="toggleRuleStatus({$sRule.id|escape:'htmlall':'UTF-8'}, 1); return false;">
                                                                <i class="material-icons text-success" title="{l s='Activate' mod='googlemerchantfeed'}">play_circle_filled</i>
                                                            </a>
                                                        {/if}
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}

                {* ========================================================= *}
                {* USE CASE - Feed data options                              *}
                {* ========================================================= *}
                {if $sDisplay == 'data'}
                    <h3 class="subtitle"><i class="material-icons">feed</i> {l s='Feed data options' mod='googlemerchantfeed'}</h3>
                    
                    <div class="alert alert-info mb-3">
                        <i class="material-icons">info</i>
                        {l s='The more detailed information you provide to Google, the better your products will rank. Try to include as much information as possible.' mod='googlemerchantfeed'}
                        <b><a href="https://support.google.com/merchants/answer/7052112" target="_blank" class="alert-link">{l s='See Google documentation' mod='googlemerchantfeed'}</a></b>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label"><b>{l s='About products with combinations' mod='googlemerchantfeed'}</b></label>
                        <div class="col-md-6">
                            <select name="bt_prod-combos" id="bt_prod-combos" class="form-control" onchange="toggleCombosOptions();">
                                <option value="0" {if empty($bProductCombos)}selected{/if}>{l s='Export all combinations in a single product' mod='googlemerchantfeed'}</option>
                                <option value="1" {if !empty($bProductCombos)}selected{/if}>{l s='Export each combination as a product in its own right' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div id="bt_prod-combos-opts" class="{if empty($bProductCombos)}d-none{/if}">
                        <div class="form-group row mb-3">
                            <label class="col-md-3 form-control-label">
                                <span class="label-tooltip" data-toggle="tooltip" title="{l s='If you don\'t want to show the attribute values in your product combination titles, select "NO"' mod='googlemerchantfeed'}">
                                    {l s='Include attribute values in product combination titles?' mod='googlemerchantfeed'}
                                </span>
                            </label>
                            <div class="col-md-6">
                                <span class="switch switch-primary">
                                    <input type="radio" name="bt_include_attribute_values" id="bt_include_attribute_values_on" value="1" {if !empty($bIncludeAttributeValue)}checked{/if} />
                                    <label for="bt_include_attribute_values_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                    <input type="radio" name="bt_include_attribute_values" id="bt_include_attribute_values_off" value="0" {if empty($bIncludeAttributeValue)}checked{/if} />
                                    <label for="bt_include_attribute_values_off">{l s='No' mod='googlemerchantfeed'}</label>
                                    <a class="slide-button btn"></a>
                                </span>
                            </div>
                        </div>

                        <div class="form-group row mb-3">
                            <label class="col-md-3 form-control-label">
                                <span class="label-tooltip" data-toggle="tooltip" title="{l s='Activate this option if you have a URL rewriting module that prevents Google from arriving at the page corresponding to the targeted combination' mod='googlemerchantfeed'}">
                                    {l s='Include anchors in combination URLs?' mod='googlemerchantfeed'}
                                </span>
                            </label>
                            <div class="col-md-6">
                                <span class="switch switch-primary">
                                    <input type="radio" name="bt_include_anchor" id="bt_include_anchor_on" value="1" {if !empty($bIncludeAnchor)}checked{/if} />
                                    <label for="bt_include_anchor_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                    <input type="radio" name="bt_include_anchor" id="bt_include_anchor_off" value="0" {if empty($bIncludeAnchor)}checked{/if} />
                                    <label for="bt_include_anchor_off">{l s='No' mod='googlemerchantfeed'}</label>
                                    <a class="slide-button btn"></a>
                                </span>
                            </div>
                        </div>

                        <div class="form-group row mb-3">
                            <label class="col-md-3 form-control-label">
                                <span class="label-tooltip" title="{l s='The "feed id" of a product is built like this: "Shop prefix + Language + product id + separator + combination id".' mod='googlemerchantfeed'}">
                                    {l s='Choose the separator between product id and combination id' mod='googlemerchantfeed'}
                                </span>
                            </label>
                            <div class="col-md-2">
                                <input type="text" name="bt_combo-separator" class="form-control" value="{$sComboSeparator|escape:'htmlall':'UTF-8'}" maxlength="5" />
                            </div>
                        </div>
                    </div>

                    {if !empty($aProducts)}
                        <div class="form-group row mb-3">
                            <div class="col-md-9 offset-md-3">
                                <p class="alert alert-warning mb-0">
                                    <i class="material-icons">warning</i>
                                    {l s='Note: as it seems that you have defined some product exclusions, if you change the option above, you will have to define again the product exclusions.' mod='googlemerchantfeed'}
                                </p>
                            </div>
                        </div>
                    {/if}

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label"><b>{l s='Which description type do you want to use?' mod='googlemerchantfeed'}</b></label>
                        <div class="col-md-6">
                            <select name="bt_prod-desc-type" class="form-control">
                                {foreach from=$aDescriptionType name=desc key=iKey item=sType}
                                    <option value="{$iKey|escape:'htmlall':'UTF-8'}" {if $iKey == $iDescType}selected{/if}>{$sType|escape:'htmlall':'UTF-8'}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label"><b>{l s='About product availability' mod='googlemerchantfeed'}</b></label>
                        <div class="col-md-6">
                            <select name="bt_incl-stock" class="form-control">
                                <option value="1" {if $iIncludeStock == 1}selected{/if}>{l s='Only indicate products as available IF they are actually in stock' mod='googlemerchantfeed'}</option>
                                <option value="2" {if $iIncludeStock == 2}selected{/if}>{l s='Always indicate products as available, EVEN IF they are in fact out of stock' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='If you have both EAN13/JAN and UPC codes, you can decide which one to check first.' mod='googlemerchantfeed'}">
                                {l s='Determination of priority GTIN (EAN13/JAN or UPC or ISBN):' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <select name="bt_gtin-pref" class="form-control">
                                <option value="ean" {if $sGtinPreference == 'ean'}selected{/if}>{l s='Check EAN13/JAN code first' mod='googlemerchantfeed'}</option>
                                <option value="upc" {if $sGtinPreference == 'upc'}selected{/if}>{l s='Check UPC code first' mod='googlemerchantfeed'}</option>
                                <option value="isbn" {if $sGtinPreference == 'isbn'}selected{/if}>{l s='Check ISBN code first' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Use this tag for products that are for adults only.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include adult tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-tag-adult" id="bt_incl-tag-adult_on" value="1" {if !empty($bIncludeTagAdult)}checked{/if} onchange="toggleAdultLink(true);" />
                                <label for="bt_incl-tag-adult_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-tag-adult" id="bt_incl-tag-adult_off" value="0" {if empty($bIncludeTagAdult)}checked{/if} onchange="toggleAdultLink(false);" />
                                <label for="bt_incl-tag-adult_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>

                    <div class="form-group row mb-3 {if empty($bIncludeTagAdult)}d-none{/if}" id="tag_adult_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeTagAdult)}
                                <a class="btn btn-success" href="{$handleTagAdultLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='In order to export product sizes in your data feed, select what feature or attribute(s) define the size.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include product sizes?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <select name="bt_incl-size" id="inc_size" class="form-control" onchange="toggleSizeColorOptions('size', this.value);">
                                <option value="" {if $sIncludeSize == ''}selected{/if}>{l s='No' mod='googlemerchantfeed'}</option>
                                <option value="attribute" {if $sIncludeSize == 'attribute'}selected{/if}>{l s='Yes: select ATTRIBUTE(S) that define sizes' mod='googlemerchantfeed'}</option>
                                <option value="feature" {if $sIncludeSize == 'feature'}selected{/if}>{l s='Yes: select FEATURE that define sizes' mod='googlemerchantfeed'}</option>
                                <option value="both" {if $sIncludeSize == 'both'}selected{/if}>{l s='Yes: select ATTRIBUTE(S) AND FEATURE that define sizes' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3 {if $sIncludeSize == ''}d-none{/if}" id="div_size_opt_attr">
                        <label class="col-md-3 form-control-label">{l s='Size Attributes' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            <select name="bt_size-opt[attribute][]" multiple class="form-control" size="5">
                                <option value="" disabled style="color: #aaa; font-weight: bold;">{l s='Attributes (multiple choice)' mod='googlemerchantfeed'}</option>
                                {foreach from=$aAttributeGroups name=attribute key=iKey item=aGroup}
                                    <option value="{$aGroup.id_attribute_group|escape:'htmlall':'UTF-8'}" {if !empty($aSizeOptions.attribute) && in_array($aGroup.id_attribute_group, $aSizeOptions.attribute)}selected{/if}>
                                        {$aGroup.name|escape:'htmlall':'UTF-8'}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3 {if $sIncludeSize != 'feature' && $sIncludeSize != 'both'}d-none{/if}" id="div_size_opt_feat">
                        <label class="col-md-3 form-control-label">{l s='Size Features' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            <select name="bt_size-opt[feature][]" class="form-control" size="5">
                                <option value="" disabled style="color: #aaa; font-weight: bold;">{l s='Features (one choice)' mod='googlemerchantfeed'}</option>
                                {foreach from=$aFeatures name=feature key=iKey item=aFeature}
                                    <option value="{$aFeature.id_feature|escape:'htmlall':'UTF-8'}" {if !empty($aSizeOptions.feature) && in_array($aFeature.id_feature, $aSizeOptions.feature)}selected{/if}>
                                        {$aFeature.name|escape:'htmlall':'UTF-8'}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    
                    {* Color options follow the exact same pattern as Size options above *}
                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" title="{l s='In order to export product colors in your data feed, select what feature or attribute(s) define the color.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include product colors?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <select name="bt_incl-color" id="inc_color" class="form-control" onchange="toggleSizeColorOptions('color', this.value);">
                                <option value="" {if $sIncludeColor == ''}selected{/if}>{l s='No' mod='googlemerchantfeed'}</option>
                                <option value="attribute" {if $sIncludeColor == 'attribute'}selected{/if}>{l s='Yes: select ATTRIBUTE(S) that define colors' mod='googlemerchantfeed'}</option>
                                <option value="feature" {if $sIncludeColor == 'feature'}selected{/if}>{l s='Yes: select FEATURE that define colors' mod='googlemerchantfeed'}</option>
                                <option value="both" {if $sIncludeColor == 'both'}selected{/if}>{l s='Yes: select ATTRIBUTE(S) AND FEATURE that define colors' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3 {if $sIncludeColor == ''}d-none{/if}" id="div_color_opt_attr">
                        <label class="col-md-3 form-control-label">{l s='Color Attributes' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            <select name="bt_color-opt[attribute][]" multiple class="form-control" size="5">
                                <option value="" disabled style="color: #aaa; font-weight: bold;">{l s='Attributes (multiple choice)' mod='googlemerchantfeed'}</option>
                                {foreach from=$aAttributeGroups name=attribute key=iKey item=aGroup}
                                    <option value="{$aGroup.id_attribute_group|escape:'htmlall':'UTF-8'}" {if !empty($aColorOptions.attribute) && in_array($aGroup.id_attribute_group, $aColorOptions.attribute)}selected{/if}>
                                        {$aGroup.name|escape:'htmlall':'UTF-8'}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3 {if $sIncludeColor != 'feature' && $sIncludeColor != 'both'}d-none{/if}" id="div_color_opt_feat">
                        <label class="col-md-3 form-control-label">{l s='Color Features' mod='googlemerchantfeed'}</label>
                        <div class="col-md-6">
                            <select name="bt_color-opt[feature][]" class="form-control" size="5">
                                <option value="" disabled style="color: #aaa; font-weight: bold;">{l s='Features (one choice)' mod='googlemerchantfeed'}</option>
                                {foreach from=$aFeatures name=feature key=iKey item=aFeature}
                                    <option value="{$aFeature.id_feature|escape:'htmlall':'UTF-8'}" {if !empty($aColorOptions.feature) && in_array($aFeature.id_feature, $aColorOptions.feature)}selected{/if}>
                                        {$aFeature.name|escape:'htmlall':'UTF-8'}
                                    </option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" title="{l s='A setting that allows you to provide the country from which your product will typically ship. Must be the country ISO code' mod='googlemerchantfeed'}">
                                {l s='Ships from country' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-2">
                            <input type="text" name="bt_ships_from" class="form-control" value="{if !empty($shipsFrom)}{$shipsFrom|escape:'htmlall':'UTF-8'}{/if}" maxlength="5" />
                        </div>
                    </div>
                {/if}

                {* ========================================================= *}
                {* USE CASE - Apparel                                        *}
                {* ========================================================= *}
                {if $sDisplay == 'apparel'}
                    <h3 class="subtitle"><i class="material-icons">checkroom</i> {l s='Apparel feed options' mod='googlemerchantfeed'}</h3>
                    <div class="alert alert-info mb-3">
                        <i class="material-icons">info</i>
                        <b>{l s='It is strongly recommended that apparel shops include these tags if the information is available.' mod='googlemerchantfeed'}</b>
                    </div>

                    {* Material Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, indicate the feature that defines the material.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include material tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-material" id="bt_incl-material_on" value="1" {if !empty($bIncludeMaterial)}checked{/if} onchange="toggleApparelLink('material_link', true);" />
                                <label for="bt_incl-material_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-material" id="bt_incl-material_off" value="0" {if empty($bIncludeMaterial)}checked{/if} onchange="toggleApparelLink('material_link', false);" />
                                <label for="bt_incl-material_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeMaterial)}d-none{/if}" id="material_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeMaterial)}
                                <a class="btn btn-success" href="{$handleTagMaterialLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>
                    
                    {* Pattern Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, indicate the feature that defines the pattern.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include pattern tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-pattern" id="bt_incl-pattern_on" value="1" {if !empty($bIncludePattern)}checked{/if} onchange="toggleApparelLink('pattern_link', true);" />
                                <label for="bt_incl-pattern_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-pattern" id="bt_incl-pattern_off" value="0" {if empty($bIncludePattern)}checked{/if} onchange="toggleApparelLink('pattern_link', false);" />
                                <label for="bt_incl-pattern_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludePattern)}d-none{/if}" id="pattern_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludePattern)}
                                <a class="btn btn-success" href="{$handleTagPatternLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Gender Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, select which Google predefined "gender" value defines the gender.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include gender tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-gender" id="bt_incl-gender_on" value="1" {if !empty($bIncludeGender)}checked{/if} onchange="toggleApparelLink('gender_link', true);" />
                                <label for="bt_incl-gender_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-gender" id="bt_incl-gender_off" value="0" {if empty($bIncludeGender)}checked{/if} onchange="toggleApparelLink('gender_link', false);" />
                                <label for="bt_incl-gender_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeGender)}d-none{/if}" id="gender_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeGender)}
                                <a class="btn btn-success" href="{$handleTagGenderLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Age Group Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, select which Google predefined "age group" value defines the age group.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include age group tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-age" id="bt_incl-age_on" value="1" {if !empty($bIncludeAge)}checked{/if} onchange="toggleApparelLink('age_group_link', true);" />
                                <label for="bt_incl-age_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-age" id="bt_incl-age_off" value="0" {if empty($bIncludeAge)}checked{/if} onchange="toggleApparelLink('age_group_link', false);" />
                                <label for="bt_incl-age_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeAge)}d-none{/if}" id="age_group_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeAge)}
                                <a class="btn btn-success" href="{$handleTagAgeGroupeLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Size Type Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, select which Google predefined "size type" value defines the size type.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include size type tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-size_type" id="bt_incl-size_type_on" value="1" {if !empty($bSizeType)}checked{/if} onchange="toggleApparelLink('size_type', true);" />
                                <label for="bt_incl-size_type_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-size_type" id="bt_incl-size_type_off" value="0" {if empty($bSizeType)}checked{/if} onchange="toggleApparelLink('size_type', false);" />
                                <label for="bt_incl-size_type_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bSizeType)}d-none{/if}" id="size_type">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bSizeType)}
                                <a class="btn btn-success" href="{$handleSizeType|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Size System Tag *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='For each product default category, select which Google predefined "size system" value defines the size system.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include size system tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-size_system" id="bt_incl-size_system_on" value="1" {if !empty($bSizeSystem)}checked{/if} onchange="toggleApparelLink('size_system', true);" />
                                <label for="bt_incl-size_system_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-size_system" id="bt_incl-size_system_off" value="0" {if empty($bSizeSystem)}checked{/if} onchange="toggleApparelLink('size_system', false);" />
                                <label for="bt_incl-size_system_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bSizeSystem)}d-none{/if}" id="size_system">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bSizeSystem)}
                                <a class="btn btn-success" href="{$handleSizeSystem|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>
                {/if}

                {* ========================================================= *}
                {* USE CASE - Advanced                                       *}
                {* ========================================================= *}
                {if $sDisplay == 'advanced'}
                    <h3 class="subtitle"><i class="material-icons">build</i> {l s='Advanced feed options' mod='googlemerchantfeed'}</h3>
                    <div class="alert alert-info mb-3">
                        <i class="material-icons">info</i>
                        <b>{l s='Depending on your sales area, local laws or regulations, you may be required to provide the following tags.' mod='googlemerchantfeed'}</b>
                    </div>

                    {* Energy Efficiency *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Indicate the feature that defines the energy efficiency class.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include energy efficiency class tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-energy" id="bt_incl-energy_on" value="1" {if !empty($bIncludeEnergy)}checked{/if} onchange="toggleApparelLink('energy_link', true);" />
                                <label for="bt_incl-energy_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-energy" id="bt_incl-energy_off" value="0" {if empty($bIncludeEnergy)}checked{/if} onchange="toggleApparelLink('energy_link', false);" />
                                <label for="bt_incl-energy_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeEnergy)}d-none{/if}" id="energy_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeEnergy)}
                                <a class="btn btn-success" href="{$handleTagEnergyLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Shipping Label *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Indicate the feature that defines the shipping label of the products.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include shipping label tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl-shipping-label" id="bt_incl-shipping-label_on" value="1" {if !empty($bIncludeShippingLabel)}checked{/if} onchange="toggleApparelLink('shipping-label_link', true);" />
                                <label for="bt_incl-shipping-label_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl-shipping-label" id="bt_incl-shipping-label_off" value="0" {if empty($bIncludeShippingLabel)}checked{/if} onchange="toggleApparelLink('shipping-label_link', false);" />
                                <label for="bt_incl-shipping-label_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeShippingLabel)}d-none{/if}" id="shipping-label_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeShippingLabel)}
                                <a class="btn btn-success" href="{$handleTagShippingLabelLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Unit Pricing Measure *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Indicate the feature that defines the unit pricing measure.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include unit pricing measure tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl_unit_pricing_measure" id="bt_incl_unit_pricing_measure_on" value="1" {if !empty($bIncludeUnitpricingMeasure)}checked{/if} onchange="toggleUnitPricing(true);" />
                                <label for="bt_incl_unit_pricing_measure_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl_unit_pricing_measure" id="bt_incl_unit_pricing_measure_off" value="0" {if empty($bIncludeUnitpricingMeasure)}checked{/if} onchange="toggleUnitPricing(false);" />
                                <label for="bt_incl_unit_pricing_measure_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeUnitpricingMeasure)}d-none{/if}" id="unit_pricing_measure_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeUnitpricingMeasure)}
                                <a class="btn btn-success" href="{$handleUnitPriceMeasureLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Unit Pricing Base Measure *}
                    <div class="form-group row mb-3 {if empty($bIncludeUnitpricingMeasure)}d-none{/if}" id="base_unit_price">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Indicate the feature that defines the unit pricing base measure.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include unit pricing base measure tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_incl_unit_base_pricing_measure" id="bt_incl_unit_base_pricing_measure_on" value="1" {if !empty($bIncludeUnitBasepricingMeasure)}checked{/if} onchange="toggleApparelLink('unit_base_pricing_measure_link', true);" />
                                <label for="bt_incl_unit_base_pricing_measure_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_incl_unit_base_pricing_measure" id="bt_incl_unit_base_pricing_measure_off" value="0" {if empty($bIncludeUnitBasepricingMeasure)}checked{/if} onchange="toggleApparelLink('unit_base_pricing_measure_link', false);" />
                                <label for="bt_incl_unit_base_pricing_measure_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bIncludeUnitBasepricingMeasure) || empty($bIncludeUnitpricingMeasure)}d-none{/if}" id="unit_base_pricing_measure_link">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bIncludeUnitBasepricingMeasure)}
                                <a class="btn btn-success" href="{$handleBaseUnitPricingMeasureLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Excluded Destination *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Use this tag to prevent some products from appearing on certain advertising channels.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include excluded destination tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_excl_dest" id="bt_excl_dest_on" value="1" {if !empty($bExcludedDest)}checked{/if} onchange="toggleApparelLink('excl_dest', true);" />
                                <label for="bt_excl_dest_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_excl_dest" id="bt_excl_dest_off" value="0" {if empty($bExcludedDest)}checked{/if} onchange="toggleApparelLink('excl_dest', false);" />
                                <label for="bt_excl_dest_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bExcludedDest)}d-none{/if}" id="excl_dest">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bExcludedDest)}
                                <a class="btn btn-success" href="{$handleExcludedDestinationLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Excluded Country *}
                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Use this tag to prevent some products from appearing in certain countries.' mod='googlemerchantfeed'}">
                                {l s='Do you want to include shopping ads excluded country tags?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <span class="switch switch-primary">
                                <input type="radio" name="bt_excl_country" id="bt_excl_country_on" value="1" {if !empty($bExcludedCountry)}checked{/if} onchange="toggleApparelLink('excl_country', true);" />
                                <label for="bt_excl_country_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                <input type="radio" name="bt_excl_country" id="bt_excl_country_off" value="0" {if empty($bExcludedCountry)}checked{/if} onchange="toggleApparelLink('excl_country', false);" />
                                <label for="bt_excl_country_off">{l s='No' mod='googlemerchantfeed'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group row mb-3 {if empty($bExcludedCountry)}d-none{/if}" id="excl_country">
                        <div class="col-md-9 offset-md-3">
                            {if !empty($bExcludedCountry)}
                                <a class="btn btn-success" href="{$handleExcludedCountryLink|escape:'htmlall':'UTF-8'}">
                                    <i class="material-icons">settings</i> {l s='Click here to configure the tag for each category' mod='googlemerchantfeed'}
                                </a>
                            {else}
                                <span class="alert alert-danger d-block">{l s='Please save this page before configuring the tag' mod='googlemerchantfeed'}</span>
                            {/if}
                        </div>
                    </div>

                    {* Pause Products *}
                    <h4 class="mt-4 mb-3"><i class="material-icons">pause_circle_filled</i> {l s='Stop showing products for a short time' mod='googlemerchantfeed'}</h4>
                    <div class="alert alert-info mb-3">
                        {l s='You can temporarily stop certain products from showing in your ads and free listings. This pause cannot exceed 14 days.' mod='googlemerchantfeed'}
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <span class="label-tooltip" title="{l s='Select your use of the "pause" tag.' mod='googlemerchantfeed'}">
                                {l s='Do you want to pause showing certain products?' mod='googlemerchantfeed'}
                            </span>
                        </label>
                        <div class="col-md-6">
                            <select name="bt_tag_pause" class="form-control">
                                <option value="0" {if $tagPause == 0}selected{/if}>{l s='No: do not activate the "Pause" tag' mod='googlemerchantfeed'}</option>
                                <option value="all" {if $tagPause == 'all'}selected{/if}>{l s='Yes: pause the products below for all channels (ads + free listings)' mod='googlemerchantfeed'}</option>
                                <option value="ads" {if $tagPause == 'ads'}selected{/if}>{l s='Yes: pause the products below only for ads locations' mod='googlemerchantfeed'}</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-4 form-control-label">
                            <b>{l s='Enter the products to be paused:' mod='googlemerchantfeed'}</b>
                        </label>
                        <div class="col-md-6">
                            <input type="text" id="bt_search-p-pause-tag" name="bt_search-p-pause-tag" class="form-control" placeholder="{l s='Start typing a product name' mod='googlemerchantfeed'}" />
                        </div>
                    </div>

					<input type="hidden" value="{if !empty($sProductPauseIds)}{$sProductPauseIds|escape:'htmlall':'UTF-8'}{/if}" id="hiddenProductPauseIds" name="hiddenProductPauseIds" />
					<input type="hidden" value="{if !empty($sProductPauseNames)}{$sProductPauseNames|escape:'htmlall':'UTF-8'}{/if}" id="hiddenProductPauseNames" name="hiddenProductFeedNames" />

                    <h5 class="mt-3 mb-2">{l s='Products to be paused:' mod='googlemerchantfeed'}</h5>
                    <div class="table-responsive">
                        <table id="bt_product-list-paused-products" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>{l s='Product(s)' mod='googlemerchantfeed'}</th>
                                    <th style="width: 10%;">{l s='Delete' mod='googlemerchantfeed'}</th>
                                </tr>
                            </thead>
                            <tbody id="bt_paused-products">
                                {if !empty($aProductsPaused)}
                                    {foreach name=product key=key item=aProduct from=$aProductsPaused}
                                        <tr>
                                            <td>{$aProduct.id|escape:'htmlall':'UTF-8'}{if isset($aProduct.attrId) && $aProduct.attrId != 0} (attr: {$aProduct.attrId|escape:'htmlall':'UTF-8'}){/if} - {$aProduct.name|escape:'htmlall':'UTF-8'}</td>
                                            <td>
                                                <a href="#" onclick="oGmcPro.deletePausedProduct('{$aProduct.stringIds|escape:'htmlall':'UTF-8'}'); return false;">
                                                    <i class="material-icons text-danger">delete</i>
                                                </a>
                                            </td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr id="bt_paused-products-no-products">
                                        <td colspan="2" class="text-center text-muted">{l s='No products' mod='googlemerchantfeed'}</td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                {/if}

                {* ========================================================= *}
                {* USE CASE - Taxes and shipping fees                        *}
                {* ========================================================= *}
                {if $sDisplay == 'tax'}
                    <ul class="nav nav-tabs mb-3" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#tax-tab" role="tab">
                                <i class="material-icons">attach_money</i> {l s='Tax management' mod='googlemerchantfeed'}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#shipping-tab" role="tab">
                                <i class="material-icons">local_shipping</i> {l s='Shipping cost management' mod='googlemerchantfeed'}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#free-shipping-tab" role="tab">
                                <i class="material-icons">card_giftcard</i> {l s='Free shipping management' mod='googlemerchantfeed'}
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane active" id="tax-tab">
                            <div class="form-group row mb-3">
                                <label class="col-md-4 form-control-label">
                                    <span class="label-tooltip" title="{l s='Select the feeds for which you want product prices to be displayed INCLUDING taxes' mod='googlemerchantfeed'}">
                                        <b>{l s='INCLUDE taxes in product prices for the following feeds:' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    {if !empty($aFeedTax)}
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>{l s='Language / country' mod='googlemerchantfeed'}</th>
                                                        <th class="text-center" style="width: 20%;">{l s='Include Tax' mod='googlemerchantfeed'}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {foreach from=$aFeedTax name=feed key=iKey item=aTax}
                                                        <tr>
                                                            <td>{$aTax.lang|escape:'htmlall':'UTF-8'} - {$aTax.country|escape:'htmlall':'UTF-8'}</td>
                                                            <td class="text-center">
                                                                <input type="hidden" name="bt_feed-tax-hidden[]" value="{$aTax.lang|lower|escape:'htmlall':'UTF-8'}_{$aTax.country|escape:'htmlall':'UTF-8'}" />
                                                                <input type="checkbox" name="bt_feed-tax[]" value="{$aTax.lang|lower|escape:'htmlall':'UTF-8'}_{$aTax.country|escape:'htmlall':'UTF-8'}" {if !empty($aTax.tax)}checked{/if} class="form-check-input" />
                                                            </td>
                                                        </tr>
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    {else}
                                        <div class="alert alert-warning">
                                            {l s='There are no files because no valid languages / currencies / countries are available according to Google\'s requirements.' mod='googlemerchantfeed'}
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="shipping-tab">
                            <div class="form-group row mb-3">
                                <label class="col-md-4 form-control-label"><b>{l s='Do you want the module to handle shipping fees?' mod='googlemerchantfeed'}</b></label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_manage-shipping" id="bt_manage-shipping_on" value="1" {if !empty($bShippingUse)}checked{/if} onchange="toggleShippingConfig(true);" />
                                        <label for="bt_manage-shipping_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_manage-shipping" id="bt_manage-shipping_off" value="0" {if empty($bShippingUse)}checked{/if} onchange="toggleShippingConfig(false);" />
                                        <label for="bt_manage-shipping_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                </div>
                            </div>

                            <div id="bt_conf-shipping" class="{if empty($bShippingUse)}d-none{/if}">
                                <div class="alert alert-info mb-3">
                                    <i class="material-icons">info</i>
                                    {l s='Please select below the corresponding default carrier for each country, check the box if you do not want to apply taxes on shipping costs or if you want to offer shipping costs.' mod='googlemerchantfeed'}
                                </div>

                                {if !empty($aShippingCarriers)}
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Carrier' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Free shipping if price >' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='No tax on shipping' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Free shipping' mod='googlemerchantfeed'}</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$aShippingCarriers name=shipping key=sCountry item=aShipping}
                                                    <tr>
                                                        <td class="text-center align-middle">{$sCountry|escape:'htmlall':'UTF-8'}</td>
                                                        <td class="text-center">
                                                            <select name="bt_ship-carriers[{$sCountry|escape:'htmlall':'UTF-8'}]" class="form-control form-control-sm">
                                                                {foreach from=$aShipping.carriers name=carrier key=iKey item=aCarrier}
                                                                    <option value="{$aCarrier.id_carrier|escape:'htmlall':'UTF-8'}" {if $aCarrier.id_carrier == $aShipping.shippingCarrierId}selected{/if}>
                                                                        {$aCarrier.name|escape:'htmlall':'UTF-8'}
                                                                    </option>
                                                                {/foreach}
                                                            </select>
                                                        </td>
                                                        <td class="text-center align-middle">
                                                            <input type="number" step="0.01" name="bt_ship-carriers_free_product_price[{$sCountry|escape:'htmlall':'UTF-8'}]" class="form-control form-control-sm" value="{$aShipping.productFree|escape:'htmlall':'UTF-8'}" placeholder="0.00" />
                                                        </td>
                                                        <td class="text-center align-middle">
                                                            <input type="checkbox" name="bt_ship-carriers_no_tax[{$sCountry|escape:'htmlall':'UTF-8'}]" {if !empty($aShipping.noTaxCarrier)}checked{/if} class="form-check-input" />
                                                        </td>
                                                        <td class="text-center align-middle">
                                                            <input type="checkbox" name="bt_ship-carriers_free[{$sCountry|escape:'htmlall':'UTF-8'}]" {if !empty($aShipping.free)}checked{/if} class="form-check-input" />
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                {else}
                                    <div class="alert alert-warning">
                                        {l s='There isn\'t any carrier available' mod='googlemerchantfeed'}
                                    </div>
                                {/if}
                            </div>
                        </div>

                        <div class="tab-pane" id="free-shipping-tab">
                            <div class="alert alert-info mb-3">
                                <i class="material-icons">info</i>
                                {l s='If you want to apply free shipping to certain products, regardless of the country of shipment, please use the options below.' mod='googlemerchantfeed'}
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-4 form-control-label">
                                    <span class="label-tooltip" title="{l s='If the price of the product (excluding taxes and discounts) is higher than this value, shipping will be free.' mod='googlemerchantfeed'}">
                                        <b>{l s='Apply free shipping if product price (excl. tax) is higher than:' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-2">
                                    <input type="number" step="0.01" name="bt_free_shipping_price" class="form-control" value="{if !empty($freeShippingPrice)}{$freeShippingPrice|floatval}{/if}" />
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-4 form-control-label">
                                    <b>{l s='Enter the products for which you want to offer free shipping:' mod='googlemerchantfeed'}</b>
                                </label>
                                <div class="col-md-6">
                                    <input type="text" id="bt_search-p-free-shipping" name="bt_search-p-free-shipping" class="form-control" placeholder="{l s='Start typing a product name' mod='googlemerchantfeed'}" />
                                </div>
                            </div>
<input type="hidden" value="{if !empty($sProductFreeShippingIds)}{$sProductFreeShippingIds|escape:'htmlall':'UTF-8'}{/if}" id="hiddenProductFreeShippingIds" name="hiddenProductFreeShippingIds" />
<input type="hidden" value="{if !empty($sProductFreeShippingNames)}{$sProductFreeShippingNames|escape:'htmlall':'UTF-8'}{/if}" id="hiddenProductFreeShippingNames" name="hiddenProductFeedNames" />                            <h5 class="mt-3 mb-2">{l s='Products with free shipping costs:' mod='googlemerchantfeed'}</h5>
                            <div class="table-responsive">
                                <table id="bt_product-list-free-shipping" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>{l s='Product(s)' mod='googlemerchantfeed'}</th>
                                            <th style="width: 10%;">{l s='Delete' mod='googlemerchantfeed'}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="bt_free-shipping-products">
                                        {if !empty($aProductsFreeShipping)}
                                            {foreach name=product key=key item=aProduct from=$aProductsFreeShipping}
                                                <tr>
                                                    <td>{$aProduct.id|escape:'htmlall':'UTF-8'}{if isset($aProduct.attrId) && $aProduct.attrId != 0} (attr: {$aProduct.attrId|escape:'htmlall':'UTF-8'}){/if} - {$aProduct.name|escape:'htmlall':'UTF-8'}</td>
                                                    <td>
                                                        <a href="#" onclick="oGmcPro.deleteProductFreeShipping('{$aProduct.stringIds|escape:'htmlall':'UTF-8'}'); return false;">
                                                            <i class="material-icons text-danger">delete</i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        {else}
                                            <tr id="bt_free-shipping-no-products">
                                                <td colspan="2" class="text-center text-muted">{l s='No products' mod='googlemerchantfeed'}</td>
                                            </tr>
                                        {/if}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                {/if}

            </div> {* End card-body *}

            <div class="card-footer text-right">
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

        // Helper functions to replace inline onclick clutter
        window.toggleExportMethod = function() {
            var val = $('#bt_export').val();
            if (val === '0') {
                $('#bt_categories').removeClass('d-none');
                $('#bt_brands').addClass('d-none');
            } else {
                $('#bt_categories').addClass('d-none');
                $('#bt_brands').removeClass('d-none');
            }
        };

        window.toggleOosOptions = function(show) {
            if (show) {
                $('#bt_div_product_oos').removeClass('d-none');
            } else {
                $('#bt_div_product_oos').addClass('d-none');
            }
        };

        window.toggleCombosOptions = function() {
            var val = $('#bt_prod-combos').val();
            if (val === '1') {
                $('#bt_prod-combos-opts').removeClass('d-none');
            } else {
                $('#bt_prod-combos-opts').addClass('d-none');
            }
        };

        window.toggleAdultLink = function(show) {
            if (show) {
                $('#tag_adult_link').removeClass('d-none');
            } else {
                $('#tag_adult_link').addClass('d-none');
            }
        };

        window.toggleApparelLink = function(id, show) {
            if (show) {
                $('#' + id).removeClass('d-none');
            } else {
                $('#' + id).addClass('d-none');
            }
        };

        window.toggleUnitPricing = function(show) {
            if (show) {
                $('#unit_pricing_measure_link').removeClass('d-none');
                $('#base_unit_price').removeClass('d-none');
                $('#bt_incl_unit_base_pricing_measure_off').prop('checked', true);
            } else {
                $('#unit_pricing_measure_link').addClass('d-none');
                $('#base_unit_price').addClass('d-none');
                $('#unit_base_pricing_measure_link').addClass('d-none');
            }
        };

        window.toggleShippingConfig = function(show) {
            if (show) {
                $('#bt_conf-shipping').removeClass('d-none');
            } else {
                $('#bt_conf-shipping').addClass('d-none');
            }
        };

        window.toggleSizeColorOptions = function(type, val) {
            if (type === 'size') {
                if (val === 'attribute' || val === 'both') {
                    $('#div_size_opt_attr').removeClass('d-none');
                } else {
                    $('#div_size_opt_attr').addClass('d-none');
                }
                if (val === 'feature' || val === 'both') {
                    $('#div_size_opt_feat').removeClass('d-none');
                } else {
                    $('#div_size_opt_feat').addClass('d-none');
                }
            } else if (type === 'color') {
                if (val === 'attribute' || val === 'both') {
                    $('#div_color_opt_attr').removeClass('d-none');
                } else {
                    $('#div_color_opt_attr').addClass('d-none');
                }
                if (val === 'feature' || val === 'both') {
                    $('#div_color_opt_feat').removeClass('d-none');
                } else {
                    $('#div_color_opt_feat').addClass('d-none');
                }
            }
        };

        // Initialize states on load
        toggleExportMethod();
        toggleOosOptions({/literal}{if !empty($bExportOOS)}true{else}false{/if}{literal});
        toggleCombosOptions();
        toggleAdultLink({/literal}{if !empty($bIncludeTagAdult)}true{else}false{/if}{literal});
        toggleShippingConfig({/literal}{if !empty($bShippingUse)}true{else}false{/if}{literal});
        toggleUnitPricing({/literal}{if !empty($bIncludeUnitpricingMeasure)}true{else}false{/if}{literal});
        toggleSizeColorOptions('size', '{/literal}{$sIncludeSize|escape:'htmlall':'UTF-8'}{literal}');
        toggleSizeColorOptions('color', '{/literal}{$sIncludeColor|escape:'htmlall':'UTF-8'}{literal}');

        // Autocomplete initialization
        {/literal}
        {if $sDisplay == 'tax'}
            {literal}
            oGmcPro.aParamsAutcomplete = {
                sInputSearch: '#bt_search-p-free-shipping',
                sExcludeNoProducts: '#bt_free-shipping-no-products',
                sExcludeProducts: '#bt_free-shipping-products',
                sHiddenProductNames: '#hiddenProductFreeShippingNames',
                sHiddenProductIds: '#hiddenProductFreeShippingIds'
            };
            oGmcPro.autocomplete('{/literal}{$sURI|escape:'javascript':'UTF-8'}&sAction={$aQueryParams.searchProduct.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.searchProduct.type|escape:'htmlall':'UTF-8'}{literal}', '#bt_search-p-free-shipping');
            {/literal}
        {/if}
        {literal}

        {/literal}
        {if $sDisplay == 'advanced'}
            {literal}
            oGmcPro.aParamsAutcomplete = {
                sInputSearch: '#bt_search-p-pause-tag',
                sExcludeNoProducts: '#bt_paused-products-no-products',
                sExcludeProducts: '#bt_paused-products',
                sHiddenProductNames: '#hiddenProductPauseNames',
                sHiddenProductIds: '#hiddenProductPauseIds'
            };
            oGmcPro.autocompletePausedProducts('{/literal}{$sURI|escape:'javascript':'UTF-8'}&sAction={$aQueryParams.searchSimpleProduct.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.searchSimpleProduct.type|escape:'htmlall':'UTF-8'}{literal}', '#bt_search-p-pause-tag');
            {/literal}
        {/if}
        {literal}
    });
</script>
{/literal}