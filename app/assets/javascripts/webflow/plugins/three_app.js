// $(function () {
//   var scene = new THREE.Scene();
//   var aspect = window.innerWidth / window.innerHeight;
//   var camera = new THREE.PerspectiveCamera( 75, aspect, 0.1, 1000 );
//   var renderer = new THREE.WebGLRenderer();
//   renderer.setSize( window.innerWidth, window.innerHeight );
//   document.body.appendChild( renderer.domElement );

//   var geometry = new THREE.BoxGeometry( 1, 1, 1 );
//   var material = new THREE.MeshNormalMaterial();
//   var cube = new THREE.Mesh( geometry, material );
//   cube.position.x = -5;

//   scene.add( cube );
//   camera.position.z = 5;

//   // var colorMap = THREE.ImageUtils.loadTexture( "assets/webflow/plugins/three_js/Head.bmp" );
//   // var normalMap = THREE.ImageUtils.loadTexture( "assets/webflow/plugins/three_js/Head.bmp" );

//   var colorMap = THREE.ImageUtils.loadTexture( "assets/webflow/plugins/three_js/skull-color.jpg" );
//   var normalMap = THREE.ImageUtils.loadTexture( "assets/webflow/plugins/three_js/skull-normal.jpg" );

//   var material = new THREE.MeshPhongMaterial( { map: colorMap, shading: THREE.SmoothShading } );
//   // var material = new THREE.SpriteMaterial( { map: colorMap } );

//   var loader = new THREE.JSONLoader();
  
//   loader.load("assets/webflow/plugins/three_js/head.json", function( geometry, materials ) {
//   // loader.load("assets/webflow/plugins/three_js/skull-morph.json", function( geometry, materials ) {

//     // console.log(materials);
//     // material = new THREE.MeshNormalMaterial( materials );
//     // material = new THREE.MeshLambertMaterial({ shading: THREE.SmoothShading });

//     mesh = new THREE.Mesh( geometry, material );
//     mesh.position.z = 1.9;
//     mesh.position.y = -1.2;

//     // scene.add( mesh );
//   });

//   // 

//   controls = new THREE.OrbitControls( camera );

//   light = new THREE.DirectionalLight( 0xdddddd, 0.9 );
//   light.position.z = 5;
//   scene.add( light );

//   var render = function () {
//     requestAnimationFrame( render );
//     cube.rotation.y += 0.01;
//     // cube.rotation.x += 0.1;

//     controls.update();

//     renderer.render( scene, camera );
//   };

//   render();

// });