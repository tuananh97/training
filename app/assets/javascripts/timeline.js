$(document).ready(function() {
  $('.slidetoggle').hide();
  $('.fill-slide').on('click', function(){
    var target = $(this).attr('id');
    localStorage.setItem('target', target);
    $(this).next('.slidetoggle').slideToggle();
    $('.slide-icon').toggleClass('fa-angle-up');
  });
});

window.onload = function() {
  var target = localStorage.getItem('target');
  if (target == 'user') {
    $('div[data-name="sub-menu-user"]').show();
  } else if(target == 'company') {
    $('div[data-name="sub-menu-company"]').show();
  }
};
