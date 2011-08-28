$(function(){
    window.Game = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
            _.bindAll(this, []);
        }
    });
    window.GameView = Backbone.View.extend({
        el: "body",

        initialize: function(){
            _.bindAll(this, 'render', 'detectUserPositionAndpanMapTo');
            this.detectUserPositionAndpanMapTo();
            
        },
        detectUserPositionAndpanMapTo: function(){
            var lat_input = $('input.[name="playground_latitude"]')[0];
            var lng_input = $('input.[name="playground_longitude"]')[0];
            if (lat_input && lng_input){
                var coordinates = new google.maps.LatLng(
                parseFloat(lat_input.value),
                parseFloat(lng_input.value));
                var mapOptions = {
                    zoom: 13,
                    center: coordinates,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };
                this.map= new google.maps.Map($("#map")[0],mapOptions);
                marker = new google.maps.Marker( {
                        position: coordinates,
                        map: this.map
                    //title: place.get("full_address")
                });
            }
        }
    });
    gameView = new GameView();
});