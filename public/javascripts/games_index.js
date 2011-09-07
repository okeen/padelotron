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
            $("#games_table tbody tr").live("click", this.showGameDetails);
            this.table=$('#games_table').dataTable({
               // "bJQueryUI": true,
                "sPaginationType": "full_numbers",
                "sDom": "rt",
                "bProcessing": true,
                "bServerSide": true,
                "sAjaxSource": "/games.json",
                "fnServerData": this.updateTableData,
                "fnRowCallback": function( nRow, aData, iDisplayIndex ) {
                        $(nRow).attr('id', aData[5]);
			return nRow;
		},
                "aoColumnDefs": [
                {
                    "sClass": "center",
                    "aTargets": [ 1 ]
                },
                {
                    "sClass": "center",
                    "aTargets": [ 2 ]
                },
                {
                    "aTargets": [ 3 ]
                },
                {
                    "sClass": "right",
                    "aTargets": [ 4 ]
                },
                {
                    "bVisible": false,
                    "aTargets": [ 5 ]
                }
                ]
            } );
        },
        showGameDetails: function(event, data){
            var gameId = event.target.parentNode.id;
            console.log("Games::Show details# " + gameId);
            $.when($.ajax("/games/"+gameId+".html")).then(function(response){
              gamesView.table.fnOpen(event.target.parentNode, response, "Game Info" ) ;
            });
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
               gamesView.data = json.data;
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
                            game_row.team2.name,
                            game_row.id
                            ];
                        else
                            return [
                            game_row.play_date,
                            "",
                            "",
                            game_row.team1.name,
                            game_row.team2.name,
                            game_row.id

                            ];
                    })
                }
                fnCallback(data);
            } );
        }
    });
    gamesView = new GamesView();
});