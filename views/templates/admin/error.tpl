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
<div class="clr_20"></div>

<div class="alert alert-danger">
	<button type="button" class="close" data-dismiss="alert">×</button>
	{foreach from=$aErrors name=condition key=nKey item=aError}
	<strong>{$aError.msg|escape:'htmlall':'UTF-8'}</strong><br/>
	{if $bDebug == true}
	<ol>
		{if !empty($aError.code)}<li>{l s='Error code' mod='googlemerchantfeed'} : {$aError.code|escape:'htmlall':'UTF-8'}</li>{/if}
		{if !empty($aError.file)}<li>{l s='Error file' mod='googlemerchantfeed'} : {$aError.file|escape:'htmlall':'UTF-8'}</li>{/if}
		{if !empty($aError.line)}<li>{l s='Error line' mod='googlemerchantfeed'} : {$aError.line|escape:'htmlall':'UTF-8'}</li>{/if}
		{if !empty($aError.context)}<li>{l s='Error context' mod='googlemerchantfeed'} : {$aError.context|escape:'htmlall':'UTF-8'}</li>{/if}
	</ol>
		{if !empty($aError.howTo)}
			<strong>{$aError.howTo|escape:'htmlall':'UTF-8'}</strong><br/><br/>
			<div class="clr_hr_danger"></div>
			<div class="clr_10"></div>
		{/if}
	{/if}
	{/foreach}
</div>