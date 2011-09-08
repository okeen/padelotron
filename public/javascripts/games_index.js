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
            this.filterSidebar = $(".sidebar_location_filter").jstree({
                "themes" : {
                    "theme" : "apple",
                    "dots" : false,
                    "icons": false
                },
                core : {
                    "initially_open" : [ "root_country" ]
                },
                plugins : [ "themes", "html_data" , "ui"]
            });
            $(".sidebar_location_filter li a").live("click.jstree",
                _.bind(this.updateTableWithSidebarLocationParams, this));
            $(".sidebar_date_filter li a").live("click",
                _.bind(this.updateTableWithSidebarDateParams, this));
            $(".show_games a").live("click",
                _.bind(this.updateTableWithGames, this));
            $(".show_results a").live("click",
                _.bind(this.updateTableWithResults, this));
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
                    "fnRender": function ( oObj ) {
                       return new Date(oObj.aData[0]).format("mmm-d");
                    },

                    "aTargets": [ 0 ]
                },
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
        updateTableWithSidebarLocationParams: function(event){
            var locationItem = event.target.parentNode;
            var param = {};
            param[locationItem.getAttribute('name')]=locationItem.getAttribute('value');
            console.log("Games:: LocationTree selected location: " + param);
            this.locationFilter = param;
            //this.table.fnClearTable(true);
            this.table.fnDraw();
        },
        updateTableWithSidebarDateParams: function(event){
            var dateItem = event.target.parentNode;
            var param = {};
            param[dateItem.getAttribute('name')]=dateItem.getAttribute('value');
            console.log("Games:: DateTree selected date " + param.name);
            this.dateFilter = param;
            //this.table.fnClearTable(true);
            this.table.fnDraw();
        },
        updateTableWithGames: function(event){
            event.preventDefault();
            var panel = $(event.target.parentNode);
            panel.addClass("current");
            $(".show_results").removeClass("current");
            this.modelFilter = undefined;
            //this.table.fnClearTable(true);
            console.log("Games::Results show false" );
            this.modelFilter = undefined;
            this.table.fnDraw();
        },
         updateTableWithResults: function(event){
            event.preventDefault();
            var panel = $(event.target.parentNode);
            panel.addClass("current");
            $(".show_games").removeClass("current");
            var param = {};
            console.log("Games::Results show true" );
            this.modelFilter = {"results": true};
            //this.table.fnClearTable(true);
            this.table.fnDraw();
        },
        showGameDetails: function(event, data){
            var rowNode = event.target.parentNode;
            var onlyHide = $(rowNode).hasClass("selected");
            var gameId = rowNode.id;
            $.each($("tr.selected"), function(i, row){
                gamesView.table.fnClose(row);
            });
            $("tr.selected").removeClass("selected");
            if (onlyHide)
                return;
            $(rowNode).addClass("selected");
            $(document.body).addClass("loading");
            console.log("Games::Show details# " + gameId);
            $.when($.ajax("/games/"+gameId+".html")).then(function(response){
              var wrapper = "<div class='selected_game_info_panel_wrapper'></div>";
              gamesView.table.fnOpen(rowNode, wrapper, "game_info" ) ;
              $(".game_info div.selected_game_info_panel_wrapper").wrapInner(response);
              $(document.body).removeClass("loading");
            });
        },
        updateTableData: function( sSource, aoData, fnCallback){
            //add location filter params
            $(document.body).addClass("loading");
            aoData= {
                    "offset": aoData.iDisplayStart,
                    location: this.locationFilter,
                    date: this.dateFilter,
                    show_results: this.modelFilter ? true: false
                
            } ;
            $.getJSON( sSource, {q:aoData}, function (json) {
                /* Do whatever additional processing you want on the callback, then tell DataTables */
               gamesView.data = json.data;
               var data = {
                    "sEcho": aoData.sEcho - 1,
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
                $(document.body).removeClass("loading");
            } );
        }
    });
    gamesView = new GamesView();
});