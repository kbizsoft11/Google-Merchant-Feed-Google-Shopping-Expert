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
	{assign var=sep value="\n"}
	{foreach from=$aErrors name=condition key=nKey item=aError}
		{$aError.msg|escape:'htmlall':'UTF-8'}{$sep|escape:'htmlall':'UTF-8'}
		{if $bDebug == true}
			{if !empty($aError.code)}{l s='Error code' mod='googlemerchantfeed'} : {$aError.code|escape:'htmlall':'UTF-8'}{$sep|escape:'htmlall':'UTF-8'}{/if}
			{if !empty($aError.file)}{l s='Error file' mod='googlemerchantfeed'} : {$aError.file|escape:'htmlall':'UTF-8'}{$sep|escape:'htmlall':'UTF-8'}{/if}
			{if !empty($aError.line)}{l s='Error line' mod='googlemerchantfeed'} : {$aError.line|escape:'htmlall':'UTF-8'}{$sep|escape:'htmlall':'UTF-8'}{/if}
			{if !empty($aError.context)}{l s='Error context' mod='googlemerchantfeed'} : {$aError.context|escape:'htmlall':'UTF-8'}{$sep|escape:'htmlall':'UTF-8'}{/if}
		{/if}
	{/foreach}
{/if}