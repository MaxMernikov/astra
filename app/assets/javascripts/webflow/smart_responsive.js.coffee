tablet_h_breakpoint = 1200
tablet_breakpoint = 991
mobile_breakpoint = 767

width = $(window).width()

if width >= tablet_h_breakpoint
  url = 'desktopUrl'
else if width >= tablet_breakpoint
  url = 'tabletHUrl'
else if width >= mobile_breakpoint
  url = 'tabletUrl'
else
  url = 'mobileUrl'


$('.smart-responsive').each (index, element) =>
  el = $(element)
  data = el.data()

  el.attr('src', data[url])