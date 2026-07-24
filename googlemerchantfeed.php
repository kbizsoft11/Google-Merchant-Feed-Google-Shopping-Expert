<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 * @version 1.0.0
 */

if (!defined('_PS_VERSION_')) { 
    exit; 
}

require_once dirname(__FILE__) . '/vendor/autoload.php';

use GoogleMerchantFeed\Admin\baseController;
use GoogleMerchantFeed\Configuration\moduleConfiguration;
use GoogleMerchantFeed\Hook\hookController;
use GoogleMerchantFeed\Install\installController;
use GoogleMerchantFeed\ModuleLib\moduleTools;
use GoogleMerchantFeed\ModuleLib\moduleUpdate;
use GoogleMerchantFeed\ModuleLib\moduleWarning;

class GoogleMerchantFeed extends Module
{
    public static $conf = [];
    public static $iCurrentLang;
    public static $sCurrentLang;
    public static $oCookie;
    public static $oModule;
    public static $sQueryMode;
    public static $sBASE_URI;
    public static $sHost = '';
    public static $iShopId = 1;
    public static $bCompare17 = true;  // Min version is 1.7.6.0, so this is always true
    public static $bCompare1730 = false;
    public static $bCompare1770 = false;
    public static $bCompare80 = false;
    public static $oContext;
    public static $aAvailableLanguages = [];
    public static $bAdvancedPack = false;
    public static $shopReviewsModule = false;
    public static $gremarketingModule = false;
    public static $aAvailableLangCurrencyCountry = [];
    public static $sFilePrefix = '';
    
    /** @var array */
    public $aErrors = [];

    public function __construct()
    {
        $this->name = 'googlemerchantfeed';
        $this->tab = 'seo';
        $this->version = '1.0.0';
        $this->author = 'Kbizsoft';
        $this->ps_versions_compliancy = ['min' => '1.7.6.0', 'max' => _PS_VERSION_];
        $this->bootstrap = true; // Always true since min version is 1.7.6.0

        parent::__construct();

        $this->displayName = $this->l('Google Merchant Feed | Google Shopping Expert');
        $this->description = $this->l('Google Merchant Feed: Take Full Control of Your Product Data, Reviews, Promotions, Google Customer Reviews, and More!');
        $this->confirmUninstall = $this->l('Are you sure you want to uninstall the module Google Shopping Export PRO (Google Shopping)?');

        $this->initStaticProperties();
    }

    /**
     * Initialize static properties safely and cleanly
     */
    private function initStaticProperties()
    {
        self::$bCompare1730 = version_compare(_PS_VERSION_, '1.7.3.0', '>=');
        self::$bCompare1770 = version_compare(_PS_VERSION_, '1.7.7.0', '>=');
        self::$bCompare80 = version_compare(_PS_VERSION_, '8.0.0', '>=');

        self::$oContext = $this->context;
        self::$iShopId = (int) self::$oContext->shop->id;
        self::$oCookie = self::$oContext->cookie;
        self::$iCurrentLang = (int) self::$oCookie->id_lang;
        self::$sCurrentLang = moduleTools::getLangIso();
        self::$oModule = $this;
        self::$sBASE_URI = $this->_path;
        self::$sHost = moduleTools::setHost();
        
        self::$bAdvancedPack = moduleTools::isInstalled('pm_advancedpack');
        self::$shopReviewsModule = moduleTools::isInstalled('gsnippetsreviews', [], true, false);
        self::$gremarketingModule = moduleTools::isInstalled('gremarketing');

        moduleTools::getConfiguration([
            'GMCP_COLOR_OPT', 'GMCP_SIZE_OPT', 'GMCP_SHIP_CARRIERS', 'GMCP_CHECK_EXPORT', 
            'GMCP_CHECK_EXPORT_STOCK', 'GMCP_FEED_TAX', 'GMCP_FREE_PROD_PRICE_SHIP_CARRIERS', 
            'GMCP_NO_TAX_SHIP_CARRIERS', 'GMCP_FREE_SHIP_CARRIERS'
        ]);

        self::$aAvailableLanguages = moduleTools::getAvailableLanguages(self::$iShopId);
        self::$aAvailableLangCurrencyCountry = moduleTools::getLangCurrencyCountry(
            self::$aAvailableLanguages, 
            moduleConfiguration::GMCP_AVAILABLE_COUNTRIES
        );
        
        self::$sQueryMode = \Tools::getValue('sMode');
    }

    /**
     * Install all mandatory structure (DB, Files, Hooks)
     *
     * @return bool
     */
    public function install()
    {
        return parent::install()
            && installController::run('install', 'sql', moduleConfiguration::GMCP_PATH_SQL . moduleConfiguration::GMCP_INSTALL_SQL_FILE)
            && installController::run('install', 'config', ['bConfigOnly' => true]);
    }

    /**
     * Uninstall all mandatory structure (DB, Files)
     *
     * @return bool
     */
    public function uninstall()
    {
        return parent::uninstall()
            && installController::run('uninstall', 'config');
    }

