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
		<div class="alert alert-success">{l s='Your tags have been updated' mod='googlemerchantfeed'}</div>
	{elseif !empty($aErrors)}
		{include file="`$sErrorInclude`"}
	{/if}
</div>

<div class="clr_hr"></div>
<div class="clr_20"></div>