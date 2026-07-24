<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Hook;

if (!defined('_PS_VERSION_')) {
    exit;
}
class hookAction extends hookBase
{
    /**
     * Magic Method __destruct
     *
     * @category hook collection
     */
    public function __destruct()
    {
    }

    /**
     * run() method execute hook
     *
     * @param array $aParams
     *
     * @return array
     */
    public function run(array $aParams = null)
    {
        // set variables
        $aDisplayHook = [];

        switch ($this->sHook) {
            default:
                break;
        }

        return $aDisplayHook;
    }
}
