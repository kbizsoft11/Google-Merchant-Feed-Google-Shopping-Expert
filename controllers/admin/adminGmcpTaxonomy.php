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

use Configuration;
use Context;
use Language;
use Media;
use Tools;
use GoogleMerchantFeed\Configuration\moduleConfiguration;
use GoogleMerchantFeed\Dao\moduleDao;
use GoogleMerchantFeed\Models\categoryTaxonomy;
use GoogleMerchantFeed\Models\googleTaxonomy;
use GoogleMerchantFeed\ModuleLib\moduleTools;

class AdminGmcpTaxonomyController extends \ModuleAdminController
{
    /**
     * Initialize content
     *
     * @return void
     */
    public function initContent()
    {
        parent::initContent();

        $isoLang = Tools::getValue('sLangIso');

        if (empty($isoLang)) {
            Tools::redirect(Context::getContext()->link->getAdminLink('AdminModules') . '&configure=googlemerchantfeed&tab=taxonomies');
        }

        $langIsoParts = explode('-', $isoLang);
        $idLang = Language::getIdByIso($langIsoParts[0]);

        // Fallback to default shop language if the specific language ID is not found
        if (empty($idLang)) {
            $idLang = (int) Configuration::get('PS_LANG_DEFAULT');
        }

        // Define JavaScript variables for the front-end
        $jsDefinitions = [
            'taxonomyController' => $this->context->link->getAdminLink('AdminGmcpTaxonomy') . '&iLangId=' . $idLang . '&sLangIso=' . $isoLang,
        ];
        Media::addJsDef(['btGmcp' => $jsDefinitions]);

        $shopCategories = moduleDao::getShopCategories(
            \GoogleMerchantFeed::$iShopId, 
            $idLang, 
            \GoogleMerchantFeed::$conf['GMCP_HOME_CAT_ID'], 
            \GoogleMerchantFeed::$conf['GMCP_HOME_CAT']
        );

        foreach ($shopCategories as &$category) {
            $googleCategoryData = categoryTaxonomy::getGoogleCategories(
                \GoogleMerchantFeed::$iShopId, 
                $category['id_category'], 
                $isoLang
            );

            $category['google_category_name'] = !empty($googleCategoryData['txt_taxonomy']) 
                ? str_replace('\"', '', json_decode($googleCategoryData['txt_taxonomy'])) 
                : '';
        }
        unset($category); // Break reference to prevent accidental modifications

        $this->context->smarty->assign([
            'moduleUrl' => Context::getContext()->link->getAdminLink('AdminModules') . '&configure=googlemerchantfeed&tab=taxonomies',
            'idLang' => $idLang,
            'isoLang' => $isoLang,
            'currencyIso' => Language::getIsoById(\GoogleMerchantFeed::$iCurrentLang),
            'maxPostVar' => ini_get('max_input_vars'),
            'shopCategories' => $shopCategories,
            'shopCategoriesCount' => count($shopCategories),
            'faqLink' => 'http://faq.kbizsoft.fr',
            'taxonomiesToImport' => moduleTools::getTaxonomiesToImport($isoLang),
            'sModuleName' => moduleConfiguration::GMCP_MODULE_SET_NAME,
            'content' => $this->content . $this->module->fetch('module:googlemerchantfeed/views/templates/admin/tab/taxonomies.tpl'),
        ]);

        // Handle AJAX autocomplete requests
        if (Tools::getValue('action') === 'autocomplete') {
            $this->processAutocomplete();
        }
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
        $this->addCss($moduleDir . 'css/taxonomie.css');
        $this->addCss($moduleDir . 'css/bootstrap4.css');
        $this->addJS($moduleDir . 'js/module.js');
        $this->addJS($moduleDir . 'js/taxonomies.js');
    }

    /**
     * Handle form submission and data processing
     *
     * @return void
     */
    public function postProcess()
    {
        $isoLang = Tools::getValue('sLangIso');

        // 1. Handle manual category mapping save
        if (Tools::isSubmit('save_btn')) {
            try {
                $langIsoParts = explode('-', $isoLang);
                $idLang = Language::getIdByIso($langIsoParts[0]) ?: (int) Configuration::get('PS_LANG_DEFAULT');
                $googleCategories = Tools::getValue('bt_google-cat');

                // Clear previous mappings
                if (categoryTaxonomy::deleteGoogleCategory(\GoogleMerchantFeed::$iShopId, $isoLang)) {
                    foreach ($googleCategories as $categoryId => $googleCategoryValue) {
                        if (!empty($googleCategoryValue)) {
                            categoryTaxonomy::insertGoogleCategory(
                                \GoogleMerchantFeed::$iShopId, 
                                (int) $categoryId, 
                                $googleCategoryValue, 
                                $isoLang
                            );
                        }
                    }
                }

                $this->confirmations[] = $this->module->l('The mapping of your categories to the official Google categories has been successfully updated.');
            } catch (\Exception $e) {
                $this->errors[] = $e->getMessage();
            }
        }

        // 2. Handle bulk taxonomy imports (GMC, FPA, or TKP)
        if (Tools::isSubmit('gmcTaxonomies') || Tools::isSubmit('fpaTaxonomies') || Tools::isSubmit('tkpTaxonomies')) {
            try {
                $moduleSource = '';

                if (Tools::isSubmit('gmcTaxonomies')) {
                    $moduleSource = 'gmcTaxonomies';
                } elseif (Tools::isSubmit('fpaTaxonomies')) {
                    $moduleSource = 'fpaTaxonomies';
                } elseif (Tools::isSubmit('tkpTaxonomies')) {
                    $moduleSource = 'tkpTaxonomies';
                }

                if (!empty($moduleSource)) {
                    $dataToImport = moduleTools::getTaxonomiesToImport($isoLang);

                    if (categoryTaxonomy::deleteGoogleCategory(\GoogleMerchantFeed::$iShopId, $isoLang)) {
                        if (!empty($dataToImport[$moduleSource])) {
                            foreach ($dataToImport[$moduleSource] as $data) {
                                $taxonomyValue = $data['txt_taxonomy'] ?? '';
                                
                                // Safely decode JSON if the value is a JSON string
                                if (is_string($taxonomyValue) && json_decode($taxonomyValue, true) !== null) {
                                    $taxonomyValue = str_replace('\"', '', json_decode($taxonomyValue));
                                }

                                categoryTaxonomy::insertGoogleCategory(
                                    \GoogleMerchantFeed::$iShopId, 
                                    (int) $data['id_category'], 
                                    $taxonomyValue, 
                                    $data['lang']
                                );
                            }
                        }
                    }
                    
                    $this->confirmations[] = $this->module->l('The mapping of your categories to the official Google categories has been successfully imported.');
                }
            } catch (\Exception $e) {
                $this->errors[] = $e->getMessage();
            }
        }
    }

    /**
     * Process taxonomy autocomplete search
     *
     * @return void
     */
    public function processAutocomplete()
    {
        $isoLang = Tools::getValue('sLangIso');
        $query = Tools::getValue('query');
        $words = explode(' ', $query);
        $taxonomyFound = [];

        if (strlen($query) >= 4) {
            $searchResults = googleTaxonomy::autocompleteSearch($isoLang, $words);
            
            if (!empty($searchResults) && is_array($searchResults)) {
                // Extract only the 'value' column efficiently
                $taxonomyFound = array_column($searchResults, 'value');
            }
        }

        exit(json_encode($taxonomyFound));
    }
}