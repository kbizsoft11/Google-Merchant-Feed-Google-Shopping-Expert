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
{if !empty($aErrors)}
{include file="`$sErrorInclude`"}
{* USE CASE - edition review mode *}
{else}
<div id="{$sModuleName|escape:'htmlall':'UTF-8'}" class="bootstrap">
	<div id="bt_google-category" class="col-xs-12">
		<div class="row">
			<div class="col-xs-6">
				<h3>{l s='Google product categories for the feed ' mod='googlemerchantfeed'}: {$sLangIso|escape:'htmlall':'UTF-8'}</h3>
			</div>
			<div class="col-xs-6">
				<div class="pull-right">
					<button class="btn btn-success btn-sm" onclick="oGmcPro.form('bt_form-google-cat', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_google-category', 'bt_google-category', false, true, null, 'GoogleCat', 'loadingGoogleCatDiv');return false;">{l s='Modify' mod='googlemerchantfeed'}</button>
					<button class="btn btn-danger btn-sm" value="{l s='Cancel' mod='googlemerchantfeed'}"  onclick="$.fancybox.close();return false;">{l s='Cancel' mod='googlemerchantfeed'}</button>
				</div>
			</div>
		</div>

		<div class="clr_hr"></div>
		<div class="clr_20"></div>

		<div class="alert alert-success">
			{l s='Instructions : for each of your shop categories, start to type keywords that represent the category, using as many words as you wish (simply separate each word by a space). A list of Google categories that could match with will appear, containing all the words you entered. Simply select the best match from the list.' mod='googlemerchantfeed'}
		</div>

		{if $iMaxPostVars != false && $iShopCatCount > $iMaxPostVars}
		<div class="alert alert-warning">
			{l s='Warning: apparently the number of variables that can be sent via a form is limited by your server, and the total number of your categories is greater than this maximum number of possible variables.' mod='googlemerchantfeed'} :<br/>
			<strong>{$iShopCatCount|escape:'htmlall':'UTF-8'}</strong>&nbsp;{l s='categories' mod='googlemerchantfeed'}</strong>&nbsp;{l s='out of' mod='googlemerchantfeed'}&nbsp;<strong>{$iMaxPostVars|escape:'htmlall':'UTF-8'}</strong>&nbsp;{l s='possible variables (PHP directive => max_input_vars)' mod='googlemerchantfeed'}<br/><br/>
			<strong>{l s='Not all your categories may be exported. For more information, please read' mod='googlemerchantfeed'}</strong>&nbsp;<a target="_blank" href="{$faqUrl|escape:'htmlall':'UTF-8'}faq.php?lg={$sCurrentIso|escape:'htmlall':'UTF-8'}&id=59">{l s='our FAQ' mod='googlemerchantfeed'}</a>
		</div>
		{/if}

		<div class="clr_20"></div>

		<form class="form-horizontal" method="post" id="bt_form-google-cat" name="bt_form-google-cat" {if $smarty.const._GSR_USE_JS == true}onsubmit="oGmcPro.form('bt_form-google-cat', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_google-category', 'bt_google-category', false, true, null, 'GoogleCat', 'loadingGoogleCatDiv');return false;"{/if}>
			<input type="hidden" name="{$sCtrlParamName|escape:'htmlall':'UTF-8'}" value="{$sController|escape:'htmlall':'UTF-8'}" />
			<input type="hidden" name="sAction" value="{$aQueryParams.googleCatUpdate.action|escape:'htmlall':'UTF-8'}" />
			<input type="hidden" name="sType" value="{$aQueryParams.googleCatUpdate.type|escape:'htmlall':'UTF-8'}" />
			<input type="hidden" name="sLangIso" value="{$sLangIso|escape:'htmlall':'UTF-8'}" />
			<input type="hidden" name="iLangId" value="{$iLangId|escape:'htmlall':'UTF-8'}" />

			<table class="table table-bordered">
				<thead>
					<th class="bt_tr_header text-center">{l s='Your shop category' mod='googlemerchantfeed'}</th>
					<th class="bt_tr_header text-center">{l s='Google category' mod='googlemerchantfeed'}</th>
				</thead>
				<tbody>
				{foreach from=$aShopCategories name=category item=aCategory}
					<tr>
						<td class="label_tag_categories">{$aCategory.path|escape:'quotes':'UTF-8'}</td>
						<td>
							<input class="autocmp" style="font-size: 11px; width: 800px;" type="text" name="bt_google-cat[{$aCategory.id_category|escape:'htmlall':'UTF-8'}]" id="bt_google-cat{$aCategory.id_category|escape:'htmlall':'UTF-8'}" value="{$aCategory.google_category_name|escape:'htmlall':'UTF-8'}" />
							<p class="duplicate_category">
								{if $smarty.foreach.category.first}
									<br /><a class="btn btn-sm pull-right btn-success" href="#" onclick="return oGmcPro.duplicateFirstValue('input.autocmp', $('#bt_google-cat{$aCategory.id_category|escape:'htmlall':'UTF-8'}').val());">{l s='Duplicate this value for all the categories below' mod='googlemerchantfeed'}</a>
								{/if}
							</p>
						</td>
					</tr>
				{/foreach}
				</tbody>
			</table>

			<div class="clr_20"></div>

			<div class="center">
				<button class="btn btn-success btn-lg" onclick="oGmcPro.form('bt_form-google-cat', '{$sURI|escape:'htmlall':'UTF-8'}', null, 'bt_google-category', 'bt_google-category', false, true, null, 'GoogleCat', 'loadingGoogleCatDiv');return false;">{l s='Modify' mod='googlemerchantfeed'}</button>
				<button class="btn btn-danger btn-lg" value="{l s='Cancel' mod='googlemerchantfeed'}"  onclick="$.fancybox.close();return false;">{l s='Cancel' mod='googlemerchantfeed'}</button>
			</div>
		</form>
		{literal}
		<script type="text/javascript">
			$('input.autocmp').each(function(index, element) {
				var query = $(element).attr("id");
				$(element).autocomplete('{/literal}{$sURI|escape:'javascript':'UTF-8'}&{$sCtrlParamName|escape:'htmlall':'UTF-8'}={$sController|escape:'htmlall':'UTF-8'}&sAction={$aQueryParams.autocomplete.action|escape:'htmlall':'UTF-8'}&sType={$aQueryParams.autocomplete.type|escape:'htmlall':'UTF-8'}&sLangIso={$sLangIso|escape:'htmlall':'UTF-8'}&query='+query{literal}, {

					minChars: 3,
					autoFill: false,
					max:50,
					matchContains: true,
					mustMatch:false,
					scroll:true,
					cacheLength:0,
					formatItem: function(item) {
						return item[0];
					}
				});
			});

			$("form").bind("keypress", function (e) {
				if (e.keyCode == 13) {
					return false;
				}
			});
		</script>
		{/literal}
	</div>
</div>
<div id="loadingGoogleCatDiv" style="display: none;">
	<div class="alert alert-info">
		<p style="text-align: center !important;"><img src="{$sLoadingImg|escape:'htmlall':'UTF-8'}" alt="Loading" /></p><div class="clr_20"></div>
		<p style="text-align: center !important;">{l s='Your configuration updating is in progress...' mod='googlemerchantfeed'}</p>
	</div>
</div>
{/if}