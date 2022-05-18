function photos(){
  const main_img = document.querySelector('.img-main')
  const thumbnails = document.querySelectorAll('.photo-secundary')

  thumbnails.forEach(thumb => {
    thumb.addEventListener('click', function(){
      const active = document.querySelector('.active')
      active.classList.remove('active')
      thumb.classList.add('active')
      main_img.src = thumb.src
    })
  })
}

function photosMobile(){
  const main_img = document.querySelector('.img-main')
  const back = document.querySelector('.back')
  const forward = document.querySelector('.forward')
  const buttons = document.querySelectorAll('.button-img')
  const thumbnails = document.querySelectorAll('.photo-secundary')
  let cont = 0;

  forward.addEventListener('click', function(){
    if(cont+1 != thumbnails.length){
      main_img.src = thumbnails[cont+1].src
      cont++;
    }
  })

  back.addEventListener('click', function(){
    if(cont != 0){
      main_img.src = thumbnails[cont-1].src
      cont--;
    }
  })
}
