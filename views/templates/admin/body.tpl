{*
 * Google Shopping Export PRO
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

<style>
    /* Modern Sidebar Styling */
    .card-sidebar {
        border: 1px solid #e5e5e5;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .card-sidebar .card-header {
        font-weight: 600;
        padding: 12px 15px;
        font-size: 15px;
    }
    .workTabs .list-group-item {
        border: none;
        border-bottom: 1px solid #f0f0f0;
        padding: 11px 15px;
        font-size: 14px;
        color: #363a41;
        transition: all 0.2s ease;
    }
    .workTabs .list-group-item:last-child {
        border-bottom: none;
    }
    .workTabs .list-group-item:hover {
        background-color: #f8f9fa;
        color: #00aff0;
        padding-left: 20px;
    }
    .workTabs .list-group-item.active {
        background-color: #00aff0;
        color: #fff !important;
        font-weight: 600;
    }
    .workTabs .list-group-item.active:hover {
        padding-left: 15px; /* Prevent shift on active item */
    }
    .submenu-group .list-group-item {
        padding-left: 38px;
        font-size: 13px;
        color: #555;
        background-color: #fcfcfc;
    }
    .submenu-group .list-group-item:hover {
        color: #00aff0;
        padding-left: 42px;
        background-color: #f0f8ff;
    }
    .collapse-icon {
        transition: transform 0.3s ease;
        font-size: 12px;
        color: #999;
    }
    .collapse.show .collapse-icon {
        transform: rotate(180deg);
    }
    .list-group-item-action {
        cursor: pointer;
        text-decoration: none;
    }
    
    /* Icon Colors */
    .icon-general { color: #2196F3 !important; }
    .icon-feed { color: #FF9800 !important; }
    .icon-special { color: #9C27B0 !important; }
    .icon-google { color: #4285F4 !important; }
    .icon-feeds { color: #4CAF50 !important; }
    .icon-reporting { color: #00BCD4 !important; }
    .icon-reviews { color: #FFC107 !important; }
    
    /* Submenu Icon Colors */
    .submenu-icon-check { color: #66BB6A !important; }
    .submenu-icon-database { color: #29B6F6 !important; }
    .submenu-icon-ban { color: #EF5350 !important; }
    .submenu-icon-tshirt { color: #AB47BC !important; }
    .submenu-icon-cogs { color: #FFA726 !important; }
    .submenu-icon-truck { color: #7E57C2 !important; }
    .submenu-icon-percent { color: #26A69A !important; }
    .submenu-icon-store { color: #5C6BC0 !important; }
    .submenu-icon-star { color: #FFCA28 !important; }
    .submenu-icon-sitemap { color: #78909C !important; }
    .submenu-icon-chart { color: #66BB6A !important; }
    .submenu-icon-bookmark { color: #FF7043 !important; }
    .submenu-icon-box { color: #42A5F5 !important; }
    .submenu-icon-tags { color: #9CCC65 !important; }
    .submenu-icon-plus { color: #26C6DA !important; }
</style>

<div id="{$sModuleName|escape:'htmlall':'UTF-8'}" class="bootstrap form">
    {* HEADER *}
    {include file="`$sHeaderInclude`" bContentToDisplay=true}
    {* /HEADER *}
    {include file="`$sTopBar`"}

    {* USE CASE - module update not ok *}
    {if !empty($aUpdateErrors)}
        {include file="`$sErrorInclude`" aErrors=$aUpdateErrors bDebug=true}
    {* USE CASE - display configuration ok *}
    {else}
        {literal}
            <script type="text/javascript">
                var id_language = Number({/literal}{$iCurrentLang|escape:'htmlall':'UTF-8'}{literal});
                function hideOtherLanguage(id) {
                    $('.translatable-field').hide();
                    $('.lang-' + id).show();
                    var id_old_language = id_language;
                    id_language = id;
                }
            </script>
        {/literal}

        <div class="clr_20"></div>

        <div class="row">
            {* ================= START LEFT MENU ================= *}
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="card card-sidebar">
                    <div class="card-header bg-primary text-white">
                        <i class="fa fa-bars mr-2"></i> {l s='Navigation' mod='googlemerchantfeed'}
                    </div>
                    
                    <div class="list-group list-group-flush workTabs" id="mainMenu">
                        
                        <!-- General Settings -->
                        <a class="list-group-item list-group-item-action pointer active" id="tab-2">
                            <i class="fa fa-cog mr-2 icon-general"></i> {l s='General Settings' mod='googlemerchantfeed'}
                        </a>

                        <!-- Feed Settings (Accordion) -->
                        <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseFeed" role="button" aria-expanded="false">
                            <div class="d-flex justify-content-between align-items-center">
                                <span><i class="fa fa-rss mr-2 icon-feed"></i> {l s='Feed Settings' mod='googlemerchantfeed'}</span>
                                <i class="fa fa-chevron-down collapse-icon"></i>
                            </div>
                        </a>
                        <div class="collapse" id="collapseFeed">
                            <div class="list-group list-group-flush submenu-group">
                                <a class="list-group-item list-group-item-action" id="tab-001">
                                    <i class="fa fa-check-square mr-2 submenu-icon-check"></i> {l s='Export method' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-003">
                                    <i class="fa fa-database mr-2 submenu-icon-database"></i> {l s='Feed data options' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-002">
                                    <i class="fa fa-ban mr-2 submenu-icon-ban"></i> {l s='Product exclusion rules' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-004">
                                    <i class="fa fa-tshirt mr-2 submenu-icon-tshirt"></i> {l s='Apparel feed options' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-005">
                                    <i class="fa fa-cogs mr-2 submenu-icon-cogs"></i> {l s='Advanced feed options' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-006">
                                    <i class="fa fa-truck mr-2 submenu-icon-truck"></i> {l s='Taxes and shipping fees' mod='googlemerchantfeed'}
                                </a>
                            </div>
                        </div>

                        <!-- Special Offers & Inventory (Accordion) -->
                        <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseSpecial" role="button" aria-expanded="false">
                            <div class="d-flex justify-content-between align-items-center">
                                <span><i class="fa fa-tags mr-2 icon-special"></i> {l s='Special Offers & Inventory' mod='googlemerchantfeed'}</span>
                                <i class="fa fa-chevron-down collapse-icon"></i>
                            </div>
                        </a>
                        <div class="collapse" id="collapseSpecial">
                            <div class="list-group list-group-flush submenu-group">
                                <a class="list-group-item list-group-item-action" id="tab-010">
                                    <i class="fa fa-percent mr-2 submenu-icon-percent"></i> {l s='Special offers data feed' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-011">
                                    <i class="fa fa-store mr-2 submenu-icon-store"></i> {l s='Local product inventory' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-012">
                                    <i class="fa fa-star mr-2 submenu-icon-star"></i> {l s='Product ratings data feed' mod='googlemerchantfeed'}
                                </a>
                            </div>
                        </div>

                        <!-- Google Management (Accordion) -->
                        <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseGoogle" role="button" aria-expanded="false">
                            <div class="d-flex justify-content-between align-items-center">
                                <span><i class="fa fa-google mr-2 icon-google"></i> {l s='Google management' mod='googlemerchantfeed'}</span>
                                <i class="fa fa-chevron-down collapse-icon"></i>
                            </div>
                        </a>
                        <div class="collapse" id="collapseGoogle">
                            <div class="list-group list-group-flush submenu-group">
                                <a class="list-group-item list-group-item-action" id="tab-020">
                                    <i class="fa fa-sitemap mr-2 submenu-icon-sitemap"></i> {l s='Matching with Google Categories' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-021">
                                    <i class="fa fa-chart-line mr-2 submenu-icon-chart"></i> {l s='Google Analytics integration' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-022">
                                    <i class="fa fa-bookmark mr-2 submenu-icon-bookmark"></i> {l s='Custom labels integration' mod='googlemerchantfeed'}
                                </a>
                            </div>
                        </div>

                        <!-- My Feeds (Accordion) -->
                        <a class="list-group-item list-group-item-action" data-toggle="collapse" href="#collapseMyFeeds" role="button" aria-expanded="false">
                            <div class="d-flex justify-content-between align-items-center">
                                <span><i class="fa fa-folder mr-2 icon-feeds"></i> {l s='My feeds' mod='googlemerchantfeed'}</span>
                                <i class="fa fa-chevron-down collapse-icon"></i>
                            </div>
                        </a>
                        <div class="collapse" id="collapseMyFeeds">
                            <div class="list-group list-group-flush submenu-group">
                                <a class="list-group-item list-group-item-action" id="tab-030">
                                    <i class="fa fa-box mr-2 submenu-icon-box"></i> {l s='Products data feed' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-031">
                                    <i class="fa fa-tags mr-2 submenu-icon-tags"></i> {l s='Special offers data feed' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-033">
                                    <i class="fa fa-star mr-2 submenu-icon-star"></i> {l s='Product ratings data feed' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-034">
                                    <i class="fa fa-store mr-2 submenu-icon-store"></i> {l s='Local product inventory feed' mod='googlemerchantfeed'}
                                </a>
                                <a class="list-group-item list-group-item-action" id="tab-035">
                                    <i class="fa fa-plus-circle mr-2 submenu-icon-plus"></i> {l s='Additional feed creation' mod='googlemerchantfeed'}
                                </a>
                            </div>
                        </div>

                        <!-- Standalone Items -->
                        <a class="list-group-item list-group-item-action pointer" id="tab-4">
                            <i class="fa fa-chart-bar mr-2 icon-reporting"></i> {l s='Reporting' mod='googlemerchantfeed'}
                        </a>
                        <a class="list-group-item list-group-item-action pointer" id="tab-5">
                            <i class="fa fa-star-half-alt mr-2 icon-reviews"></i> {l s='Google Customer Reviews' mod='googlemerchantfeed'}
                        </a>
                    </div>

                    <!-- Useful Links Card -->
                    <div class="card mt-3 border-info shadow-sm">
                        <div class="card-header bg-info text-white">
                            <i class="fa fa-link mr-2"></i> {l s='Useful Links' mod='googlemerchantfeed'}
                        </div>
                        <div class="list-group list-group-flush">
                            <a class="list-group-item list-group-item-action" target="_blank" href="https://merchants.google.com">
                                <i class="fa fa-shopping-cart mr-2 text-success"></i> {l s='Google Merchant Center' mod='googlemerchantfeed'}
                            </a>
                            <a class="list-group-item list-group-item-action" target="_blank" href="https://ads.google.com">
                                <i class="fa fa-briefcase mr-2 text-primary"></i> {l s='Google Ads account' mod='googlemerchantfeed'}
                            </a>
                            <a class="list-group-item list-group-item-action" target="_blank" href="https://support.google.com/merchants/topic/7257844?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}">
                                <i class="fa fa-info-circle mr-2 text-info"></i> {l s='Best practices guide' mod='googlemerchantfeed'}
                            </a>
                            <a class="list-group-item list-group-item-action" target="_blank" href="https://support.google.com/merchants/topic/7286989?hl={$sCurrentIso|escape:'htmlall':'UTF-8'}">
                                <i class="fa fa-gavel mr-2 text-warning"></i> {l s='Google Shopping policies' mod='googlemerchantfeed'}
                            </a>
                        </div>
                    </div>

                    <!-- Version Card -->
                    <div class="card mt-3 shadow-sm">
                        <div class="card-body text-center text-muted py-2">
                            <small><i class="fa fa-info-circle mr-1"></i> {l s='Version' mod='googlemerchantfeed'}: <strong>{$sModuleVersion|escape:'htmlall':'UTF-8'}</strong></small>
                        </div>
                    </div>
                </div>
            </div>
            {* ================= END LEFT MENU ================= *}

            {* ================= START RIGHT CONTENT ================= *}
            <div class="col-lg-9 col-md-8">
                {if empty($bHideConfiguration)}
                    <div class="tab-content">

                        {* General SETTINGS *}
                        <div id="content-tab-2" class="tab-pane panel active">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger">
                                    <i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}
                                </div>
                            {else}
                                <div id="bt_basics-settings">
                                    {include file="`$sBasicsInclude`"}
                                </div>
                                <div class="clr_20"></div>
                                <div id="loadingBasicsDiv" style="display: none;">
                                    <div class="alert alert-info text-center">
                                        <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                        <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {* FEED MANAGEMENT SETTINGS *}
                        <div id="content-tab-001" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-export">{include file="`$sFeedInclude`" sDisplay="export"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-002" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-exclusion">{include file="`$sFeedInclude`" sDisplay="exclusion"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-003" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-data">{include file="`$sFeedInclude`" sDisplay="data"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-004" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-apparel">{include file="`$sFeedInclude`" sDisplay="apparel"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-005" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-advanced">{include file="`$sFeedInclude`" sDisplay="advanced"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-006" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-settings-tax">{include file="`$sFeedInclude`" sDisplay="tax"}</div>
                            {/if}
                        </div>

                        <div id="loadingFeedDiv" style="display: none;">
                            <div class="alert alert-info text-center">
                                <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                            </div>
                        </div>

                        {literal}
                            <script type="text/javascript">oGmcPro.runMainFeed();</script>
                        {/literal}

                        {* ADVANCED FEED MANAGEMENT SETTINGS *}
                        <div id="content-tab-010" class="tab-pane panel">
                            <div id="bt_advanced-settings-promo">{include file="`$sAdvanceFeed`" sDisplay="promo"}</div>
                        </div>

                        <div id="content-tab-011" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_local_inventory_div">{include file="`$sLocalInventoryFeed`"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-012" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_advanced-settings-reviews">{include file="`$sAdvanceFeed`" sDisplay="reviews"}</div>
                            {/if}
                        </div>

                        <div id="loadingAdvancedDiv" style="display: none;">
                            <div class="alert alert-info text-center">
                                <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                            </div>
                        </div>

                        {* GOOGLE MANAGEMENT SETTINGS *}
                        <div id="content-tab-020" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_google-settings-categories">{include file="`$sGoogleInclude`" sDisplay="categories"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-021" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_google-settings-analytics">{include file="`$sGoogleInclude`" sDisplay="analytics"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-022" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_google-settings-adwords">{include file="`$sGoogleInclude`" sDisplay="adwords"}</div>
                            {/if}
                        </div>

                        <div id="loadingGoogleDiv" style="display: none;">
                            <div class="alert alert-info text-center">
                                <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                            </div>
                        </div>

                        {literal}
                            <script type="text/javascript">oGmcPro.runMainGoogle();</script>
                        {/literal}

                        {* MY FEEDS SETTINGS *}
                        <div id="content-tab-030" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-list-settings-data">{include file="`$sFeedListInclude`" sDisplay="data"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-031" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-list-settings-promo">{include file="`$sFeedListInclude`" sDisplay="promo"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-032" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-list-settings-stock">{include file="`$sFeedListInclude`" sDisplay="stock"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-033" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_feed-list-settings-reviews">{include file="`$sFeedListInclude`" sDisplay="reviews"}</div>
                            {/if}
                        </div>

                        <div id="content-tab-034" class="tab-pane panel">
                            <div id="bt_feed-list-lia">{include file="`$sFeedListLiaInclude`"}</div>
                        </div>

                        <div id="content-tab-035" class="tab-pane panel">
                            <div id="bt_feed-settings-add">{include file="`$sCustomFeed`"}</div>
                        </div>

                        <div id="loadingFeedLiaDiv" style="display: none;">
                            <div class="alert alert-info text-center">
                                <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                            </div>
                        </div>

                        <div id="loadingFeedListDiv" style="display: none;">
                            <div class="alert alert-info text-center">
                                <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                            </div>
                        </div>

                        {* REPORTING SETTINGS *}
                        <div id="content-tab-4" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_reporting-settings">{include file="`$sReportingInclude`"}</div>
                                <div id="loadingReportingDiv" style="display: none;">
                                    <div class="alert alert-info text-center">
                                        <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                        <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {* GOOGLE CUSTOMER REVIEWS *}
                        <div id="content-tab-5" class="tab-pane panel">
                            {if !empty($bMultiShop)}
                                <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> {l s='First of all, you cannot configure your module in the "all shops" or "shops group" mode. Please select one of your shops before moving on into the configuration.' mod='googlemerchantfeed'}</div>
                            {else}
                                <div id="bt_google-customer-reviews-settings">{include file="`$googleCustomerReviews`"}</div>
                                <div id="loadingGoogleCustomerReivewsDiv" style="display: none;">
                                    <div class="alert alert-info text-center">
                                        <img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" class="mb-2" />
                                        <p>{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
                                    </div>
                                </div>
                            {/if}
                        </div>

                    </div>
                {else}
                    <div class="clr_20"></div>
                    {if !empty($bCurlAndContentStopExec)}
                        <div class="alert alert-danger">
                            <i class="fa fa-exclamation-triangle"></i> {l s='You need to have : either the file_get_contents() with the allow_url_fopen directive enabled in the php.ini file, or the PHP CURL extension enabled, in order to retrieve the Google category definition files from Google\'s website. Please contact your web host.' mod='googlemerchantfeed'}
                        </div>
                    {/if}
                    {if !empty($bMultishopGroupStopExec)}
                        <div class="alert alert-danger">
                            <i class="fa fa-exclamation-triangle"></i> {l s='For performance reasons, this module cannot be configured within a shops group context. You must configure it one shop at a time.' mod='googlemerchantfeed'}
                        </div>
                    {/if}
                {/if}
            </div>
            {* ================= END RIGHT CONTENT ================= *}
        </div>

        {literal}
            <script type="text/javascript">
                oGmcPro.tabManagement();
                $(document).ready(function() {
                    var redirectTab = oGmcPro.getUrlParam('tab', 'empty');
                    if (redirectTab !== 'empty') {
                        if (redirectTab === 'reporting') {
                            $("#tab-4").trigger("click");
                        } else if (redirectTab === 'adult') {
                            $("#collapseFeed").collapse('show');
                            $("#tab-003").trigger("click");
                        } else if (redirectTab === 'appreal') {
                            $("#collapseFeed").collapse('show');
                            $("#tab-004").trigger("click");
                        } else if (redirectTab === 'taxonomies') {
                            $("#collapseGoogle").collapse('show');
                            $("#tab-020").trigger("click");
                        } else if (redirectTab === 'feeds') {
                            $("#tab-3").trigger("click");
                        }
                    }
                });
            </script>
        {/literal}
    {/if}
</div>