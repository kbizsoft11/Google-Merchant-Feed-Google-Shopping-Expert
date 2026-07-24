{*
 * Google Shopping Export PRO - Google Taxonomy List
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

{if !empty($aErrors)}
    {include file="`$sErrorInclude`"}
{/if}

<div class="card mb-4">
    <div class="card-header">
        <i class="material-icons">category</i> {l s='Google Taxonomy Management' mod='googlemerchantfeed'}
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="thead-light">
                    <tr>
                        <th class="text-center" style="width: 15%;">{l s='Google taxonomy code' mod='googlemerchantfeed'}</th>
                        <th class="text-center" style="width: 15%;">{l s='Taxonomy file' mod='googlemerchantfeed'}</th>
                        <th class="text-center" style="width: 25%;">{l s='Concerned countries' mod='googlemerchantfeed'}</th>
                        <th class="text-center" style="width: 25%;">{l s='Match my categories' mod='googlemerchantfeed'}</th>
                        <th class="text-center" style="width: 20%;">{l s='Synchronise from Google' mod='googlemerchantfeed'}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$aCountryTaxonomies name=taxonomy key=sCode item=aTaxonomy}
                        <tr id="row_taxonomy_{$sCode|escape:'htmlall':'UTF-8'}">
                            {* Taxonomy Code *}
                            <td class="text-center align-middle">
                                <span class="badge badge-secondary font-weight-normal" style="font-size: 13px;">{$sCode|escape:'htmlall':'UTF-8'}</span>
                            </td>
                            
                            {* Taxonomy File Link *}
                            <td class="text-center align-middle">
                                <a class="btn btn-outline-primary btn-sm" target="_blank" href="https://www.google.com/basepages/producttype/taxonomy.{$sCode|escape:'htmlall':'UTF-8'}.txt" data-toggle="tooltip" title="{l s='View Taxonomy File' mod='googlemerchantfeed'}">
                                    <i class="material-icons" style="font-size: 18px;">description</i>
                                </a>
                            </td>
                            
                            {* Concerned Countries *}
                            <td class="text-center align-middle text-muted">
                                {$aTaxonomy.countryList|escape:'htmlall':'UTF-8'}
                            </td>
                            
                            {* Match Categories Action *}
                            <td class="text-center align-middle" id="gcupd_{$sCode|escape:'htmlall':'UTF-8'}">
                                {if !empty($aTaxonomy.updated)}
                                    <a href="{$taxonomyController|escape:'htmlall':'UTF-8'}&iLangId={$aTaxonomy.id_lang|escape:'htmlall':'UTF-8'}&sLangIso={$sCode|escape:'htmlall':'UTF-8'}" class="btn btn-primary btn-sm">
                                        <i class="material-icons" style="font-size: 18px; vertical-align: middle;">edit</i> 
                                        {l s='Match Categories' mod='googlemerchantfeed'}
                                    </a>
                                {else}
                                    <span class="badge badge-warning" data-toggle="tooltip" title="{l s='You must synchronise the taxonomy first' mod='googlemerchantfeed'}">
                                        <i class="material-icons" style="font-size: 16px; vertical-align: middle;">warning</i> 
                                        {l s='Please synchronise first' mod='googlemerchantfeed'}
                                    </span>
                                {/if}
                            </td>
                            
                            {* Synchronise Action *}
                            <td class="text-center align-middle">
                                <div class="d-flex justify-content-center align-items-center">
                                    <a class="btn btn-outline-secondary btn-sm mr-2" id="updateGoogleCategories" href="#" 
                                       onclick="$('#loadingGoogleCatListDiv').show(); oGmcPro.hide('bt_google-cat-list'); oGmcPro.ajax('{$sURI|escape:'htmlall':'UTF-8'}', '{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.googleCatSync.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.googleCatSync.type|escape:'htmlall':'UTF-8'}&iLangId={$aTaxonomy.id_lang|escape:'htmlall':'UTF-8'}&sLangIso={$sCode|escape:'htmlall':'UTF-8'}', 'bt_google-cat-list', 'bt_google-cat-list', null, null, 'loadingGoogleCatListDiv');"
                                       data-toggle="tooltip" title="{l s='Synchronise with Google' mod='googlemerchantfeed'}">
                                        <i class="material-icons" style="font-size: 18px;">sync</i>
                                    </a>
                                    
                                    {if !empty($aTaxonomy.currentUpdated)}
                                        <i class="material-icons text-success" style="font-size: 24px;" data-toggle="tooltip" title="{l s='Synchronised' mod='googlemerchantfeed'}">check_circle</i>
                                    {/if}
                                </div>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>

{* Loading Indicator (Kept for your existing JS logic) *}
<div id="loadingGoogleCatListDiv" class="d-none">
    <div class="card mb-4">
        <div class="card-body text-center py-5">
            <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
                <span class="sr-only">{l s='Loading...' mod='googlemerchantfeed'}</span>
            </div>
            <p class="mt-3 text-muted">{l s='Synchronising with Google, please wait...' mod='googlemerchantfeed'}</p>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        // Initialize tooltips for the new icon buttons
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>