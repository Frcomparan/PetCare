const showGeneralMenu = () => {
  document.getElementById("general-menu").classList.toggle("show-menu");
};

const showUserMenu = () => {
  document.getElementById("session-menu").classList.toggle("show-menu");
};

const showNotifications = () => {
  document.getElementById("notifications-container").classList.toggle("show-menu");
};

const loadFile = (event) => {
  let img = document.getElementById('output');
  document.getElementById('add').style.display = 'none';
  img.src = URL.createObjectURL(event.target.files[0]);
  img.style.display = 'block';
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

const hideMenus = (event) => {
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
}

const hideNotifications = (event) => {
  let validation = (event.target.matches('.notification-menu') || event.target.matches('.fa-bell'));
  if (!validation) {
    let dropdowns = document.getElementById("notifications-container");
    if (dropdowns.classList.contains('show-menu')) {
      dropdowns.classList.remove('show-menu');
    }
  }
}

window.onclick = function(event) {
  hideMenus(event);
  hideNotifications(event);
};

const showDni = function () {
  select_location = document.getElementById("user_role");
  if (select_location.value == "host") {
    document.getElementById("hidden_div").style.display = "block";
  } else {
    document.getElementById("hidden_div").style.display = "none";
  }
};

 setVerified = (user) => {
   var csrf = document.querySelector('meta[name="csrf-token"]').content;
   var xhr = new XMLHttpRequest();
   xhr.open("PUT", "users/" + user);
   xhr.setRequestHeader("X-CSRF-Token", csrf);
   xhr.send();
   xhr.onload = function () {
     if (xhr.status != 204) {
       alert("Error");
     } else {
       alert("Operacion exitosa");
     }
   };
   xhr.onerror = function () {
     alert("NO CONNECTION");
   };
};

const loadDNI = (event) => {
  let img = document.getElementById('dni');
  document.getElementById('addDNI').style.display = 'none';
  img.src = URL.createObjectURL(event.target.files[0]);
  img.style.display = 'block';
};
