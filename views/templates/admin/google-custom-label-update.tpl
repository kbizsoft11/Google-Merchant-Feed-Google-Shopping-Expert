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
	{if !empty($bUpdate)}
		<div class="alert alert-success">{l s='Your custom label configuration has been successfully updated.' mod='googlemerchantfeed'}</div>
	{elseif !empty($aErrors)}
		{include file="`$sErrorInclude`"}
	{/if}
</div>