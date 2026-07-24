<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Xml;

if (!defined('_PS_VERSION_')) {
    exit;
}
class xmlGenerateDiscount extends baseXml
{
    /**
     * @param array $aParams
     */
    public function __construct($aParams = [])
    {
        $this->data = new \stdClass();
        $this->sContent = '';
        $this->aParams = $aParams;
        $this->bOutput = 1;
    }

    /**
     * get the XML for current data feed type
     */
    public function generate()
    {
        $aAssign = [];

        $oDiscountXml = new xmlDiscount();

        $aParams = [
            'iLangId' => !empty(\Tools::getValue('gmcp_lang_id')) ? \Tools::getValue('gmcp_lang_id') : \Tools::getValue('id_lang'),
            'bOutput' => 1,
            'sType' => \Tools::getValue('feed_type'),
        ];

        // set the header
        $oDiscountXml->header($aParams);

        $oDiscountXml->buildDiscountXml($aParams);

        // set footer
        $oDiscountXml->footer($aParams);

        return [
            'tpl' => 'admin/feed-generate-output.tpl',
            'assign' => $aAssign,
        ];
    }
}
