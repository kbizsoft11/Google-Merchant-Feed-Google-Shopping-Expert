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
class exportCategories extends \ObjectModel
{
    /** @var int id_category * */
    public $id_category;

    /** @var int id of the shop * */
    public $id_shop;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'gmf_categories',
        'primary' => 'id_category',
        'fields' => [
            'id_category' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
            'id_shop' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
        ],
    ];

    /**
     *  clean the table for
     *
     * @param int $id_shop
     *
     * @return bool
     */
    public static function cleanTable($id_shop)
    {
        return \Db::getInstance()->delete('gmf_categories', 'id_shop=' . (int) $id_shop);
    }

    /**
     * method returns categories to export
     *
     * @param int $id_shop
     *
     * @return array
     */
    public static function getCategories($id_shop)
    {
        // set
        $categories = [];
        $query = new \DbQuery();
        $query->select('*');
        $query->from('gmf_categories', 'gc');
        $query->where('gc.id_shop=' . (int) $id_shop);

        $result = \Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($query);

        if (!empty($result)) {
            foreach ($result as $category) {
                $categories[] = $category['id_category'];
            }
        }

        return $categories;
    }
}
