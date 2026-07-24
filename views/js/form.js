/*
*
* Google Shopping Export PRO
*
* @author      kbizsoft
* @copyright  Kbizsoft
* @license   Commercial
*
 
*
*/
document.addEventListener('DOMContentLoaded', function() {
    $('.label-tooltip, .help-tooltip').tooltip();


    // Use case to display the hour day cut off
    $("input[name='same_day_process']").bind('change', function(event) {
        if ($(this).val() == 1) {
            $('#same_day_hours').show();
            $('#not_same_day_hours').hide();
        } else {
            $('#same_day_hours').hide();
            $('#not_same_day_hours').show();
        }
    });

    $("input[name='activate_gcr']").bind('change', function(event) {
        if ($(this).val() == 1) {
            $('#gcr_option').show();
        } else {
            $('#gcr_option').hide();
        }
    });
});