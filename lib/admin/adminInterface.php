<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Admin;

if (!defined('_PS_VERSION_')) {
    exit;
}
interface adminInterface
{
    /**
     * process display or updating or etc ... admin
     *
     * @param string $sType => defines which method to execute
     * @param mixed $aParam => $_GET or $_POST
     *
     * @return bool
     */
    public function run($sType, array $aParam = null);
}
