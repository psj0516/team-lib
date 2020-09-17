$(document).ready(function() {
$('.sub-menu').find('a[href="' + document.location.pathname + '"]').parents('li').addClass('active');
});