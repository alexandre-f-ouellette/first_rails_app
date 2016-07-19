function userFunctions() {
  $('.rating').raty( {path: '/assets/images', scoreName: 'comment[rating]'} );

  $('.rated').raty( { path: '/assets/images',
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    }
  });

  $('.image-zoom').elevateZoom();
}

$(document).on('ready page:load', userFunctions);
