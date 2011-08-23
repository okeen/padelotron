$(function() {
    window.Place = Backbone.Model.extend({
        defaults: {
            name: ''
        },
        initialize: function(){
            _.bindAll(this,
                'placeCreateSuccess',
                'placeCreateError');
            $('form#new_place').bind('ajax:success', this.placeCreateSuccess);
            $('form#new_place').bind('ajax:error', this.placeCreateError);
        },
        placeCreateSuccess: function(){},
        placeCreateError: function(){}
    });
    
    window.PlaceView = Backbone.View.extend({
        el: "ul#geocoded_results",
        places: [],
        
        initialize: function(){
            _.bindAll(this, 'render','createGmapsPanel', 'addGeocodedPlaceLink', 'geocode', 'addGeocodedPlaces', 'getGeocodeAttribute', 'setSelectedPlace');
            var mapOptions = {
                zoom: 13,
                center: new google.maps.LatLng(43.35564,-8.389435),
                 mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            this.createGmapsPanel(mapOptions);
            this.geocoder = new google.maps.Geocoder();
            $('button#geocode').bind('click', this.geocode);
            $('ul#geocoded_results li.geocoded_place a').live('click', this.setSelectedPlace, this);

        },
        addGeocodedPlaceLink: function(mapOptions){
        },
        createGmapsPanel: function(mapOptions){
            this.map= new google.maps.Map($("#map")[0],mapOptions);
        },
        render: function(){
            $(this.el).empty();
            for (var i=0; i< this.places.length; i++){
                var place = this.places[i];
                $(this.el).append("<li class='geocoded_place'><a>"+
                                    place.get("full_address")+
                                  "</a></li>");
            }
            return this;
        },
        setSelectedPlace: function(e, item){
            var place = _(placeView.places).find(function(p){
               return p.get("full_address") == $(e.target).html();
            });
            var coordinates = new google.maps.LatLng(place.get("latitude"), place.get("longitude"));
            this.map.panTo( coordinates );
            var marker = new google.maps.Marker( {position: coordinates, map: this.map } );
            $('input#place_state')[0].value = place.get('state');
            $('input#place_city')[0].value = place.get('city');
            $('input#place_country')[0].value = place.get('country');
            $('input#place_street')[0].value = place.get('street');
            $('input#place_latitude')[0].value = place.get('latitude');
            $('input#place_longitude')[0].value = place.get('longitude');
        },

        geocode: function(e,response){
            this.places = [];
            var address = $("input#place_full_address")[0].value;
            console.log("Geocode: getting geocode for " + address);
            this.geocoder.geocode({
                'address':address,
                'partialmatch':true
            }, this.addGeocodedPlaces);
            return false;
        },
        addGeocodedPlaces: function(results, status){
            console.log("Geocode: got response." );
            if (status == 'OK'){
                for (var i=0; i< results.length; i++){
                    console.log("Geocode: result#" +(i+1).toString() + " " + results[i].formatted_address);
                    var place = {
                        full_address: results[i].formatted_address,
                        latitude: results[i].geometry.location.lat(),
                        longitude: results[i].geometry.location.lng(),
                        country: this.getGeocodeAttribute("country", results[i]),
                        city: this.getGeocodeAttribute("locality", results[i]),
                        street:  this.getGeocodeAttribute("route", results[i]) + "," +  this.getGeocodeAttribute("street_number", results[i]),
                        state:  this.getGeocodeAttribute("administrative_area_level_1", results[i])
                    };
                    place.id = i;
                    place = new Place(place);
                    this.places.push(new Place(place));
                }
            }
            this.render();
        },
        getGeocodeAttribute: function(attr, geocode_result){
            var item = _(geocode_result.address_components)
                .find(function(attribute_object){
                    return _(attribute_object.types).include(attr);
                });
            if (item) return item.long_name;
            else return null;
        }
    });
    window.place = new Place();
    window.placeView = new PlaceView({
        model: window.place
    });
})