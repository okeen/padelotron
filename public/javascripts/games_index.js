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
            _.bindAll(this, ['updateTableData']);
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
            $('#games_table').dataTable({
                "bProcessing": true,
                "bServerSide": true,
                "sAjaxSource": "/games.json",
                "fnServerData": this.updateTableData
            } );
        },
        updateTableData: function( sSource, aoData, fnCallback){
            //add location filter params
            aoData= {
                q:{
                    "offset": aoData.iDisplayStart
                }
            } ;
            $.getJSON( sSource, aoData, function (json) {
                /* Do whatever additional processing you want on the callback, then tell DataTables */
                var data = {
                    "sEcho": 1,
                    "iTotalRecords": json.page_size,
                    "iTotalDisplayRecords": json.total,
                    "aaData": _(json.data).map(function(game_row){
                        if (game_row.playground)
                            return [
                                game_row.play_date,
                                game_row.playground.city,
                                game_row.playground.name,
                                game_row.team1.name,
                                game_row.team2.name
                            ];
                        else
                            return [
                                game_row.play_date,
                                "",
                                "",
                                game_row.team1.name,
                                game_row.team2.name
                            ];
                    })
                }
                fnCallback(data);
            } );
        }
    });
    gamesView = new GamesView();
});