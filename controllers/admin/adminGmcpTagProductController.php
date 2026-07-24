<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

use Context;
use Tools;
use GoogleMerchantFeed\Configuration\moduleConfiguration;
use GoogleMerchantFeed\Dao\moduleDao;
use GoogleMerchantFeed\Classes\featureCategoryTag;
use GoogleMerchantFeed\ModuleLib\moduleTools;

class AdminGmcpTagProductController extends ModuleAdminController
{
    /**
     * Initialize content
     *
     * @return void
     */
    public function initContent()
    {
        parent::initContent();

        $shopId = \GoogleMerchantFeed::$iShopId;
        $langId = \GoogleMerchantFeed::$iCurrentLang;
        $homeCatId = \GoogleMerchantFeed::$conf['GMCP_HOME_CAT_ID'];
        $homeCat = \GoogleMerchantFeed::$conf['GMCP_HOME_CAT'];

        $shopCategories = moduleDao::getShopCategories($shopId, $langId, $homeCatId, $homeCat);
        
        // Define default feature structure to avoid repetitive assignments and fix the duplicate 'adult' bug
        $defaultFeatures = [
            'material' => [],
            'pattern' => [],
            'agegroup' => [],
            'gender' => [],
            'adult' => [],
            'sizeType' => [],
            'sizeSystem' => [],
            'energy' => [],
            'energy_min' => [],
            'energy_max' => [],
            'shipping_label' => [],
            'unit_pricing_measure' => [],
            'base_unit_pricing_measure' => [],
            'excluded_destination' => [],
            'excluded_country' => [],
            'agegroup_product' => [],
            'gender_product' => [],
            'adult_product' => [],
        ];

        foreach ($shopCategories as &$category) {
            $features = featureCategoryTag::getFeaturesByCategory(
                $category['id_category'], 
                $shopId, 
                moduleConfiguration::GMCP_TABLE_PREFIX
            );

            if (!empty($features)) {
                $category['material'] = $features['material'] ?? [];
                $category['pattern'] = $features['pattern'] ?? [];
                $category['agegroup'] = $features['agegroup'] ?? [];
                $category['gender'] = $features['gender'] ?? [];
                $category['adult'] = $features['adult'] ?? [];
                $category['sizeType'] = $features['sizeType'] ?? [];
                $category['sizeSystem'] = $features['sizeSystem'] ?? [];
                $category['energy'] = $features['energy'] ?? [];
                $category['energy_min'] = $features['energy_min'] ?? [];
                $category['energy_max'] = $features['energy_max'] ?? [];
                $category['shipping_label'] = $features['shipping_label'] ?? [];
                $category['unit_pricing_measure'] = $features['unit_pricing_measure'] ?? [];
                $category['base_unit_pricing_measure'] = $features['base_unit_pricing_measure'] ?? [];
                $category['excluded_destination'] = !empty($features['excluded_destination']) ? explode(' ', $features['excluded_destination']) : [];
                $category['excluded_country'] = !empty($features['excluded_country']) ? explode(' ', $features['excluded_country']) : [];
                $category['agegroup_product'] = $features['agegroup_product'] ?? [];
                $category['gender_product'] = $features['gender_product'] ?? [];
                $category['adult_product'] = $features['adult_product'] ?? [];
            } else {
                $category = array_merge($category, $defaultFeatures);
            }
        }
        unset($category); // Break reference to prevent accidental modifications

        $tagType = Tools::getValue('tag', 'material');
        $redirectTab = ($tagType === 'adult') ? 'adult' : 'appreal';
        
        $availableLanguages = moduleTools::getAvailableLanguages($shopId);
        $countries = moduleTools::getLangCurrencyCountry($availableLanguages, moduleConfiguration::GMCP_AVAILABLE_COUNTRIES);
        
        // Simplified country extraction using native PHP functions
        $handledCountries = array_unique(array_column($countries, 'countryIso'));

        // Combined into a single, clean assignment
        $this->context->smarty->assign([
            'aShopCategories' => $shopCategories,
            'aFeatures' => \Feature::getFeatures($langId),
            'tagType' => $tagType,
            'useMaterial' => \GoogleMerchantFeed::$conf['GMCP_INC_MATER'],
            'usePattern' => \GoogleMerchantFeed::$conf['GMCP_INC_PATT'],
            'useGender' => \GoogleMerchantFeed::$conf['GMCP_INC_GEND'],
            'useAgegroup' => \GoogleMerchantFeed::$conf['GMCP_INC_AGE'],
            'useAdult' => \GoogleMerchantFeed::$conf['GMCP_INC_TAG_ADULT'],
            'bSizeType' => \GoogleMerchantFeed::$conf['GMCP_SIZE_TYPE'],
            'bSizeSystem' => \GoogleMerchantFeed::$conf['GMCP_SIZE_SYSTEM'],
            'bEnergy' => \GoogleMerchantFeed::$conf['GMCP_INC_ENERGY'],
            'bShippingLabel' => \GoogleMerchantFeed::$conf['GMCP_INC_SHIPPING_LABEL'],
            'bUnitpricingMeasure' => \GoogleMerchantFeed::$conf['GMCP_INC_UNIT_PRICING'],
            'bUnitBasepricingMeasure' => \GoogleMerchantFeed::$conf['GMCP_INC_B_UNIT_PRICING'],
            'bExcludedDest' => \GoogleMerchantFeed::$conf['GMCP_EXCLUDED_DEST'],
            'bExcludedCountry' => \GoogleMerchantFeed::$conf['GMCP_EXCLUDED_COUNTRY'],
            'useGenderProduct' => \GoogleMerchantFeed::$conf['GMCP_USE_GENDER_PRODUCT'],
            'useAgeGroupProduct' => \GoogleMerchantFeed::$conf['GMCP_USE_AGEGROUP_PRODUCT'],
            'useAdultProduct' => \GoogleMerchantFeed::$conf['GMCP_USE_ADULT_PRODUCT'],
            'useTag' => $tagType,
            'moduleUrl' => Context::getContext()->link->getAdminLink('AdminModules') . '&configure=googlemerchantfeed&tab=' . $redirectTab,
            'sModuleName' => moduleConfiguration::GMCP_MODULE_SET_NAME,
            'currentTagHandle' => $tagType,
            'aCountries' => $handledCountries,
            'content' => $this->content . $this->module->fetch('module:googlemerchantfeed/views/templates/admin/tab/tag.tpl'),
        ]);
    }

