$(function() {
  var canvas = document.getElementById('canvas');
  var names = ['webgl'];

  for(var i = 0; i < names.length; i++ ){
    try{
      gl = canvas.getContext(names[i]);
    }
    catch(e){}
    if(gl) break;
  }

  if(gl!=null){
    alert ('webgl - enabled');
  }
});