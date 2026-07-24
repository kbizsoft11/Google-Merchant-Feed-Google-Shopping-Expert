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
class customLabelDynamicCategories extends \ObjectModel
{
    /** @var int id * */
    public $id_tag;

    /** @var int id_category * */
    public $id_category;

    /** @var int id_category * */
    public $id_shop;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = [
        'table' => 'gmf_tags_dynamic_categories',
        'primary' => 'id_tag',
        'fields' => [
            'id_tag' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
            'id_category' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
            'id_shop' => ['type' => self::TYPE_INT, 'validate' => 'isInt', 'required' => true],
        ],
    ];

    /**
     * insert dynamic category
     *
     * @param int $id_tag
     * @param int $id_category
     *
     * @return bool
     */
    public static function insertDynamicCat($id_tag, $id_category)
    {
        $tag = new customLabelDynamicCategories();
        $tag->id_tag = (int) $id_tag;
        $tag->id_category = (int) $id_category;
        $tag->id_shop = (int) \GoogleMerchantFeed::$iShopId;

        return $tag->add();
    }

    /**
     * clean value for dynamic category
     *
     * @param int $$id_tag
     *
     * @return bool
     */
    public static function deleteDynamicCat($id_tag)
    {
        try {
            return \Db::getInstance()->delete('gmf_tags_dynamic_categories', 'id_tag=' . (int) $id_tag);
        } catch (\Exception $e) {
            \PrestaShopLogger::addLog($e->getMessage(), 1, $e->getCode(), null, null, true);
        }
    }

    /**
     * category id  for the tag
     *
     * @param int $id_tag
     *
     * @return bool
     */
    public static function getDynamicCat($id_tag)
    {
        $data_output = [];

        $query = new \DbQuery();
        $query->select('*');
        $query->from('gmf_tags_dynamic_categories', 'ftdc');
        $query->where('ftdc.id_tag=' . (int) $id_tag);
        $query->where('ftdc.id_shop=' . (int) \GoogleMerchantFeed::$iShopId);

        $data_result = \Db::getInstance(_PS_USE_SQL_SLAVE_)->ExecuteS($query);

        if (!empty($data_result)) {
            foreach ($data_result as $category) {
                $data_output[] = $category['id_category'];
            }
        } else {
            $data_output = $data_result;
        }

        return $data_output;
    }
}
