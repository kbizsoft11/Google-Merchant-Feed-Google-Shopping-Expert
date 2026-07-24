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
	<div  id="gmcp" class="bootstrap">
		<h3 class="text-center"><i class="fa fa-tags"></i>&nbsp; {l s='Products labeled' mod='googlemerchantfeed'}</h3>

		<div class="clr_hr"></div>
		<div class="clr_10"></div>

		{if !empty($aProduct)}
			<div class="alert alert-info">
				<p>{l s='The list below gives the products to which the label has been assigned.' mod='googlemerchantfeed'}</p>
			</div>
			<table class="table col-xs-12">
				<thead>
					<tr class="bt_tr_header text-center">
						<th class="text-center">{l s='ID' mod='googlemerchantfeed'}</th>
						<th class="text-center">{l s='Product name' mod='googlemerchantfeed'}</th>
					</tr>
				</thead>
				<tbody>
					{foreach from=$aProduct key=iKey item=product}
						<tr>
							<td class="text-center">{$product.id|escape:'htmlall':'UTF-8'}</td>
							<td class="text-center">{$product.name|escape:'htmlall':'UTF-8'}</td>
						</tr>
					{/foreach}
				</tbody>
			</table>
		{else}
			<div class="alert alert-warning">
				<p>{l s='No product matching' mod='googlemerchantfeed'}</p>
			</div>
		{/if}
	</div>

{/if}