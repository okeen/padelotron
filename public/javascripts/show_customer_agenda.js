$(function(){
    GameEvent = Backbone.Model.extend({
        initalize: function(){
            _.bindAll(this,[]);
        }
    });
    GameEventsController = Backbone.Collection.extend({
        model: GameEvent,
        place_id: $("input[name='init_place_id']")[0].value,
        url: function(){
            return '/customers/agenda/games.json';
        },
        comparator: function(todo) {
            return todo.get('play_date');
        }
    });
    window.GameEvents = new GameEventsController();

    GameEventView = Backbone.View.extend({
        initialize: function() {
            this.model.bind('change', this.render, this);
        },
        render: function() {
            return this;
        }
    });

    ShowCustomerAgendaView= Backbone.View.extend({
        el: $("div#main_panel"),
        events: {
        },
        initialize: function() {
            _.bindAll(this,['initScheduler']);
            this.confirmGame= _.bind(this.confirmGame, this);
            GameEvents.bind('add',   this.addGameEvent, this);
            GameEvents.bind('reset', this.resetGameEvents, this);
            $("button#confirm_game_action").bind("click", this.confirmGame);
            $("div.dhx_cal_event div").live("click", this.setSelectedGame);
            $.when(
                $.ajax("/places/"+GameEvents.place_id+"/playgrounds.json"))
            .then(
                this.initScheduler);
            GameEvents.fetch({
                data: {
                    place_id: GameEvents.place_id
                }
            });
        },
        setSelectedGame: function(scheduleGameElem){
            console.log("Selected new game from agenda:" + scheduleGameElem.target);
            $("div.dhx_cal_event.selected").removeClass("selected");
            $(scheduleGameElem.target).parent().addClass("selected");
        },
        initScheduler: function(playgrounds){
            if (!playgrounds){
                console.debug("Customer:Agenda error loading place playgrounds");
                return;
            }
            var sections=_(playgrounds).map(function(item){
                console.debug("PlacePlaygrounds::Loaded " + item.name);
                return {
                    key: item.id,
                    label: item.name
                };
            });
            scheduler.createUnitsView({
                name: "unit",
                property: "playground_id",
                list: sections
            });
            scheduler.locale.labels.unit_tab = "Playground"
            scheduler.init('scheduler',null,"day");
            scheduler.config.api_date=""
            scheduler.attachEvent("onClick", this.showGameDetails);

        },
        showGameDetails:function(gameId,event){
            console.log("Customer:Agenda selected from schedule Game" + gameId);
            var game = GameEvents.get(gameId);
            App.selectedGame = game;
            console.log("Customer:Agenda loaded Game" + game);
            $("#game_title").html('Game: ' + game.get("team1").name + " VS " + game.get("team2").name);
            $("#game_description").html(game.get("description"));
            $("#game_date_and_place").html(game.get("play_date") +" @ "+ game.get("playground").name);
            var gameTeamsPanel = $("#game_team1_panel");
            gameTeamsPanel.find("h4[name='team_name']").html(game.get("team1").name);
            gameTeamsPanel.find("li[name='team_player1']").html(game.get("team1").players[0].name);
            gameTeamsPanel.find("li[name='team_player2']").html(game.get("team1").players[1].name);
            gameTeamsPanel = $("#game_team2_panel");
            gameTeamsPanel.find("h4[name='team_name']").html(game.get("team2").name);
            gameTeamsPanel.find("li[name='team_player1']").html(game.get("team2").players[0].name);
            gameTeamsPanel.find("li[name='team_player2']").html(game.get("team2").players[1].name);

        },
        render: function() {
        },
        addGameEvent: function(event){
            var conversor= scheduler.date.str_to_date("%Y-%m-%dT%H:%i:%sZ");
            var start_date = conversor(event.get('play_date').replace("Z", " ").replace("T", " "));
            var end_date = scheduler.date.add(start_date, 1, "hour");

            scheduler.addEvent({
                start_date: start_date,
                end_date: end_date,
                id: event.get("id"),
                text:event.get('team1').name + " VS " + event.get('team2').name +": "+ event.get('description')
            });
        },
        resetGameEvents: function(){

        },
        confirmGame: function(event){
            var gameId= this.selectedGame.get("id");
            console.log("Agenda: confirming game" + gameId);
            $.ajax({
                type: "PUT",
                url: "/customers/playground_requests/" + gameId +".json",
                data: {customer_playground_request:{status: 'confirmed'}},
                success: function(data, status){
                    console.debug("Agenda: confirmed game" + data.model.game_id);
                    $("div.dhx_cal_event.selected").addClass("confirmed");
                }
            });
            
        }
    });
    Backbone.sync= function(method, model, options){
        if (method == "read"){
            $.ajax({
                url: "/customers/agenda/games.json",
                data: options.data,
                type: "GET",
                success: function(data,response){
                    console.log("Customers:Agenda got games:" + data.length);
                    var returningList= [];
                    for (var i=0; i< data.length; i++){
                        var event= data[i];
                        console.log("Customers:Agenda processing Event" + event.id);
                        window.GameEvents.add(new GameEvent(event));
                    }

                },
                error: function(event,response){
                    console.log("Customers:Agenda read error:" + response);
                    var data = JSON.parse(response.responseText);
                    if (response.status == 200){
                        try {
                            if (data.model){
                                return;
                            }
                        }
                        catch(ex){
                            console.debug("Maybe actually something DID go wrong..." + ex);
                        }
                    }
                }
            })
        }
    }
    window.App = new ShowCustomerAgendaView();
})
