// filtre table
/**
 * Sorts a HTML table.
 *
 * @param {HTMLTableElement} table The table to sort
 * @param {number} column The index of the column to sort
 * @param {boolean} asc Determines if the sorting will be in ascending
 */
// end filtre table
$(document).ready(function() {
    $('.dropdown-submenu').find('ul').hide();
    $('.dropdown-menu').hide();
});

$(".btn-export").click(function() {
    $(".export-block").toggleClass("inactive");
});

$('.dropdown-submenu > a.apj-menu-nouveau').on("click", function(e) {
    $(this).closest('.dropdown-submenu').siblings().find('ul').hide();
    $(this).next('ul').toggle();
    e.stopPropagation();
    e.preventDefault();
});

$(".btn-utilisateur").click(function() {
    $(".utilisateur-block").toggleClass("inactive");
});

function exprt(){
    var sourceDiv = document.getElementById('sourceDiv');
    var destinationDiv = document.getElementById('destinationDiv');
    destinationDiv.appendChild(sourceDiv);
}


