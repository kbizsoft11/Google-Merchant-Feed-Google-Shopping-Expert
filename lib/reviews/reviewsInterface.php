<?php
/**
 * Google Shopping Export PRO
 *
 * @author    Kbizsoft
 * @copyright Kbizsoft
 * @license   see file: LICENSE.txt
 *
 
 */

namespace GoogleMerchantFeed\Reviews;

if (!defined('_PS_VERSION_')) {
    exit;
}
interface reviewsInterface
{
    /**
     * get the reviews
     *
     * @params int id of the lang
     *
     * @return array of reviews
     */
    public function getReviews($iLangId);

    /**
     * build a generic review tabs to be compatible with all reviews system
     *
     * @params array of reviews
     *
     * @param int $iLangId
     *
     * @return generic array of reviews
     */
    public function buildGenericReviewsArray(array $aReviews, $iLangId);
}
