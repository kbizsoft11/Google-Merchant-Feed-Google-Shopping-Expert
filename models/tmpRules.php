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
class tmpRules extends \ObjectModel
{
    /** @var int id_brands * */
    public $id_shop;

    /** @var string values * */
    public $type;

    // ** @var string values **/
    public $exclusion_values;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'gmf_tmp_rules',
        'primary' => 'id_cat',
        'fields' => [
            'id_shop' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
            'type' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
            'exclusion_values' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => true],
        ],
    ];

    /**
     * method add the exclusion rules
     *
     * @param int $id_shop
     * @param string $type
     * @param string $value
     *
     * @return bool
     */
    public static function addTmpRules($id_shop, $type, $value)
    {
        $tmp_rule = new tmpRules();
        $tmp_rule->id_shop = (int) $id_shop;
        $tmp_rule->type = \pSQL($type);
        $tmp_rule->exclusion_values = \pSQL($value);
        $tmp_rule->add();
    }

    /**
     * method returns the tmp rules
     *
     * @return array
     */
    public static function getTmpRules()
    {
        $query = new \DbQuery();
        $query->select('*');
        $query->from('gmf_tmp_rules', 'ftp');

        return \Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($query);
    }

    /**
     * clean the tmp rules
     *
     * @param int $id_shop
     *
     * @return bool
     */
    public static function cleanTmpRules($id_shop)
    {
        return \Db::getInstance()->delete('gmf_tmp_rules', 'id_shop=' . (int) $id_shop);
    }

    /**
     * delete a specific tmp rules
     *
     * @param int $id_rule
     *
     * @return bool
     */
    public static function deleteTmpRules($id_rule)
    {
        return \Db::getInstance()->delete('gmf_tmp_rules', 'id=' . (int) $id_rule . ' AND `id_shop` = ' . (int) \GoogleMerchantFeed::$iShopId);
    }

    /**
     * clean the tmp rules
     *
     * @return bool
     */
    public static function resetIncrement()
    {
        $sQuery = 'ALTER TABLE `' . _DB_PREFIX_ . 'gmf_tmp_rules` AUTO_INCREMENT = 1';

        return \Db::getInstance()->Execute($sQuery);
    }
}