    /**
     * Initialize controller's media
     *
     * @param bool $isNewTheme
     * @return void
     */
    public function setMedia($isNewTheme = false)
    {
        parent::setMedia($isNewTheme);

        $moduleDir = _MODULE_DIR_ . $this->module->name . '/views/';
        
        $this->addCss($moduleDir . 'css/admin.css');
        $this->addCss($moduleDir . 'css/bootstrap4.css');
        $this->addJS($moduleDir . 'js/tag.js');
        $this->addJS($moduleDir . 'js/module.js');
        $this->addJS($moduleDir . 'js/feature_by_cat.js');
        $this->addJS($moduleDir . 'js/feedList.js');
        $this->addJS($moduleDir . 'js/custom_label.js');
    }

    /**
     * Handle form submission and data processing
     *
     * @return void
     */
    public function postProcess()
    {
        if (!Tools::isSubmit('save_btn')) {
            return;
        }

        try {
            $tagMode = Tools::getValue('set_tag_mode');
            $tagType = Tools::getValue('tag');

            // Streamlined configuration update logic
            $configMap = [
                'gender' => 'GMCP_USE_GENDER_PRODUCT',
                'agegroup' => 'GMCP_USE_AGEGROUP_PRODUCT',
                'adult' => 'GMCP_USE_ADULT_PRODUCT',
            ];

            if (isset($configMap[$tagType])) {
                $configValue = ($tagMode === 'product_data') ? 1 : 0;
                \Configuration::updateValue($configMap[$tagType], $configValue);
            }

            $categoriesToUpdate = [];
            $tagList = moduleConfiguration::GMCP_TAG_LIST;

            foreach ($tagList as $tagKey) {
                $tagValues = Tools::getValue($tagKey);
                if (!empty($tagValues) && is_array($tagValues)) {
                    foreach ($tagValues as $categoryId => $value) {
                        $categoriesToUpdate[$categoryId][$tagKey] = strip_tags($value);
                    }
                }
            }

            // Clean existing data
            featureCategoryTag::cleanTable(\GoogleMerchantFeed::$iShopId, moduleConfiguration::GMCP_TABLE_PREFIX);

            $isSaved = false;
            if (!empty($categoriesToUpdate)) {
                foreach ($categoriesToUpdate as $categoryId => $features) {
                    $featureCategory = new featureCategoryTag();
                    $featureCategory->id_cat = (int) $categoryId;
                    $featureCategory->values = moduleTools::handleSetConfigurationData($features);
                    $featureCategory->id_shop = (int) \GoogleMerchantFeed::$iShopId;
                    
                    if ($featureCategory->add()) {
                        $isSaved = true;
                    }
                }
            }

            if ($isSaved) {
                $this->confirmations[] = $this->module->l('Settings updated');
                Tools::redirect(Context::getContext()->link->getAdminLink('AdminGmcpTagProduct') . '&tag=' . $tagType);
            }
        } catch (\Exception $e) {
            $this->errors[] = $e->getMessage();
        }
    }
}