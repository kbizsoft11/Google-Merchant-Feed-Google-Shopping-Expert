{*
 * Google Shopping Export PRO - Header Stepper
 *
 * @author      kbizsoft
 * @copyright   Kbizsoft
 * @license     Commercial
 *}

<style>
    .gmc-header-card {
        border: none;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        border-radius: 8px;
        overflow: hidden;
        background: #fff;
    }
    .gmc-logo-section {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        border-right: 1px solid #f0f0f0;
    }
    .gmc-logo-section img {
        max-height: 60px;
        width: auto;
    }
    
    /* Modern Stepper CSS */
    .modern-stepper {
        display: flex;
        justify-content: space-between;
        position: relative;
        padding: 35px 20px;
    }
    .modern-stepper::before {
        content: '';
        position: absolute;
        top: 56px;
        left: 15%;
        right: 15%;
        height: 3px;
        background-color: #e9ecef;
        z-index: 1;
    }
    .step-item {
        position: relative;
        z-index: 2;
        text-align: center;
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .step-circle {
        width: 44px;
        height: 44px;
        border-radius: 50%;
        background-color: #e9ecef;
        color: #6c757d;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 12px;
        font-weight: 700;
        font-size: 18px;
        transition: all 0.3s ease;
        border: 3px solid #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }
    .step-item.complete .step-circle,
    .step-item.active .step-circle {
        background-color: #25b9d7;
        color: #fff;
    }
    .step-item.active .step-circle {
        box-shadow: 0 0 0 5px rgba(37, 185, 215, 0.2);
    }
    .step-title {
        font-size: 14px;
        font-weight: 600;
        color: #363a41;
        margin-bottom: 10px;
    }
    .step-item.disabled .step-title {
        color: #adb5bd;
    }
    .step-item.disabled .step-circle {
        background-color: #f8f9fa;
        color: #adb5bd;
        border-color: #e9ecef;
    }
    
    /* Step Buttons */
    .btn-step {
        font-size: 12px;
        padding: 6px 16px;
        border-radius: 20px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: none;
    }
    .btn-step.btn-warning {
        background-color: #f39f18;
        color: #fff;
    }
    .btn-step.btn-warning:hover {
        background-color: #e08e0b;
        color: #fff;
    }
    .btn-step.btn-success {
        background-color: #70b562;
        color: #fff;
    }
    .btn-step i {
        font-size: 14px;
        margin-right: 4px;
        vertical-align: middle;
    }

    /* Responsive Mobile Layout */
    @media (max-width: 767px) {
        .gmc-logo-section {
            border-right: none;
            border-bottom: 1px solid #f0f0f0;
            padding: 15px;
        }
        .modern-stepper {
            flex-direction: column;
            gap: 25px;
            padding: 25px 20px;
        }
        .modern-stepper::before {
            display: none;
        }
        .step-item {
            flex-direction: row;
            text-align: left;
            gap: 15px;
        }
        .step-circle {
            margin-bottom: 0;
        }
        .step-content {
            display: flex;
            flex-direction: column;
        }
    }
</style>

<div class="card gmc-header-card mb-4">
    <div class="row no-gutters">
        {* Logo Section *}
        <div class="col-md-2 gmc-logo-section">
            <img src="{$imagePath|escape:'htmlall':'UTF-8'}admin/logo.png" alt="Google Merchant Feed" />
        </div>

        {* Stepper Section *}
        <div class="col-md-10">
            <div class="modern-stepper">
                
                {* Step 1: General Settings *}
                <div class="step-item {if empty($bConfigureStep1)}active{else}complete{/if}">
                    <div class="step-circle">1</div>
                    <div class="step-content">
                        <div class="step-title">{l s='General Settings' mod='googlemerchantfeed'}</div>
                        {if empty($bConfigureStep1)}
                            <a href="#" class="btn btn-step btn-warning" id="tab-2">
                                <i class="material-icons">settings</i> {l s='Configure' mod='googlemerchantfeed'}
                            </a>
                        {else}
                            <span class="text-success font-weight-bold">
                                <i class="material-icons" style="font-size:16px; vertical-align:middle;">check_circle</i> 
                                {l s='Completed' mod='googlemerchantfeed'}
                            </span>
                        {/if}
                    </div>
                </div>

                {* Step 2: Data Management *}
                <div class="step-item {if empty($bConfigureStep2)}active{else}complete{/if} {if empty($bConfigureStep1)}disabled{/if}">
                    <div class="step-circle">2</div>
                    <div class="step-content">
                        <div class="step-title">{l s='Data Management' mod='googlemerchantfeed'}</div>
                        {if empty($bConfigureStep2) && !empty($bConfigureStep1)}
                            <a href="#" class="btn btn-step btn-warning" id="tab-001">
                                <i class="material-icons">settings</i> {l s='Configure' mod='googlemerchantfeed'}
                            </a>
                        {elseif !empty($bConfigureStep2)}
                            <span class="text-success font-weight-bold">
                                <i class="material-icons" style="font-size:16px; vertical-align:middle;">check_circle</i> 
                                {l s='Completed' mod='googlemerchantfeed'}
                            </span>
                        {else}
                            <span class="text-muted small">{l s='Locked' mod='googlemerchantfeed'}</span>
                        {/if}
                    </div>
                </div>

                {* Step 3: Import / Feed Creation (Kept commented as per original, but fully styled if you enable it) *}
                {*
                <div class="step-item {if empty($bConfigureStep3)}active{else}complete{/if} {if empty($bConfigureStep2)}disabled{/if}">
                    <div class="step-circle">3</div>
                    <div class="step-content">
                        <div class="step-title">{l s='Import & Feeds' mod='googlemerchantfeed'}</div>
                        {if empty($bConfigureStep3) && !empty($bConfigureStep2)}
                            <a href="{$sURI|escape:'htmlall':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.stepPopup.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.stepPopup.type|escape:'htmlall':'UTF-8'}" class="fancybox.ajax btn btn-step btn-success bt_add-feed" id="tab-030">
                                <i class="material-icons">add_circle</i> {l s='Configure' mod='googlemerchantfeed'}
                            </a>
                        {elseif !empty($bConfigureStep3)}
                            <span class="text-success font-weight-bold">
                                <i class="material-icons" style="font-size:16px; vertical-align:middle;">check_circle</i> 
                                {l s='Completed' mod='googlemerchantfeed'}
                            </span>
                        {else}
                            <span class="text-muted small">{l s='Locked' mod='googlemerchantfeed'}</span>
                        {/if}
                    </div>
                </div>
                *}

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        // Initialize Fancybox for the add-feed button (Step 3)
        $("a.bt_add-feed").fancybox({
            'hideOnContentClick': false,
            'type': 'ajax',
            'autoSize': false,
            'width': '80%',
            'height': '80%'
        });
    });
</script>