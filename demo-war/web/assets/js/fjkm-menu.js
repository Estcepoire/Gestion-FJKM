$(document).ready(function(){
    
    /////// Prevent closing from click inside dropdown
    $('.dropdown-menu').on('click', function (e) {
        e.stopPropagation();
    });

    // Make it an accordion for smaller screens
    if ($(window).width() < 992) {
        
        // Close all inner dropdowns when parent is closed
        $('.navbar .dropdown').on('hidden.bs.dropdown', function () {
            // After dropdown is hidden, find all submenus
            $(this).find('.submenu').each(function(){
                // Hide every submenu as well
                $(this).css('display', 'none');
            });
        });

        $('.dropdown-menu a').on('click', function (e) {
            var nextEl = $(this).next('.submenu');
            if (nextEl.length) {
                // Prevent opening link if link needs to open dropdown
                e.preventDefault();
                
                console.log(nextEl);
                if (nextEl.css('display') == 'block') {
                    nextEl.css('display', 'none');
                } else {
                    nextEl.css('display', 'block');
                }
            }
        });
    }
    // End if window width
});
