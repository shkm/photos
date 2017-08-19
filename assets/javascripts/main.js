require('lightgallery.js')
require('lg-thumbnail.js')
require('lg-hash.js')

document.addEventListener("DOMContentLoaded", () => {
  lightGallery(document.querySelector('.gallery'), {
    selector: '.image',
    thumbnail: true,
    mode: 'lg-fade'
  })
})