    /**
     * Manage all data in Back Office
     *
     * @return string
     */
    public function getContent()
    {
        try {
            self::$sFilePrefix = moduleTools::setXmlFilePrefix();
            
            // Simplified controller type resolution using modern null coalescing fallback
            $sControllerType = \Tools::getValue(moduleConfiguration::GMCP_PARAM_CTRL_NAME, 'admin');
            $oCtrl = baseController::get($sControllerType);
            $aDisplay = $oCtrl->run(array_merge($_GET, $_POST));

            if (!empty($aDisplay)) {
                $aDisplay['assign'] = array_merge($aDisplay['assign'] ?? [], [
                    'oJsTranslatedMsg' => moduleTools::jsonEncode(moduleConfiguration::getJsMessage()),
                    'bAddJsCss' => true,
                ]);

                $sContent = $this->displayModule($aDisplay['tpl'], $aDisplay['assign']);

                if (!empty(self::$sQueryMode)) {
                    echo $sContent;
                    exit;
                }
                return $sContent;
            }
            
            throw new \Exception('Action returns empty content', 110);
        } catch (\Exception $e) {
            $this->aErrors[] = ['msg' => $e->getMessage(), 'code' => $e->getCode()];
            $sContent = $this->displayErrorModule();

            if (!empty(self::$sQueryMode)) {
                echo $sContent;
                exit;
            }
            return $sContent;
        }
    }

    /**
     * Hook: Display customized module content on header
     *
     * @return string
     */
    public function hookDisplayHeader()
    {
        return $this->execHook('display', 'header');
    }

    /**
     * Execute and display selected hook content
     *
     * @param string $sHookType
     * @param string $sAction
     * @param array $aParams
     *
     * @return string
     */
    private function execHook($sHookType, $sAction, array $aParams = [])
    {
        try {
            $bUseCache = false;
            $cacheId = null;

            if (!empty($aParams['cache']) && !empty($aParams['template']) && !empty($aParams['cacheId'])) {
                $cacheId = $this->getCacheId($aParams['cacheId']);
                $bUseCache = $this->isCached($aParams['template'], $cacheId);
            }

            if (!$bUseCache) {
                $oHook = new hookController($sHookType, $sAction);
                $aDisplay = $oHook->run($aParams);
            } else {
                $aDisplay = [
                    'tpl' => $aParams['template'],
                    'assign' => []
                ];
            }

            if (!empty($aDisplay)) {
                return $this->displayModule(
                    $aDisplay['tpl'], 
                    $aDisplay['assign'] ?? [], 
                    $bUseCache, 
                    $aParams['cacheId'] ?? null
                );
            }
            
            throw new \Exception('Chosen hook returned empty content', 110);
        } catch (\Exception $e) {
            $this->aErrors[] = ['msg' => $e->getMessage(), 'code' => $e->getCode()];
            return $this->displayErrorModule();
        }
    }

    /**
     * Custom error handler
     *
     * @param int $iErrno
     * @param string $sErrstr
     * @param string $sErrFile
     * @param int $iErrLine
     * @param array $aErrContext
     *
     * @return string
     */
    public function setErrorHandler($iErrno, $sErrstr, $sErrFile, $iErrLine, $aErrContext)
    {
        $errorTypes = [
            E_USER_ERROR => 'Fatal error',
            E_USER_WARNING => 'Warning',
            E_USER_NOTICE => 'Notice',
        ];

        $typeLabel = $errorTypes[$iErrno] ?? 'Unknown error';

        $this->aErrors[] = [
            'msg' => "{$typeLabel} <b>{$sErrstr}</b>",
            'code' => $iErrno,
            'file' => $sErrFile,
            'line' => $iErrLine,
            'context' => $aErrContext,
        ];

        return $this->displayErrorModule();
    }

    /**
     * Display views
     *
     * @param string $sTplName
     * @param array $aAssign
     * @param bool $bUseCache
     * @param int|null $iICacheId
     *
     * @return string HTML
     */
    public function displayModule($sTplName, $aAssign, $bUseCache = false, $iICacheId = null)
    {
        $aAssign = array_merge($aAssign, [
            'sModuleName' => \Tools::strtolower(moduleConfiguration::GMCP_MODULE_NAME),
            'bDebug' => moduleConfiguration::GMCP_DEBUG,
        ]);

        self::$oContext->smarty->assign($aAssign);
        $tplPath = 'views/templates/' . $sTplName;

        if ($bUseCache && $iICacheId !== null) {
            return $this->display(__FILE__, $tplPath, $this->getCacheId($iICacheId));
        }

        return $this->display(__FILE__, $tplPath);
    }

    /**
     * Display view with error
     *
     * @return string HTML
     */
    public function displayErrorModule()
    {
        self::$oContext->smarty->assign([
            'sHomeURI' => moduleTools::truncateUri(),
            'aErrors' => $this->aErrors,
            'sModuleName' => \Tools::strtolower(moduleConfiguration::GMCP_MODULE_NAME),
            'bDebug' => moduleConfiguration::GMCP_DEBUG,
        ]);

        return $this->display(__FILE__, 'views/templates/' . moduleConfiguration::GMCP_TPL_HOOK_PATH . 'error.tpl');
    }

    /**
     * Update module as necessary
     *
     * @return array
     */
    public function updateModule()
    {
        moduleWarning::create()->run('module', 'gmerchantcenter', [], true);
        $updater = moduleUpdate::create();

        // Batch standard updates to avoid repeated instantiation
        $standardUpdates = [
            'tables', 'fields', 'templates', 'hooks', 'module_update', 
            'moduleAdminTab', 'secureTaxonomies', 'feedsDatabaseMigration'
        ];

        foreach ($standardUpdates as $update) {
            $updater->run($update);
        }

        $updater->run('configuration', ['languages']);
        $updater->run('configuration', ['color']);
        $updater->run('configuration', ['size']);
        
        // Initialize XML files
        $updater->run('xmlFiles', ['aAvailableData' => self::$aAvailableLangCurrencyCountry]);

        $aErrors = $updater->getErrors();

        // Fixed logical flaw: Stop execution if there ARE errors, not if they are empty
        if (!empty($aErrors)) {
            moduleWarning::create()->bStopExecution = true;
        }

        return $aErrors;
    }
}