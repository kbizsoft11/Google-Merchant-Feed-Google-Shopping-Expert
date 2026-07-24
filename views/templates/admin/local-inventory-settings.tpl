{*
*
* Google Shopping Export PRO
*
* @author      kbizsoft
* @copyright  Kbizsoft
* @license   Commercial
*
 
*
*}


<div class="bootstrap">
	<form class="form-horizontal col-xs-12" action="{$sURI|escape:'htmlall':'UTF-8'}" method="post" id="bt_local_iventorry" name="bt_local_iventorry" {if $useJs == true}onsubmit="javascript: oGmcPro.form('bt_local_iventorry', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_local_inventory_div', 'bt_local_inventory_div', false, false, '', 'LocalIventory', 'loadingAdvancedDiv');return false;" {/if}>
		<input type="hidden" name="sAction" value="{$aQueryParams.local_inventory.action|escape:'htmlall':'UTF-8'}" />
		<input type="hidden" name="sType" value="{$aQueryParams.local_inventory.type|escape:'htmlall':'UTF-8'}" />

		<h3 class="subtitle"><i class="fa fa-shopping-cart"></i>&nbsp;{l s='Local Product Inventory' mod='googlemerchantfeed'}</h3>
		<div class="clr_10"></div>
		{if !empty($bUpdate)}
			{include file="`$sConfirmInclude`"}
		{elseif !empty($aErrors)}
			{include file="`$sErrorInclude`"}
		{/if}

		<div class="alert alert-info">
			{l s='Promote the products in stock at your local store with the local product inventory feed.' mod='googlemerchantfeed'}&nbsp;<!--a class="badge badge-info" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/460" target="_blank"><i class="icon icon-link"></i>&nbsp;{l s='Learn more about Local Inventory Ads' mod='googlemerchantfeed'}</a-->
			<br /><br />
			{l s='Please read' mod='googlemerchantfeed'}&nbsp;<!--a class="badge badge-info" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/461" target="_blank"><i class="icon icon-link"></i>&nbsp;{l s='our FAQ' mod='googlemerchantfeed'}</a-->&nbsp;{l s='to know how to configure a local product inventory feed.' mod='googlemerchantfeed'}

		</div>
		<div class="form-group">
			<label class="control-label col-xs-12 col-md-3 col-lg-3">
				<span><b>{l s='Your store code:' mod='googlemerchantfeed'}</b></span></label>
			<div class="col-xs-4 col-md-4 col-lg-2">
				<input type="text" name="bt_store_code" value="{$sStoreCode|escape:'htmlall':'UTF-8'}" />
			</div>
			<!--a class="badge badge-info" href="{$faqUrl|escape:'htmlall':'UTF-8'}{$sFaqLang|escape:'htmlall':'UTF-8'}/faq/453" target="_blank"><i class="icon icon-link"></i>&nbsp;{l s='FAQ about store code' mod='googlemerchantfeed'}</a-->
		</div>

		<div class="form-group">
			<label class="control-label col-xs-12 col-md-3 col-lg-3">
				<span class="label-tooltip" title="{l s='Specify the store pickup option for your items.' mod='googlemerchantfeed'}"><b>{l s='Store pickup method' mod='googlemerchantfeed'}</b></span></label>
			<div class="col-xs-12 col-md-3 col-lg-2">
				<select name="bt_lia_pickup">';
						{foreach from=$aLiaPickup item=aPickUp}
							<option value="{$aPickUp.value|escape:'htmlall':'UTF-8'}"
						{if $aPickUp.value == $sLiaPikcup}selected="selected"
						{/if}>{$aPickUp.label|escape:'htmlall':'UTF-8'}</option>

					{/foreach}
					</select>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-xs-12 col-md-3 col-lg-3">
					<span class="label-tooltip" title="
					{l s='Specify the expected date that an order will be ready for pickup, relative to when the order is placed.' mod='googlemerchantfeed'}"><b>
					{l s='Store pickup timeline' mod='googlemerchantfeed'}</b></span></label>
				<div class="col-xs-12 col-md-3 col-lg-2">
					<select name="bt_lia_pickup_sla">';
						{foreach from=$aLiaPickupSla item=aPickUpSla}
							<option value="{$aPickUpSla.value|escape:'htmlall':'UTF-8'}" {if $aPickUpSla.value == $sLiaPikcupSla}selected="selected" {/if}>{$aPickUpSla.label|escape:'htmlall':'UTF-8'}</option>
						{/foreach}
					</select>
				</div>
			</div>

			<div class="navbar navbar-default navbar-fixed-bottom text-center">
				<div class="col-xs-12">
					<button class="btn btn-submit" onclick="oGmcPro.form('bt_local_iventorry', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_local_inventory_div', 'bt_local_inventory_div', false, false, '', 'LocalIventory', 'loadingAdvancedDiv', false, 1);return false;">{l s='Save' mod='googlemerchantfeed'}</button>
				</div>
			</div>
		</form>
	</div>