$(function(){
    window.Game = Backbone.Model.extend({
        defaults: {
            name: ''
        },

        initialize: function(){
        // _.bindAll(this, []);
        }
    });
    window.GamesView = Backbone.View.extend({
        initialize: function(){
            //_.bindAll(this, []);
            $(".sidebar_location_filter").jstree({
                "themes" : {
                    "theme" : "apple",
                    "dots" : false,
                    "icons": false
                },
                core : {
                    "initially_open" : [ "root_country" ]
                },
                plugins : [ "themes", "html_data" ]
            });
            $(".sidebar_location_filter").show();
        }
    });
    gamesView = new GamesView();
});