$(function() {
    window.Player = Backbone.Model.extend({
        defaults: {
            name: ''
        },
        initialize: function(){
            _.bindAll(this,
                'playerUpdateSuccess',
                'playerUpdateError');
            $('form#player_location_form').bind('ajax:success', this.playerUpdateSuccess);
            $('form#player_location_form').bind('ajax:error', this.playerUpdateError);
        },
        playerUpdateSuccess: function(data, response){
            $("#player_location_form").hide();
            $("#player_full_address").html($("#place_city").val() + ", " +$("#place_country").val());


        },
        playerUpdateError: function(){}
    });
    
    window.PlayerView = Backbone.View.extend({
        el: "ul#geocoded_results",
        places: [],
        
        initialize: function(){
            _.bindAll(this, 'render','createGmapsPanel', 'showSetLocationPanel', 'geocode', 'addGeocodedPlaces', 'getGeocodeAttribute', 'setSelectedPlace');
           
            $('#change_user_location').bind('click', this.showSetLocationPanel);
            $('button#geocode').bind('click', this.geocode);
            $('ul#geocoded_results li.geocoded_place a').live('click', this.setSelectedPlace, this);

        },
        showSetLocationPanel: function(mapOptions){
            $("#player_location_form").show();
            this.createGmapsPanel(mapOptions);
            this.geocoder = new google.maps.Geocoder();
            $("#place_full_address").focus();
            $("#place_full_address").select();
            
        },
        createGmapsPanel: function(){
             var mapOptions = {
                zoom: 13,
                center: new google.maps.LatLng(43.35564,-8.389435),
                 mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            this.map= new google.maps.Map($("#map")[0],mapOptions);
        },
        render: function(){
            $(this.el).empty();
            for (var i=0; i< this.places.length; i++){
                var place = this.places[i];
                $(this.el).append("<li class='geocoded_place'><a>"+
                                    place.full_address+
                                  "</a></li>");
            }
            return this;
        },
        setSelectedPlace: function(e, item){
            var place = _(playerView.places).find(function(p){
               return p.full_address == $(e.target).html();
            });
            var coordinates = new google.maps.LatLng(place.latitude, place.longitude);
            this.map.panTo( coordinates );
            var marker = new google.maps.Marker( {position: coordinates, map: this.map } );
            $('input#place_state')[0].value = place.state;
            $('input#place_city')[0].value = place.city;
            $('input#place_country')[0].value = place.country;
            $('input#place_street')[0].value = place.street;
            $('input#place_latitude')[0].value = place.latitude;
            $('input#place_longitude')[0].value = place.longitude;
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
                    this.places.push(place);
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
    window.player = new Player();
    window.playerView = new PlayerView({
        model: window.player
    });
})