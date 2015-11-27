//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jcrop
//= require jquery.tagsinput
//= require jquery-ui/autocomplete

$('.js-tags').tagsInput({
  autocomplete_url: '/tags.json'
});

$.fn.image = function(src, f) {
  return this.each(function() {
    var i = new Image();
    i.src = src;
    i.onload = f;
    this.appendChild(i);
  });
};

var updateCoords = function(coords) {
  $('.js-crop-x').val(coords.x);
  $('.js-crop-y').val(coords.y);
  $('.js-crop-w').val(coords.w);
  $('.js-crop-h').val(coords.h);
};

var imgLoader = $(".js-img-loader");

imgLoader.image(imgLoader.data('tmp'), function() {
  imgLoader.children('img').Jcrop({
    setSelect: [0, 0, 400, 200],
    boxWidth: 500,
    onSelect: updateCoords,
    onChange: updateCoords
  });
});
