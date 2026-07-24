{*
 * Google Shopping Export PRO - Advanced Settings (Promo & Reviews)
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

<script type="text/javascript">
    {literal}
    var oDiscountSettingsCallBack = [{}];
    {/literal}
</script>

<div class="bootstrap">
    <form class="form" method="post" id="bt_advanced-{$sDisplay|escape:'htmlall':'UTF-8'}-form" name="bt_advanced-{$sDisplay|escape:'htmlall':'UTF-8'}-form" 
        {if $useJs}onsubmit="javascript: oGmcPro.form('bt_advanced-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, oDiscountSettingsCallBack, 'Advanced', 'loadingAdvancedDiv'); return false;"{/if}>
        
        <input type="hidden" name="sAction" value="{$aQueryParams.advancedfeed.action|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sType" value="{$aQueryParams.advancedfeed.type|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sDisplay" id="sAdvancedFeedDisplay" value="{if !empty($sDisplay)}{$sDisplay|escape:'htmlall':'UTF-8'}{else}promo{/if}" />

        <div class="card mb-4">
            <div class="card-body">
                {* USE CASE - ADVANCED PROMO *}
                {if $sDisplay == 'promo'}
                    <ul class="nav nav-tabs mb-3" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link {if empty($aDiscountAvailable)}active{/if}" data-toggle="tab" href="#conf" role="tab">
                                <i class="material-icons">settings</i> {l s='Cart rules management for Special offers data feed' mod='googlemerchantfeed'}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link {if !empty($aDiscountAvailable)}active{/if}" data-toggle="tab" href="#list" role="tab">
                                <i class="material-icons">list</i> {l s='List of cart rules exported' mod='googlemerchantfeed'}
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane {if empty($aDiscountAvailable)}active{/if}" id="conf">
                            {if !empty($bUpdate)}
                                {include file="`$sConfirmInclude`"}
                            {elseif !empty($aErrors)}
                                {include file="`$sErrorInclude`"}
                            {/if}

                            <div class="alert alert-info mb-3">
                                <i class="material-icons">info</i>
                                <strong>{l s='Google allows you to distribute online special offers with your Product Shopping ads on Google.com and Google Shopping, without additional cost. When you add special offers to products that you sell on Google.' mod='googlemerchantfeed'}</strong>
                                <br><br>
                                <i class="material-icons text-warning">warning</i>
                                {l s='Please also see Google important note about' mod='googlemerchantfeed'}&nbsp;
                                <a id="editorial" target="_blank" href="https://support.google.com/merchants/answer/2877578?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}" class="alert-link">
                                    {l s='editorial requirements for your cart rules' mod='googlemerchantfeed'}
                                </a>.
                                <br><br>
                                {l s='Filters below will help you to configure which cart rules will be exported in your data feed.' mod='googlemerchantfeed'}
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label"></label>
                                <div class="col-md-6" id="gmcp_bulk_filter">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.openAllFitler('check');">
                                        <i class="material-icons">check_box</i> {l s='Activate all' mod='googlemerchantfeed'}
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.openAllFitler('uncheck');">
                                        <i class="material-icons">indeterminate_check_box</i> {l s='Deactivate all' mod='googlemerchantfeed'}
                                    </button>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "Yes" to export only cart rules that contain certain keywords in their names.' mod='googlemerchantfeed'}">
                                        <b>{l s='Filter by cart rule name :' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_option-name" id="bt_option-name_on" value="true" {if $bFilterName == 'true'}checked{/if} onchange="toggleDiscountFilter('name', true);" />
                                        <label for="bt_option-name_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_option-name" id="bt_option-name_off" value="false" {if $bFilterName != 'true'}checked{/if} onchange="toggleDiscountFilter('name', false);" />
                                        <label for="bt_option-name_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                    <div id="bt_discount-name-group" class="mt-2 {if $bFilterName != 'true'}d-none{/if}">
                                        <input type="text" id="bt_discount-name" name="bt_discount-name" class="form-control" value="{$sDiscountName|escape:'htmlall':'UTF-8'}" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "YES" to only export special offers whose validity period is between two specific dates.' mod='googlemerchantfeed'}">
                                        <b>{l s='Filter by validity dates :' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_option-date" id="bt_option-date_on" value="true" {if $bFilterDate == 'true'}checked{/if} onchange="toggleDiscountFilter('date', true);" />
                                        <label for="bt_option-date_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_option-date" id="bt_option-date_off" value="false" {if $bFilterDate != 'true'}checked{/if} onchange="toggleDiscountFilter('date', false);" />
                                        <label for="bt_option-date_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                    <div id="bt_date-group" class="mt-2 {if $bFilterDate != 'true'}d-none{/if}">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">{l s='From' mod='googlemerchantfeed'}</span>
                                            </div>
                                            <input type="text" name="bt_discount-date-from" id="bt_discount-date-from" class="form-control date-picker" value="{$sDiscountDateFrom|escape:'htmlall':'UTF-8'}" />
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">{l s='To' mod='googlemerchantfeed'}</span>
                                            </div>
                                            <input type="text" name="bt_discount-date-to" id="bt_discount-date-to" class="form-control date-picker" value="{$sDiscountDateTo|escape:'htmlall':'UTF-8'}" />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row mb-3" id="gmcp_min_amount_filter">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "YES" to only export special offers that require a minimum amount of purchase.' mod='googlemerchantfeed'}">
                                        <b>{l s='Filter by minimum purchase :' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_option-min-amount" id="bt_option-min-amount_on" value="true" {if $bFilterMinAmount == 'true'}checked{/if} onchange="toggleDiscountFilter('min-amount', true);" />
                                        <label for="bt_option-min-amount_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_option-min-amount" id="bt_option-min-amount_off" value="false" {if $bFilterMinAmount != 'true'}checked{/if} onchange="toggleDiscountFilter('min-amount', false);" />
                                        <label for="bt_option-min-amount_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                    <div id="bt_min-amount-group" class="mt-2 {if $bFilterMinAmount != 'true'}d-none{/if}">
                                        <input type="number" step="0.01" name="bt_discount-min-amount" id="bt_discount-min-amount" class="form-control" value="{$sDiscountMinAmount|escape:'htmlall':'UTF-8'}" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row mb-3" id="gmcp_reduction_amount_filter">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "YES" to only export special offers whose amount (or percentage) is between two specific values.' mod='googlemerchantfeed'}">
                                        <b>{l s='Filter by voucher amount :' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <span class="switch switch-primary">
                                        <input type="radio" name="bt_option-value" id="bt_option-value_on" value="true" {if $bFilterValue == 'true'}checked{/if} onchange="toggleDiscountFilter('value', true);" />
                                        <label for="bt_option-value_on">{l s='Yes' mod='googlemerchantfeed'}</label>
                                        <input type="radio" name="bt_option-value" id="bt_option-value_off" value="false" {if $bFilterValue != 'true'}checked{/if} onchange="toggleDiscountFilter('value', false);" />
                                        <label for="bt_option-value_off">{l s='No' mod='googlemerchantfeed'}</label>
                                        <a class="slide-button btn"></a>
                                    </span>
                                    <div id="bt_value-group" class="mt-2 {if $bFilterValue != 'true'}d-none{/if} row">
                                        <div class="col-md-4 mb-2">
                                            <input type="number" step="0.01" placeholder="{l s='Min' mod='googlemerchantfeed'}" name="bt_discount-value-min" id="bt_discount-value-min" class="form-control" value="{$sDiscountValueMin|escape:'htmlall':'UTF-8'}" />
                                        </div>
                                        <div class="col-md-4 mb-2">
                                            <input type="number" step="0.01" placeholder="{l s='Max' mod='googlemerchantfeed'}" name="bt_discount-value-max" id="bt_discount-value-max" class="form-control" value="{$sDiscountValueMax|escape:'htmlall':'UTF-8'}" />
                                        </div>
                                        <div class="col-md-4 mb-2">
                                            <select name="bt_discount-type" id="bt_discount-type" class="form-control">
                                                <option value="all" {if $bDiscountType == 'all'}selected{/if}>{l s='Percentage and amount' mod='googlemerchantfeed'}</option>
                                                <option value="percent" {if $bDiscountType == 'percent'}selected{/if}>{l s='Only percent' mod='googlemerchantfeed'}</option>
                                                <option value="amount" {if $bDiscountType == 'amount'}selected{/if}>{l s='Only amount' mod='googlemerchantfeed'}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row mb-3" id="gmcp_cumulable_filter">
                                <label class="col-md-3 form-control-label">
                                    <span class="label-tooltip" data-toggle="tooltip" title="{l s='Select "No filter" to export voucher codes regardless their cumulation setting.' mod='googlemerchantfeed'}">
                                        <b>{l s='Filter on cumulation settings :' mod='googlemerchantfeed'}</b>
                                    </span>
                                </label>
                                <div class="col-md-6">
                                    <select name="bt_discount-cumulable" id="bt_discount-cumulable" class="form-control">
                                        <option value="all" {if $sDiscountCumulable == 'all'}selected{/if}>{l s='No filter' mod='googlemerchantfeed'}</option>
                                        <option value="cumulated" {if $sDiscountCumulable == 'cumulated'}selected{/if}>{l s='Only cumulable codes' mod='googlemerchantfeed'}</option>
                                        <option value="nocumulated" {if $sDiscountCumulable == 'nocumulated'}selected{/if}>{l s='Only NOT cumulable codes' mod='googlemerchantfeed'}</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row mb-3">
                                <div class="col-md-9 offset-md-3">
                                    <div id="{$sModuleName|escape:'htmlall':'UTF-8'}Feed{$sDisplay|escape:'htmlall':'UTF-8'}Error"></div>
                                </div>
                                <div class="col-md-9 offset-md-3">
                                    <button type="button" class="btn btn-success btn-lg" onclick="oGmcPro.form('bt_advanced-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, oDiscountSettingsCallBack, 'Advanced', 'loadingAdvancedDiv'); return false;">
                                        <i class="material-icons">search</i> {l s='Search' mod='googlemerchantfeed'}
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane {if !empty($aDiscountAvailable)}active{/if}" id="list">
                            {if !empty($aDiscountAvailable)}
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="text-center">{l s='Name' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Details' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Code' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Channel' mod='googlemerchantfeed'}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$aDiscountAvailable key=key item=discount}
                                                <tr>
                                                    <td class="text-center align-middle">{$discount.name|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center align-middle">
                                                        <button type="button" class="btn btn-info btn-sm" onclick="$('#{$sModuleName|escape:'htmlall':'UTF-8'}DiscountDetail{$key@iteration}').slideToggle(300);">
                                                            <i class="material-icons">zoom_in</i>
                                                        </button>
                                                    </td>
                                                    <td class="text-center align-middle">{$discount.code|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="align-middle">
                                                        <select name="bt-discount_channel[{$discount.id_cart_rule|escape:'htmlall':'UTF-8'}][]" class="form-control form-control-sm" multiple>
                                                            {foreach from=$aDiscountChannel key=chanKey item=sChannel}
                                                                <option value="{$sChannel|escape:'htmlall':'UTF-8'}" {if !empty($aPromotionDestination[$discount.id_cart_rule]) && in_array($sChannel, $aPromotionDestination[$discount.id_cart_rule])}selected{/if}>
                                                                    {l s=$sChannel mod='googlemerchantfeed'}
                                                                </option>
                                                            {/foreach}
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr id="{$sModuleName|escape:'htmlall':'UTF-8'}DiscountDetail{$key@iteration}" class="d-none promoDetails">
                                                    <td colspan="4" class="bg-light p-3">
                                                        <div class="row">
                                                            <div class="col-md-6"><strong>{l s='Cart rule ID' mod='googlemerchantfeed'}:</strong> {$discount.id_cart_rule|escape:'htmlall':'UTF-8'}</div>
                                                            <div class="col-md-6"><strong>{l s='Valid from' mod='googlemerchantfeed'}:</strong> {$discount.date_from|escape:'htmlall':'UTF-8'} <strong>{l s='to' mod='googlemerchantfeed'}:</strong> {$discount.date_to|escape:'htmlall':'UTF-8'}</div>
                                                        </div>
                                                        <div class="row mt-2">
                                                            <div class="col-md-6"><strong>{l s='Creation date' mod='googlemerchantfeed'}:</strong> {$discount.date_add|escape:'htmlall':'UTF-8'}</div>
                                                            <div class="col-md-6"><strong>{l s='Updating date' mod='googlemerchantfeed'}:</strong> {$discount.date_upd|escape:'htmlall':'UTF-8'}</div>
                                                        </div>
                                                        {if !empty($discount.description)}
                                                            <div class="row mt-2">
                                                                <div class="col-12">
                                                                    <strong>{l s='Description' mod='googlemerchantfeed'}:</strong>
                                                                    <hr>
                                                                    <p class="text-muted">{$discount.description|escape:'htmlall':'UTF-8'}</p>
                                                                </div>
                                                            </div>
                                                        {/if}
                                                        <div class="row mt-2">
                                                            <div class="col-md-6"><strong>{l s='Quantity' mod='googlemerchantfeed'}:</strong> {$discount.quantity|escape:'htmlall':'UTF-8'}</div>
                                                            <div class="col-md-6"><strong>{l s='Quantity per user' mod='googlemerchantfeed'}:</strong> {$discount.quantity_per_user|escape:'htmlall':'UTF-8'}</div>
                                                        </div>
                                                        <div class="row mt-2">
                                                            <div class="col-md-6"><strong>{l s='Priority' mod='googlemerchantfeed'}:</strong> {$discount.priority|escape:'htmlall':'UTF-8'}</div>
                                                            <div class="col-md-6">
                                                                <strong>{l s='Partial use' mod='googlemerchantfeed'}:</strong>
                                                                {if $discount.partial_use == 1}<i class="material-icons text-success">check_circle</i>{else}<i class="material-icons text-danger">cancel</i>{/if}
                                                            </div>
                                                        </div>
                                                        {if $discount.minimum_amount != 0}
                                                            <div class="row mt-2">
                                                                <div class="col-md-6"><strong>{l s='Minimal amount' mod='googlemerchantfeed'}:</strong> {$discount.minimum_amount|escape:'htmlall':'UTF-8'}</div>
                                                            </div>
                                                        {/if}
                                                        {if $discount.reduction_percent != 0}
                                                            <div class="row mt-2">
                                                                <div class="col-md-6"><strong>{l s='Reduction' mod='googlemerchantfeed'}:</strong> {$discount.reduction_percent|escape:'htmlall':'UTF-8'} %</div>
                                                            </div>
                                                        {/if}
                                                        {if $discount.reduction_amount != 0}
                                                            <div class="row mt-2">
                                                                <div class="col-md-6"><strong>{l s='Reduction' mod='googlemerchantfeed'}:</strong> {$discount.reduction_amount|escape:'htmlall':'UTF-8'}</div>
                                                            </div>
                                                        {/if}
                                                        <div class="row mt-2">
                                                            <div class="col-md-6">
                                                                <strong>{l s='Restriction to certain products' mod='googlemerchantfeed'}:</strong>
                                                                {if $discount.product_restriction == 1}<i class="material-icons text-success">check_circle</i>{else}<i class="material-icons text-danger">cancel</i>{/if}
                                                            </div>
                                                            <div class="col-md-6">
                                                                <strong>{l s='Cumulable' mod='googlemerchantfeed'}:</strong>
                                                                {if $discount.cart_rule_restriction == 0}<i class="material-icons text-success">check_circle</i>{else}<i class="material-icons text-danger">cancel</i>{/if}
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            {else}
                                <div class="alert alert-warning">
                                    <i class="material-icons">warning</i> {l s='No cart rule available for the selected filters...' mod='googlemerchantfeed'}
                                </div>
                            {/if}
                        </div>
                    </div>
                {/if}
                {* END - ADVANCED PROMO *}

                {* START - USE CASE REVIEW FEED CONFIGURATION *}
                {if $sDisplay == 'reviews'}
                    <h3 class="subtitle"><i class="material-icons">star</i> {l s='Product ratings data feed' mod='googlemerchantfeed'}</h3>
                    
                    {if !empty($bUpdate)}
                        {include file="`$sConfirmInclude`"}
                    {elseif !empty($aErrors)}
                        {include file="`$sErrorInclude`"}
                    {/if}

                    <div class="alert alert-info mb-3">
                        <i class="material-icons">info</i>
                        <strong>{l s='This feature is only available with our "Shop Product Reviews" module or with the native PrestaShop\'s review module.' mod='googlemerchantfeed'}</strong>
                    </div>

                    {if !empty($bGsnippetsReviews)}
                        <div class="alert alert-success mb-3">
                            <i class="material-icons">check_circle</i> {l s='The kbizsoft "Shop Product Reviews" module is installed. You can therefore use this feature!' mod='googlemerchantfeed'}
                        </div>
                    {elseif !empty($bProductComment)}
                        <div class="alert alert-success mb-3">
                            <i class="material-icons">check_circle</i> {l s='The native PrestaShop\'s review module is installed. You can therefore use this feature!' mod='googlemerchantfeed'}
                        </div>
                    {else}
                        <div class="alert alert-danger mb-3">
                            <i class="material-icons">error</i> {l s='No product review module compatible with Google Shopping Export PRO is installed... Please install either the native PrestaShop\'s review module or our "Shop Product Reviews" module, to be able to use this feature.' mod='googlemerchantfeed'}
                        </div>
                    {/if}

                    <h4 class="mt-4 mb-3">{l s='How to use product ratings data feed in Google Shopping' mod='googlemerchantfeed'}</h4>
                    <ol class="list-group list-group-numbered mb-4">
                        <li class="list-group-item">
                            {l s='Sign up for Google Product Ratings program by' mod='googlemerchantfeed'}
                            <b><a target="_blank" href="https://support.google.com/merchants/answer/7050198?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}" class="alert-link">{l s='clicking here' mod='googlemerchantfeed'}</a></b>
                        </li>
                        <li class="list-group-item">{l s='On the left menu go to "My feeds" tab -> "Product ratings data feed" to copy the URL of your product ratings data feed matching with your targeted "langage-country" pair.' mod='googlemerchantfeed'}</li>
                        <li class="list-group-item">{l s='Create a product ratings feed in your online Google Merchant Center interface, by using the URL you\'ve just copied.' mod='googlemerchantfeed'}</li>
                    </ol>

                    <h4 class="mt-4 mb-3">{l s='Reviews exclusion tool' mod='googlemerchantfeed'}</h4>
                    <div class="alert alert-info mb-3">
                        <i class="material-icons">info</i>
                        {l s='In rare cases, Google may refuse your review feed because one or several reviews contain words that are prohibited (according to Google). In this case, we offer you to indicate below the forbidden words in order NOT to export these specific reviews and to export all the others.' mod='googlemerchantfeed'}
                        <br><br>
                        {l s='Write the forbidden words by using coma as separator (ex: word1,word2,word3).' mod='googlemerchantfeed'}&nbsp;
                        <strong>{l s='DO NOT' mod='googlemerchantfeed'}</strong>&nbsp;{l s='use spaces between words.' mod='googlemerchantfeed'}
                    </div>

                    <div class="form-group row mb-3">
                        <label class="col-md-3 form-control-label">
                            <span class="label-tooltip" data-toggle="tooltip" title="{l s='Write the forbidden words using coma as separator. DO NOT use spaces between words. Example : word1,word2,word3' mod='googlemerchantfeed'}">
                                <b>{l s='Forbidden words:' mod='googlemerchantfeed'}</b>
                            </span>
                        </label>
                        <div class="col-md-6">
                            <textarea name="bt_words-review-forbidden" class="form-control" rows="5">{if !empty($sForbiddenWords)}{$sForbiddenWords|escape:'htmlall':'UTF-8'}{/if}</textarea>
                        </div>
                    </div>

                    <div class="form-group row mb-3">
                        <div class="col-md-9 offset-md-3">
                            <div id="{$sModuleName|escape:'htmlall':'UTF-8'}Feed{$sDisplay|escape:'htmlall':'UTF-8'}Error"></div>
                        </div>
                        <div class="col-md-9 offset-md-3">
                            <button type="button" class="btn btn-success btn-lg" onclick="oGmcPro.form('bt_advanced-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt_advanced-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, oDiscountSettingsCallBack, 'Advanced', 'loadingAdvancedDiv'); return false;">
                                <i class="material-icons">add</i> {l s='Add' mod='googlemerchantfeed'}
                            </button>
                        </div>
                    </div>
                {/if}
                {* END - REVIEW FEED CONFIGURATION *}

                <div id="{$sModuleName|escape:'htmlall':'UTF-8'}AdvancedError"></div>
            </div> {* End card-body *}
            
            {if $sDisplay == 'promo'}
            <div class="card-footer text-right">
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="material-icons">save</i> {l s='Save' mod='googlemerchantfeed'}
                </button>
            </div>
            {/if}
        </div> {* End card *}
    </form>
</div>

{literal}
<script type="text/javascript">
    $(document).ready(function() {
        // Initialize tooltips
        $('.label-tooltip').tooltip();

        // Helper function to toggle discount filters
        window.toggleDiscountFilter = function(type, show) {
            if (type === 'name') {
                if (show) {
                    $('#bt_discount-name-group').removeClass('d-none');
                } else {
                    $('#bt_discount-name-group').addClass('d-none');
                    $('#bt_discount-name').val('');
                }
            } else if (type === 'date') {
                if (show) {
                    $('#bt_date-group').removeClass('d-none');
                } else {
                    $('#bt_date-group').addClass('d-none');
                    $('#bt_discount-date-from').val('');
                    $('#bt_discount-date-to').val('');
                }
            } else if (type === 'min-amount') {
                if (show) {
                    $('#bt_min-amount-group').removeClass('d-none');
                } else {
                    $('#bt_min-amount-group').addClass('d-none');
                    $('#bt_discount-min-amount').val('');
                }
            } else if (type === 'value') {
                if (show) {
                    $('#bt_value-group').removeClass('d-none');
                } else {
                    $('#bt_value-group').addClass('d-none');
                    $('#bt_discount-value-min').val('');
                    $('#bt_discount-value-max').val('');
                }
            }
        };

        // Initialize date pickers
        $(".date-picker").datepicker({
            dateFormat: 'yy-mm-dd'
        });

        // Initialize states on load based on current radio values
        toggleDiscountFilter('name', $('input[name="bt_option-name"]:checked').val() === 'true');
        toggleDiscountFilter('date', $('input[name="bt_option-date"]:checked').val() === 'true');
        toggleDiscountFilter('min-amount', $('input[name="bt_option-min-amount"]:checked').val() === 'true');
        toggleDiscountFilter('value', $('input[name="bt_option-value"]:checked').val() === 'true');
    });
</script>
{/literal}