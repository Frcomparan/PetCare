const showGeneralMenu = () => {
  document.getElementById("general-menu").classList.toggle("show-menu");
};

const showUserMenu = () => {
  document.getElementById("session-menu").classList.toggle("show-menu");
};

const loadFile = (event) => {
  let img = document.getElementById('output');
  document.getElementById('add').style.display = 'none';
  img.src = URL.createObjectURL(event.target.files[0]);
  img.style.display = 'block'
};

const loadFiles = (event) => {
  let container = document.getElementById('upload');
  document.getElementById('add').style.display = 'none';
  const uploadPhotos = event.target.files;
  if (document.getElementsByClassName('output').length > 0) {
    removeChilds(document.getElementsByClassName('output'));
  }
  addImages(uploadPhotos, container);
};

const removeChilds = (imgs) => {
  imgs = document.getElementsByClassName('output');
  let parent = imgs[0].parentNode;
  let size = imgs.length;
  for (let key = 0; key <= size; key++) {
    parent.removeChild(parent.lastChild);
  }
};

const addImages = (uploadPhotos, container) => {
  for (let key = 0; key < uploadPhotos['length']; key++) {
    let img = '<img class="photo output"/>';
    container.innerHTML = container.innerHTML + img;
    img = document.getElementsByClassName('output')
    img[key].src = URL.createObjectURL(uploadPhotos[key]);
    img[key].style.display = 'block'
  }
};

window.onclick = function(event) {
  let filter_validation = (event.target.matches('.filter-options') || event.target.matches('.fa-bars'));
  let user_validation = (event.target.matches('.user-options') || event.target.matches('.fa-user'));
  if (!(user_validation || filter_validation)) {
    let dropdowns = document.getElementsByClassName("menu");
    let i;
    for (i = 0; i < dropdowns.length; i++) {
      let openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show-menu')) {
        openDropdown.classList.remove('show-menu');
      }
    }
  }
};
