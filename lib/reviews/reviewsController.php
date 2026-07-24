<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Reviews;

if (!defined('_PS_VERSION_')) {
    exit;
}
abstract class reviewsController
{
    /**
     * instantiate matched ctrl object
     *
     * @param string $sCtrlType
     * @param array $aParams
     *
     * @return obj ctrl type
     *
     * @throws Exception
     */
    public static function get($sCtrlType, array $aParams = null)
    {
        try {
            if (!empty($sCtrlType)) {
                $sCtrlType = strtolower($sCtrlType);

                if ($sCtrlType == 'gsnippetsreviews') {
                    return new reviewsGsnippets($aParams);
                } elseif ($sCtrlType == 'productcomments') {
                    return new reviewsProductcomments($aParams);
                } else {
                    return false;
                }
            }
        } catch (\Exception $e) {
            \PrestaShopLogger::addLog($e->getMessage(), 3, $e->getCode(), null, null, true);
        }
    }
}
