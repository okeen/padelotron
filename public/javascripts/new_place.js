$(function() {
    window.Place = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this,
                'placeCreateSuccess',

                'placeCreateError',
                'geocode');
            //this.geocoder = new google.maps.Geocoder();
            $('form#new_place').bind('ajax:success', this.placeCreateSuccess);
            $('form#new_place').bind('ajax:error', this.placeCreateError);
        },
        geocode: function(e,response){
            var address = $("input#place_full_address")[0].value;
            console.log("Geocode: getting geocode for " + address);
            $.get('http://maps.googleapis.com/maps/api/geocode/json',
                 {
                    address: address,
                    sensor: false
                },
                function(a,b){
                    alert("jkh");
                },
                function(a,b){
                    alert("kdh");
                }
            );
//            this.geocoder.geocode({
//                'address':address,
//                'partialmatch':true },
//                function(response, status){
//                    console.log("Geocode: got info " + response);
//                }
//            );
            return false;
        },
        placeCreateSuccess: function(){},
        placeCreateError: function(){}
    });

    window.PlaceView = Backbone.View.extend({
        el: "#new_place",

        initialize: function(){
            _.bindAll(this, 'render','createGmapsPanel');
            var mapOptions = {
                zoom: 13,
                center: new google.maps.LatLng(43.35564,-8.389435)
            };
            this.createGmapsPanel(mapOptions);
            $('button#geocode').bind('click', this.model.geocode);
        },
        createGmapsPanel: function(mapOptions){
            this.map= new google.maps.Map($("#map")[0],mapOptions);
        },
        render: function(){
            return this;
        }
    });
    window.place = new Place();
    window.placeView = new PlaceView({
        model: window.place
    });
})