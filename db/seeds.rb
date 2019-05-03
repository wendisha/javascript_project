# User.create(name: "dfs", password: "dfs")
# 
# Agent.create(user_id: 1, name: "LookAtMe", country_of_origin: "selfland")
# Agent.create(user_id: 1, name: "LookAtMyClient", country_of_origin: "humbleland")
#
# Club.create(user_id: 1, name: "Barcelona", city: "Barcelona", nation: "Spain", league_division: "La Liga")
# Club.create(user_id: 1, name: "Real Madrid", city: "Madrid", nation: "Spain", league_division: "La Liga")
#
# Player.create(agent_id: 1, club_id: 1, user_id: 1, name: "Messi", country_of_origin: "Argentina", position: "Att Mid")
# Player.create(agent_id: 2, club_id: 2, user_id: 1, name: "C Ronaldo", country_of_origin: "Portugal", position: "Att Mid")

Status.create(wording: "in the works")
Status.create(wording: "pending")
Status.create(wording: "in effect")
Status.create(wording: "completed")
Status.create(wording: "terminated early")
Status.create(wording: "dead")
