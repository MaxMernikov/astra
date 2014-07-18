$( function() {
  set_size( 500 / $('.price_list').width() );

  $( window ).resize(function() {
    set_size( 500 / $('.price_list').width() );
  })
});

function set_size(zoom_factor){
  $('.price_list .cost').attr('style', 'font-size: ' + 73 / zoom_factor + 'px'  );
  $('.price_list .link').attr('style', 'font-size: ' + 26 / zoom_factor + 'px'  );
  $('.area2').attr('coords', 138/zoom_factor + ',' + 70/zoom_factor + ',' + 139/zoom_factor + ',0,' + 500/zoom_factor + ',0,' + 500/zoom_factor + ',' + 500/zoom_factor + ',0,' + 500/zoom_factor + ',0,0,' + 138/zoom_factor + ',0,' + 139/zoom_factor + ',' + 69/zoom_factor + ',' + 37/zoom_factor + ',' + 408/zoom_factor + ',' + 466/zoom_factor + ',' + 354/zoom_factor);
}