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
class customLabelDynamicNewProduct extends \ObjectModel
{
    /** @var int id * */
    public $id_tag;

    /** @var string from_date * */
    public $from_date;

    /** @var int id_product * */
    public $id_product;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'gmf_tags_dynamic_new_product',
        'primary' => 'id_tag',
        'fields' => [
            'id_tag' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
            'from_date' => ['type' => self::TYPE_STRING, 'validate' => 'isString', 'required' => false],
            'id_product' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
        ],
    ];

    /**
     * insert dynamic category
     *
     * @param int $id_tag
     * @param string $from_date
     * @param int $id_product
     *
     * @return bool
     */
    public static function insertDynamicNew($id_tag, $from_date, $id_product)
    {
        $tag = new customLabelDynamicNewProduct();
        $tag->id_tag = (int) $id_tag;
        $tag->from_date = \pSQL($from_date);
        $tag->id_product = (int) $id_product;

        return $tag->add();
    }

    /**
     * return id_product for the tag
     *
     * @param int $id_tag
     *
     * @return bool
     */
    public static function getDynamicNew($id_tag)
    {
        $query = new \DbQuery();
        $query->select('*');
        $query->from('gmf_tags_dynamic_new_product', 'ftnp');
        $query->where('ftnp.id_tag=' . (int) $id_tag);

        return \Db::getInstance(_PS_USE_SQL_SLAVE_)->getRow($query);
    }

    /**
     * clean value for dynamic categorie
     *
     * @param int $id_tag
     *
     * @return bool
     */
    public static function deleteDynamicNew($id_tag)
    {
        return \Db::getInstance()->delete('gmf_tags_dynamic_new_product', 'id_tag=' . (int) $id_tag);
    }
}
