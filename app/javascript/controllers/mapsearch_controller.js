import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["field", "latitude", "longitude"]

  connect() {
    if (typeof (google) != "undefined"){
      this.initializeMap()
    }
  }

  initializeMap() {
    this.autocomplete()
  }

  autocomplete() {
    if (this._autocomplete == undefined) {
      this._autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
      this._autocomplete.addListener('place_changed', this.locationChanged.bind(this))
    }
    return this._autocomplete
  }

  locationChanged() {
    let place = this.autocomplete().getPlace()

    if (!place.geometry) {
      // User entered the name of a Place that was not suggested and
      // pressed the Enter key, or the Place Details request failed.
      window.alert("No details available for input: '" + place.name + "'");
      return;
    }

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  preventSubmit(e) {
    if (e.key == "Enter") { e.preventDefault() }
  }


  searchNear(e) {
    e.preventDefault();

    var lat = this.latitudeTarget.value;
    var lon = this.longitudeTarget.value;

    if(this.latitudeTarget.value === "" && this.longitudeTarget.value === ""){
      window.alert("No details available for input");
      return;
    }

    var R = 3958.8; //Radius of earth
    const ids =[];

    var csrf = document.querySelector('meta[name="csrf-token"]').content;
    var xhttp = new XMLHttpRequest();
    
    xhttp.responseType = 'json';
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
          for (var i = 0; i < xhttp.response.length; i++){
            var obj = xhttp.response[i];
            var lat2 = obj["latitude"];
            var lon2 = obj["longitude"];
            var rlat1 = lat * (Math.PI/180); // Convert degrees to radians
            var rlat2 = lat2 * (Math.PI/180); // Convert degrees to radians
            var difflat = rlat2-rlat1; // Radian difference (latitudes)
            var difflon = (lon2-lon) * (Math.PI/180); // Radian difference (longitudes)
  
            var d = 2 * R * Math.asin(Math.sqrt(Math.sin(difflat/2)*Math.sin(difflat/2)+Math.cos(rlat1)*Math.cos(rlat2)*Math.sin(difflon/2)*Math.sin(difflon/2)));
            
            if( d <= 10)
            {
              ids.push(obj["id"]);
            }
          }
          if(ids.length === 0) {
            alert("No se encontraron Hogares cercanos");
            return;
          }
          document.getElementById("ids").value = ids;
          document.getElementById("search").submit();
       }
    };
    xhttp.open("GET", "/homes.json");
    xhttp.setRequestHeader("X-CSRF-Token", csrf);
    xhttp.send();

    xhttp.onload = function () {      
      if (xhttp.status != 200) {
         alert("Error");      
    xhttp.onerror = function () {
       alert("NO CONNECTION");
         };
      }
    }
  }

}
