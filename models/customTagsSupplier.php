<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Models;

if (!defined('_PS_VERSION_')) {
    exit;
}
class customTagsSupplier extends \ObjectModel
{
    /** @var int id * */
    public $id_tag;

    /** @var int id_supplier * */
    public $id_supplier;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'gmf_tags_suppliers',
        'primary' => 'id_tag',
        'fields' => [
            'id_supplier' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
        ],
    ];
}
