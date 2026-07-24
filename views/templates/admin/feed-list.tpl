{*
 * Google Shopping Export PRO - My Feeds List
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

{if !empty($aErrors)}
    {include file="`$sErrorInclude`"}
{/if}

<div class="bootstrap" id="gmcp">
    <form class="form" method="post" id="bt_feedlist-{$sDisplay|escape:'htmlall':'UTF-8'}-form" name="bt_feedlist-{$sDisplay|escape:'htmlall':'UTF-8'}-form" 
        {if $useJs}onsubmit="javascript: oGmcPro.form('bt_feedlist-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_feed-list-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt_feed-list-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, null, 'FeedList{$sDisplay|escape:'htmlall':'UTF-8'}', 'loadingFeedListDiv'); return false;"{/if}>
        
        <input type="hidden" name="sAction" value="{$aQueryParams.feedListUpdate.action|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sType" value="{$aQueryParams.feedListUpdate.type|escape:'htmlall':'UTF-8'}" />
        <input type="hidden" name="sDisplay" id="sFeedListDisplay" value="{if !empty($sDisplay)}{$sDisplay|escape:'htmlall':'UTF-8'}{else}data{/if}" />

        {* ========================================================= *}
        {* BEGIN - Classic Product Data Feed                         *}
        {* ========================================================= *}
        {if !empty($sDisplay) && $sDisplay == 'data'}
            <h3 class="subtitle mb-3"><i class="material-icons">description</i> {l s='Products data feed' mod='googlemerchantfeed'}</h3>
            
            {if !empty($bUpdate)}
                {include file="`$sConfirmInclude`"}
            {elseif !empty($aErrors)}
                {include file="`$sErrorInclude`"}
            {/if}

            {if !empty($sGmcLink)}
                {if !empty($iTotalProductToExport)}
                    {literal}
                        <script type="text/javascript">
                            var aDataFeedGenOptions = {
                                'sURI' : '{/literal}{$sURI|escape:'javascript':'UTF-8'}{literal}',
                                'sParams' : '{/literal}{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.dataFeed.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.dataFeed.type|escape:'htmlall':'UTF-8'}{literal}',
                                'iShopId' : {/literal}{$iShopId|escape:'htmlall':'UTF-8'}{literal},
                                'sFilename': '',
                                'iLangId': 0,
                                'sLangIso': '',
                                'sCountryIso': '',
                                'sCurrencyIso': '',
                                'iStep': 0,
                                'iTotal' : {/literal}{$iTotalProductToExport|escape:'htmlall':'UTF-8'}{literal},
                                'iProcess': 0,
                                'sDisplayedCounter': '#regen_counter',
                                'sDisplayedBlock': '#syncCounterDiv',
                                'sDisplaySuccess': '#regen_xml',
                                'sDisplayTotal': '#total_product_processed',
                                'sLoaderBar': 'myBar',
                                'sErrorContainer': 'AjaxFeed',
                                'bReporting': 1,
                                'sFeedType': 'product',
                                'sDisplayReporting': '#handleGenerateReportingBox',
                                'sResultText' : '{/literal}{l s='product(s) exported' mod='googlemerchantfeed'}{literal}',
                                'bExcludedProduct' : '{/literal}{$bExcludedProduct|escape:'htmlall':'UTF-8'}{literal}'
                            };
                        </script>
                    {/literal}

                    {if !empty($aFeedFileListProduct)}
                        <div class="row mb-4">
                            <div class="col-md-6 mb-3">
                                <div class="card h-100 border-primary">
                                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                                        <span><i class="material-icons" style="vertical-align: middle;">flash_on</i> {l s='ON THE FLY OUTPUT' mod='googlemerchantfeed'}</span>
                                        {if $iTotalProduct <= 30000}
                                            <span class="badge badge-light">{l s='Recommended' mod='googlemerchantfeed'}</span>
                                        {/if}
                                    </div>
                                    <div class="card-body text-center">
                                        <p class="card-text text-muted">{l s='This export method is recommended for catalogs with less than about 30000 products' mod='googlemerchantfeed'}</p>
                                        <button type="button" id="btn-fly-product" class="btn btn-primary btn-lg mt-2">
                                            {l s='Use this solution' mod='googlemerchantfeed'}
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="card h-100 border-success">
                                    <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                                        <span><i class="material-icons" style="vertical-align: middle;">schedule</i> {l s='XML + CRON' mod='googlemerchantfeed'}</span>
                                        {if $iTotalProduct > 30000}
                                            <span class="badge badge-light">{l s='Recommended' mod='googlemerchantfeed'}</span>
                                        {/if}
                                    </div>
                                    <div class="card-body text-center">
                                        <p class="card-text text-muted">{l s='This export method is recommended for catalogs with more than about 30000 products' mod='googlemerchantfeed'}</p>
                                        <button type="button" id="btn-xml-product" class="btn btn-success btn-lg mt-2">
                                            {l s='Use this solution' mod='googlemerchantfeed'}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {* XML + CRON Section *}
                        <div class="bt-fb-cron-product" style="display: none;">
                            <ul class="nav nav-tabs mb-3" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#xml" role="tab">
                                        <i class="material-icons">folder</i> {l s='Your XML files' mod='googlemerchantfeed'}
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#cron" role="tab">
                                        <i class="material-icons">schedule</i> {l s='Your CRON URL\'s' mod='googlemerchantfeed'}
                                    </a>
                                </li>
                            </ul>

                            <div class="tab-content">
                                {* Tab 1: XML Files *}
                                <div class="tab-pane fade show active" id="xml" role="tabpanel">
                                    <div id="syncCounterDiv" style="display: none;" class="alert alert-success">
                                        <button type="button" class="close" onclick="$('#syncCounterDiv').hide();">×</button>
                                        <div class="row mb-3 h3">
                                            {l s='Export in progress' mod='googlemerchantfeed'}
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <b>{l s='Number of products exported:' mod='googlemerchantfeed'}</b>&nbsp;
                                            <input size="5" name="bt_regen-counter" id="regen_counter" value="0" disabled />&nbsp;
                                            {l s='on' mod='googlemerchantfeed'}&nbsp;{$iTotalProduct|escape:'htmlall':'UTF-8'} ({l s='total of products on the shop' mod='googlemerchantfeed'})
                                        </div>
                                        <div class="row mt-2">
                                            <div class="progress col-xs-12" style="height: 20px;">
                                                <div class="progress-bar bg-success progress-bar-striped active" id="myBar" role="progressbar" style="width: 0%"></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div id="{$sModuleName|escape:'htmlall':'UTF-8'}AjaxFeedError"></div>
                                        </div>
                                        <div class="clr_20"></div>
                                    </div>

                                    <div class="alert alert-info mb-3">
                                        <i class="material-icons">info</i>
                                        <strong>{l s='Here are the XML files that will receive your feed data every time the CRON task will be executed.' mod='googlemerchantfeed'}</strong>
                                        <ul class="mb-0 mt-2">
                                            <li>{l s='If you want to use a general CRON task to update several XML files at the same time, check first the relevant files below. Then,' mod='googlemerchantfeed'} <strong>{l s='SAVE YOUR SELECTION' mod='googlemerchantfeed'}</strong> {l s='and set up your CRON task by using the general CRON URL that appears in "Your CRON URL\'s" tab.' mod='googlemerchantfeed'}</li>
                                            <li>{l s='If you want to set up a different CRON task for each feed in order to update them one by one, do not check any file and use the independent CRON URL\'s that are in "Your CRON URL\'s" tab.' mod='googlemerchantfeed'}</li>
                                        </ul>
                                    </div>

                                    <div class="d-flex justify-content-end mb-3">
                                        <button type="button" class="btn btn-outline-secondary btn-sm mr-2" onclick="return oGmcPro.selectAll('input.bt_export_feed', 'check');">
                                            <i class="material-icons">check_box</i> {l s='Check All' mod='googlemerchantfeed'}
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="return oGmcPro.selectAll('input.bt_export_feed', 'uncheck');">
                                            <i class="material-icons">indeterminate_check_box</i> {l s='Uncheck All' mod='googlemerchantfeed'}
                                        </button>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead class="thead-light">
                                                <tr>
                                                    <th class="text-center" style="width: 5%;">{l s='Regenerate during CRON' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Language' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Taxonomy' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Currency' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center">{l s='Last update' mod='googlemerchantfeed'}</th>
                                                    <th class="text-center" style="width: 25%;">{l s='Action' mod='googlemerchantfeed'}</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$aFeedFileListProduct name=feed key=iKey item=aFeed}
                                                    <tr id="regen_xml_{$aFeed.lang|lower|escape:'htmlall':'UTF-8'}_{$aFeed.country|lower|escape:'htmlall':'UTF-8'}">
                                                        <td class="text-center align-middle">
                                                            <input type="checkbox" class="bt_export_feed form-check-input" name="bt_cron-export[]" value="{$aFeed.lang|lower|escape:'htmlall':'UTF-8'}_{$aFeed.country|escape:'htmlall':'UTF-8'}_{$aFeed.currencyIso|escape:'htmlall':'UTF-8'}" {if !empty($aFeed.checked)}checked{/if} />
                                                        </td>
                                                        <td class="text-center align-middle">{$aFeed.countryName|escape:'htmlall':'UTF-8'} - {$aFeed.country|escape:'htmlall':'UTF-8'}</td>
                                                        <td class="text-center align-middle">
                                                            {$aFeed.langName|escape:'htmlall':'UTF-8'}
                                                            {if empty($aFeed.is_default)}
                                                                <span class="badge badge-info ml-1">{l s='Custom feed' mod='googlemerchantfeed'}</span>
                                                            {/if}
                                                        </td>
                                                        <td class="text-center align-middle">{$aFeed.taxonomy|escape:'htmlall':'UTF-8'}</td>
                                                        <td class="text-center align-middle">{$aFeed.currencySign|escape:'htmlall':'UTF-8'} - {$aFeed.currencyIso|escape:'htmlall':'UTF-8'}</td>
                                                        <td class="text-center align-middle text-muted">{$aFeed.filemtime|escape:'htmlall':'UTF-8'}</td>
                                                        <td class="text-center align-middle">
                                                            <div class="btn-group" role="group">
                                                                <a class="btn btn-sm btn-outline-primary label-tooltip" title="{l s='Generate' mod='googlemerchantfeed'}" href="javascript:void(0);" class="regenXML"
                                                                    onclick="if (oGmcPro.bGenerateXmlFlag){literal}{{/literal}alert('{l s='Your data feed is being created...' mod='googlemerchantfeed'}'); return false;{literal}}{/literal}aDataFeedGenOptions.sLangIso='{$aFeed.lang|lower|escape:'htmlall':'UTF-8'}';aDataFeedGenOptions.sCountryIso='{$aFeed.country|lower|escape:'htmlall':'UTF-8'}';aDataFeedGenOptions.sCurrencyIso='{$aFeed.currencyIso|escape:'htmlall':'UTF-8'}';aDataFeedGenOptions.iLangId='{$aFeed.langId|escape:'htmlall':'UTF-8'}';aDataFeedGenOptions.sFilename='{$aFeed.filename|escape:'htmlall':'UTF-8'}';aDataFeedGenOptions.sFeedType='product';$('#syncCounterDiv').show();oGmcPro.generateDataFeed(aDataFeedGenOptions);">
                                                                    <i class="material-icons" style="font-size: 18px;">sync</i>
                                                                </a>
                                                                <a class="btn btn-sm btn-outline-info label-tooltip" title="{l s='See' mod='googlemerchantfeed'}" target="_blank" href="{$aFeed.link|escape:'htmlall':'UTF-8'}">
                                                                    <i class="material-icons" style="font-size: 18px;">visibility</i>
                                                                </a>
                                                                <a type="button" href="{$aFeed.link|escape:'htmlall':'UTF-8'}" download class="btn btn-sm btn-outline-success label-tooltip" title="{l s='Download' mod='googlemerchantfeed'}">
                                                                    <i class="material-icons" style="font-size: 18px;">file_download</i>
                                                                </a>
                                                                <a type="button" class="btn btn-sm btn-outline-secondary label-tooltip btn-copy js-tooltip js-copy" title="{l s='Copy URL' mod='googlemerchantfeed'}" data-toggle="tooltip" data-placement="bottom" data-copy="{$aFeed.link|escape:'htmlall':'UTF-8'}">
                                                                    <i class="material-icons" style="font-size: 18px;">content_copy</i>
                                                                </a>
                                                                {if empty($aFeed.is_default)}
                                                                    <a href="#" class="btn btn-sm btn-outline-danger label-tooltip" title="{l s='Delete' mod='googlemerchantfeed'}" onclick="check = confirm('{l s='Are you sure you want to delete this data feed?' mod='googlemerchantfeed'} {l s='It will be definitely removed from your database' mod='googlemerchantfeed'}');if(!check)return false;$('#loadingFeedListDiv').show();oGmcPro.hide('bt_rules');oGmcPro.ajax('{$sURI|escape:'htmlall':'UTF-8'}', '{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.deleteFeed.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.deleteFeed.type|escape:'htmlall':'UTF-8'}&export_mode=xml&id_feed={$aFeed.id_feed|escape:'htmlall':'UTF-8'}', 'bt_feed-list-settings', 'bt_feed-list-settings', null, null, 'loadingFeedListDiv');">
                                                                        <i class="material-icons" style="font-size: 18px;">delete</i>
                                                                    </a>
                                                                {/if}
                                                            </div>
                                                            <div id="total_product_processed_{$aFeed.lang|lower|escape:'htmlall':'UTF-8'}_{$aFeed.country|lower|escape:'htmlall':'UTF-8'}" style="font-style: bold; display: none; margin-left:20px; vertical-align:text-top;"></div>
                                                            
                                                            {* Reporting Modal Trigger (Hidden but functional) *}
                                                            <a style="display:none;" href="#theModal-{$aFeed.full|escape:'htmlall':'UTF-8'}" id="reporting-data-{$aFeed.full|escape:'htmlall':'UTF-8'}" onclick="oGmcPro.cleanModal('#theModal-{$aFeed.full|escape:'htmlall':'UTF-8'}')" class="nav-link" data-remote="{$sURI|escape:'htmlall':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.reportingBox.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.reportingBox.type|escape:'htmlall':'UTF-8'}&lang={$aFeed.full|escape:'htmlall':'UTF-8'}" data-toggle="modal" data-target="#theModal-{$aFeed.full|escape:'htmlall':'UTF-8'}"><i class="material-icons">assessment</i></a>
                                                            <div class="modal fade" id="theModal-{$aFeed.full|escape:'htmlall':'UTF-8'}" tabindex="-1" role="dialog">
                                                                <div class="modal-dialog modal-lg" style="width:80%;" role="document">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header"></div>
                                                                        <div class="modal-body">
                                                                            <div class="alert alert-info">
                                                                                <p style="text-align: center !important;"><img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" /></p>
                                                                                <div class="clr_20"></div>
                                                                                <p style="text-align: center !important;">{l s='The update of your configuration is in progress...' mod='googlemerchantfeed'}</p>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div> 
                              <div class="mt-4 mb-3">
									<div class="card-footer bg-light border-top">
										<div class="d-flex justify-content-end">
											<button type="submit" class="btn btn-primary btn-lg" onclick="oGmcPro.form('bt_feedlist-{$sDisplay|escape:'htmlall':'UTF-8'}-form', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_feed-list-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', 'bt-feed-list-settings-{$sDisplay|escape:'htmlall':'UTF-8'}', false, false, null, 'FeedList{$sDisplay|escape:'htmlall':'UTF-8'}', 'loadingFeedListDiv'); return false;">
												<i class="material-icons">save</i> {l s='Save' mod='googlemerchantfeed'}
											</button>
										</div>
									</div>
								</div>

                                {* Tab 2: CRON URLs *}
                                <div class="tab-pane fade" id="cron" role="tabpanel">
                                    <div class="clr_10"></div>
                                    <div class="alert alert-info form-group">
                                        <i class="material-icons">info</i>
                                        <b>{l s='Be careful:' mod='googlemerchantfeed'}</b>&nbsp;{l s='schedule your CRON task so that the XML files are up to date when Google will retreive them to update your data in Google Shopping.' mod='googlemerchantfeed'}
                                        <div class="clr_5"></div>
                                    </div>

                                    <div class="form-group" style="display: none !important;">
                                        <label class="control-label col-xs-12 col-md-11 col-lg-2">
                                            <span class="label-tooltip" title="{l s='Use this URL to update several feed files at the same time (check first the relevant files in "Your XML files" tab, remembering to save). If you note that all your files aren\'t correctly generated, set up a CRON task for each feed in order to update them one by one (use the independent URL\'s below), in a time-shifted manner (to avoid a servor time-out).' mod='googlemerchantfeed'}"><b>{l s='My general CRON URL' mod='googlemerchantfeed'}</b></span> :
                                        </label>
                                        {if !empty($aCronLangProduct)}
                                            <div class="col-xs-12 col-md-5 col-lg-5">
                                                <input type="text" value="{$sCronUrlProduct|escape:'htmlall':'UTF-8'}" class="form-control" readonly>
                                            </div>
                                            <a class="badge badge-info" href="{$sCronUrlProduct|escape:'htmlall':'UTF-8'}" target="_blank"><i class="icon icon-link"></i>&nbsp;{l s='Execute the CRON in browser' mod='googlemerchantfeed'}</a>
                                        {else}
                                            <div class="col-xs-12 col-md-5 col-lg-5">
                                                <div class="alert alert-warning">{l s='You cannot use this CRON URL because you didn\'t select any XML file in the previous "Your XML files" tab. Please check first the files to be filled in at the same time,' mod='googlemerchantfeed'}&nbsp;<b>{l s='save your selection' mod='googlemerchantfeed'}</b>&nbsp;{l s='and then come back here to use this general URL to set up your CRON task.' mod='googlemerchantfeed'}</div>
                                            </div>
                                        {/if}
                                    </div>

                                    {if !empty($aCronListProduct)}
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th class="text-center">{l s='Language' mod='googlemerchantfeed'}</th>
                                                        <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                                        <th class="text-center">{l s='Currency' mod='googlemerchantfeed'}</th>
                                                        <th class="text-center">{l s='Taxonomy' mod='googlemerchantfeed'}</th>
                                                        <th class="text-center" style="width: 15%;">{l s='Action' mod='googlemerchantfeed'}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {foreach from=$aCronListProduct name=feed key=iKey item=aCronFeed}
                                                        <tr>
                                                            <td class="text-center align-middle">{$aCronFeed.langName|escape:'htmlall':'UTF-8'}</td>
                                                            <td class="text-center align-middle">{$aCronFeed.countryName|escape:'htmlall':'UTF-8'} - {$aCronFeed.country|escape:'htmlall':'UTF-8'}</td>
                                                            <td class="text-center align-middle">{$aCronFeed.currencySign|escape:'htmlall':'UTF-8'} - {$aCronFeed.currencyIsoCron|escape:'htmlall':'UTF-8'}</td>
                                                            <td class="text-center align-middle">{$aCronFeed.taxonomy|escape:'htmlall':'UTF-8'}</td>
                                                            <td class="text-center align-middle">
                                                                <div class="btn-group" role="group">
                                                                    <a type="button" class="btn btn-sm btn-outline-secondary label-tooltip btn-copy js-tooltip js-copy" title="{l s='Copy' mod='googlemerchantfeed'}" data-toggle="tooltip" data-placement="bottom" data-copy="{$aCronFeed.link|escape:'htmlall':'UTF-8'}">
                                                                        <i class="material-icons" style="font-size: 18px;">content_copy</i>
                                                                    </a>
                                                                    <a class="btn btn-sm btn-outline-success label-tooltip" target="_blank" title="{l s='Execute' mod='googlemerchantfeed'}" href="{$aCronFeed.link|escape:'htmlall':'UTF-8'}">
                                                                        <i class="material-icons" style="font-size: 18px;">play_circle</i>
                                                                    </a>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>

                        {* ON THE FLY Section *}
                        <div class="bt-fb-fly-product" style="display: none;">
                            {if !empty($aFlyFileListProduct)}
                                <p class="alert alert-info form-group">
                                    <i class="material-icons">info</i> {l s='You can use the "on-the-fly output" URL\'s if your catalog is relatively small (30000 products maximum), if not, choose the solution of setting up a CRON task. However, if you are on a dedicated server, this one may also be able to process larger catalogs if you increase its PHP time-out and memory usage limits.' mod='googlemerchantfeed'}
                                </p>
                                <div class="clr_5"></div>

                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Language' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Currency' mod='googlemerchantfeed'}</th>
                                                <th class="text-center">{l s='Taxonomy' mod='googlemerchantfeed'}</th>
                                                <th class="text-center" style="width: 20%;">{l s='Action' mod='googlemerchantfeed'}</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach from=$aFlyFileListProduct name=feed key=iKey item=aFlyFeed}
                                                <tr>
                                                    <td class="text-center align-middle">{$aFlyFeed.countryName|escape:'htmlall':'UTF-8'} - {$aFlyFeed.countryIso|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center align-middle">
                                                        {$aFlyFeed.langName|escape:'htmlall':'UTF-8'} - {$aFlyFeed.iso_code|escape:'htmlall':'UTF-8'}
                                                        {if empty($aFlyFeed.is_default)}
                                                            <span class="badge badge-info ml-1">{l s='Custom feed' mod='googlemerchantfeed'}</span>
                                                        {/if}
                                                    </td>
                                                    <td class="text-center align-middle">{$aFlyFeed.currencySign|escape:'htmlall':'UTF-8'} - {$aFlyFeed.currencyIso|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center align-middle">{$aFlyFeed.taxonomy|escape:'htmlall':'UTF-8'}</td>
                                                    <td class="text-center align-middle">
                                                        <div class="btn-group" role="group">
                                                            <a class="btn btn-sm btn-outline-info label-tooltip" title="{l s='See' mod='googlemerchantfeed'}" target="_blank" href="{$aFlyFeed.link|escape:'htmlall':'UTF-8'}">
                                                                <i class="material-icons" style="font-size: 18px;">visibility</i>
                                                            </a>
                                                            <a type="button" class="btn btn-sm btn-outline-secondary label-tooltip btn-copy js-tooltip js-copy" title="{l s='Copy' mod='googlemerchantfeed'}" data-toggle="tooltip" data-placement="bottom" data-copy="{$aFlyFeed.link|escape:'htmlall':'UTF-8'}">
                                                                <i class="material-icons" style="font-size: 18px;">content_copy</i>
                                                            </a>
                                                            {if empty($aFlyFeed.is_default)}
                                                                <a href="#" class="btn btn-sm btn-outline-danger label-tooltip" title="{l s='Delete' mod='googlemerchantfeed'}" onclick="check = confirm('{l s='Are you sure you want to delete this data feed?' mod='googlemerchantfeed'} {l s='It will be definitely removed from your database' mod='googlemerchantfeed'}');if(!check)return false;$('#loadingFeedListDiv').show();oGmcPro.hide('bt_feed-list-settings');oGmcPro.ajax('{$sURI|escape:'htmlall':'UTF-8'}', '{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.deleteFeed.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.deleteFeed.type|escape:'htmlall':'UTF-8'}&export_mode=fly&id_feed={$aFlyFeed.id_feed|escape:'htmlall':'UTF-8'}', 'bt_feed-list-settings', 'bt_feed-list-settings', null, null, 'loadingFeedListDiv');">
                                                                    <i class="material-icons" style="font-size: 18px;">delete</i>
                                                                </a>
                                                            {/if}
                                                        </div>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            {else}
                                <div class="alert alert-warning">
                                    <i class="material-icons">warning</i> {l s='There are no files because of no valid languages / currencies / countries according to the Google\'s requirements.' mod='googlemerchantfeed'}
                                    <b><a target="_blank" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/52&lg={$sCurrentIso|escape:'htmlall':'UTF-8'}" class="alert-link">{l s='See our FAQ about localization prerequisites.' mod='googlemerchantfeed'}</a></b>
                                </div>
                            {/if}
                        </div>
                    {else}
                        <div class="alert alert-warning">
                            <i class="material-icons">warning</i> {l s='Either you just updated your configuration by deactivating the advanced file security feature (in which case, please reload the page), or, there are no file because of no valid languages / currencies / countries, according to the Google\'s requirements.' mod='googlemerchantfeed'}
                            <b><a target="_blank" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/52&lg={$sCurrentIso|escape:'htmlall':'UTF-8'}" class="alert-link">{l s='See our FAQ about localization prerequisites.' mod='googlemerchantfeed'}</a></b>
                        </div>
                    {/if}
                {else}
                    <div class="clr_15"></div>
                    <div class="alert alert-warning">
                        <i class="material-icons">warning</i> {l s='No category or brand have been selected : please go to "Product feed management -> Export method" tab, and select at least one category (or brand). You also need to make sure that there is at least one product in each selected category (or brand). Remember : the categories used here are the products DEFAULT categories.' mod='googlemerchantfeed'}
                    </div>
                {/if}
            {else}
                <div class="clr_15"></div>
                <div class="alert alert-warning">
                    <i class="material-icons">warning</i> {l s='You must first update the module\'s configuration options before the files can be accessed.' mod='googlemerchantfeed'}
                </div>
            {/if}
        {/if}
        {* END - classic product data feed *}

        {* ========================================================= *}
        {* BEGIN - Promo Product Data Feed                           *}
        {* ========================================================= *}
        {if !empty($sDisplay) && $sDisplay == 'promo'}
            <h3 class="subtitle mb-3"><i class="material-icons">local_offer</i> {l s='Special offers data feed' mod='googlemerchantfeed'}</h3>
            
            {if !empty($aFlyFileListDiscount)}
                <div class="clr_10"></div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th class="text-center">{l s='Language' mod='googlemerchantfeed'}</th>
                                <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                <th class="text-center" style="width: 20%;">{l s='Action' mod='googlemerchantfeed'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$aFlyFileListDiscount name=feed key=iKey item=aFlyFeed}
                                <tr>
                                    <td class="text-center align-middle">{$aFlyFeed.langName|escape:'htmlall':'UTF-8'} - {$aFlyFeed.iso_code|escape:'htmlall':'UTF-8'}</td>
                                    <td class="text-center align-middle">{$aFlyFeed.countryName|escape:'htmlall':'UTF-8'} - {$aFlyFeed.countryIso|escape:'htmlall':'UTF-8'}</td>
                                    <td class="text-center align-middle">
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-sm btn-outline-info label-tooltip" target="_blank" title="{l s='See' mod='googlemerchantfeed'}" href="{$aFlyFeed.link|escape:'htmlall':'UTF-8'}">
                                                <i class="material-icons" style="font-size: 18px;">visibility</i>
                                            </a>
                                            <a type="button" class="btn btn-sm btn-outline-secondary label-tooltip btn-copy js-tooltip js-copy" title="{l s='Copy' mod='googlemerchantfeed'}" data-toggle="tooltip" data-placement="bottom" data-copy="{$aFlyFeed.link|escape:'htmlall':'UTF-8'}">
                                                <i class="material-icons" style="font-size: 18px;">content_copy</i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            {else}
                <div class="alert alert-warning">
                    <i class="material-icons">warning</i> {l s='There are no files because of no valid languages / currencies / countries according to the Google\'s requirements.' mod='googlemerchantfeed'}
                    <b><a target="_blank" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/52" class="alert-link">{l s='See our FAQ about localization prerequisites.' mod='googlemerchantfeed'}</a></b>
                    <div class="clr_10"></div>
                    <h3 class="subtitle"><i class="material-icons">public</i>&nbsp;{l s='Locale prerequisites'  mod='googlemerchantfeed'}</h3>
                    <div class="alert alert-info">
                        <strong class="highlight_element">
                            {l s='*** IMPORTANT NOTE *** : a feed for a country will be generated if the country\'s language and official currency are installed and active on your shop, and if the country is part of those where Google Shopping is implemented. For more information, please read the' mod='googlemerchantfeed'}&nbsp;<a href="https://support.google.com/merchants/answer/160637?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}&visit_id=1-636342381361070010-4017773094&rd=1" target="_blank" class="alert-link">{l s='Google official documentation.' mod='googlemerchantfeed'}</a>
                            <br>
                        </strong>
                        <br />
                        {l s='If some countries do not appear in the list of your XML files or PHP URL\'s (in "My feeds" tab), you must check your country, language and currency ISO codes in your back-office ("Localization tab") and look if they respect for example uppercase or lowercase. Actually, you must write these codes EXACTLY how they are written in the table of the ' mod='googlemerchantfeed'}
                        <a href="https://support.google.com/merchants/answer/160637?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}&visit_id=1-636342381361070010-4017773094&rd=1" target="_blank"><b>{l s='Google official documentation.' mod='googlemerchantfeed'}</b></a>
                    </div>
                </div>
            {/if}
        {/if}
        {* END - promo product data feed *}

        {* ========================================================= *}
        {* BEGIN - Product Reviews Data Feed                         *}
        {* ========================================================= *}
        {if !empty($sDisplay) && $sDisplay == 'reviews'}
            <h3 class="subtitle mb-3"><i class="material-icons">star</i>&nbsp;{l s='Product ratings data feed' mod='googlemerchantfeed'}</h3>

            <div class="bt-fb-fly-reviews">
                <div class="clr_10"></div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="thead-light">
                            <tr>
                                <th class="text-center">{l s='Country' mod='googlemerchantfeed'}</th>
                                <th class="text-center">{l s='URL (copy this URL into your Google Merchant Center interface / planning)' mod='googlemerchantfeed'}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {if !empty($aFlyFileListReviews)}
                                {foreach from=$aFlyFileListReviews name=feed key=iKey item=aFlyFeed}
                                    <tr>
                                        <td class="text-center align-middle">{$aFlyFeed.countryName|escape:'htmlall':'UTF-8'} - {$aFlyFeed.countryIso|escape:'htmlall':'UTF-8'}</td>
                                        <td class="text-center align-middle">
                                            <a target="_blank" href="{$aFlyFeed.link|escape:'htmlall':'UTF-8'}" class="font-monospace text-primary">{$aFlyFeed.langName|escape:'htmlall':'UTF-8'}</a>
                                        </td>
                                    </tr>
                                {/foreach}
                            {else}
                                <tr>
                                    <td>
                                        <div class="alert alert-warning text-center">
                                            <i class="material-icons">warning</i> {l s='No review module compatible with Google Shopping Export PRO is installed' mod='googlemerchantfeed'}
                                        </div>
                                    </td>
                                </tr>
                            {/if}
                        </tbody>
                    </table>
                </div>
            </div>
        {/if}
        {* END - product reviews data feed *}
    </form>
    <div id="{$sModuleName|escape:'htmlall':'UTF-8'}FeedListError"></div>
</div>

{literal}
<script type="text/javascript">
    oGmcProFeedList.dynamicDisplay();

    //bootstrap components init
{/literal}
{if !empty($bAjaxMode)}
    {literal}
        $('.label-tooltip, .help-tooltip').tooltip();
    {/literal}
{/if}
{literal}
</script>
{/literal}