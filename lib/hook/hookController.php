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
class hookController
{
    /**
     * @var obj : defines hook object to display
     */
    private $oHook;

    /**
     * Magic Method __construct instantiate the matching hook class
     *
     * @param string $sType : type of interface to execute
     * @param string $sAction
     *
     * @throws
     */
    public function __construct($sType, $sAction)
    {
        if ($sType == 'display') {
            $this->oHook = new hookDisplay($sAction);
        } elseif ($sType == 'action') {
            $this->oHook = new hookAction($sAction);
        } else {
            return '';
        }
    }

    /**
     * method execute hook
     *
     * @category hook collection
     *
     * @param array $aParams
     *
     * @return array $aDisplay : empty => false / not empty => true
     */
    public function run(array $aParams = null)
    {
        return $this->oHook->run($aParams);
    }
}
