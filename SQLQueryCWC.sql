--- Club World Cup Players and Teams Analysis

---Team Performance Analysis

select * from TeamStats

Select 
TeamName,MatchesPlayed,
Wins as 'Total wins by Team',
Draws as 'Total Draws by Team',
Loses as 'Total Loses by Team',
GoalsScored,GoalsConceded,
(GoalsScored - GoalsConceded) as 'Goal Differences'
from TeamStats
order by wins desc


----Team with the most goals 


select 
TeamName,MatchesPlayed,GoalsScored
from TeamStats
order by GoalsScored desc


----Most Disciplined Team
--- Disciplines Score Formula
--- 1 Yellow Card = 1 point, 1 Red Card = 3 points

select 
TeamName,
SUM(YellowCards) as 'Total Yellow Cards',
SUM(RedCards) as 'Total Red Cards',
(SUM(YellowCards)*1) + (SUM(RedCards)* 3) as 'Disciplines Points'
from TeamStats
group by TeamName
order by [Disciplines Points] asc 


---Average Goals Per match
--- logic Average = (total Goals Scored in all matches )/(Total Matches)



select 
ROUND(sum(Home_Goals + Away_Goals)*1/Count(*),2)
 as'Average Goals per Match'
from Matches

---Both Teams Scored Percentage
---Logic Condition Home_Goals and Away_Goals >0
---Percentage = (Matches where both scored /Total Matches)*100%

select 
ROUND(Count(case when Home_Goals >0 and Away_Goals>0 then 1 end)* 100/count(*),2) as 'Both Teams Scored Percentage'
from Matches

---Home Vs Away Team Analysis

select * from Matches

select 
Result,
COUNT(*) as 'Total Matches'
from Matches
group by Result 
order by Result desc

  

---Biggest Win Match


select top 1
Match_ID,Home_Team,Away_Team,Home_Goals,Away_Goals,
abs(Home_Goals - Away_Goals) as 'Goal Diff',
case 
when 
Home_Goals > Away_Goals then Home_Team
else Away_Team
end as 'Winning Team'
From Matches
order by [Goal Diff] desc

---biggest lost

select top 1 
 Home_Team,Away_Team,Home_Goals,Away_Goals,
 abs(Home_Goals - Away_Goals) as 'Goal Diff',
 case 
 when Home_Goals>Away_Goals then Away_Team
 else Home_Team
 end as 'Losing_Team'
from Matches
order by [Goal Diff] desc

---Match with most Attendence

select top 1 
Date,Home_Team, Away_Team, Home_Goals,Away_Goals,Result,Venue,Attendance
from Matches
order by Attendance desc

---Top 10 Goal Scoring Players

select * from PlayerStats

select top 10
P.Player_Name as 'Plyaer Name',
T.TeamName as 'Team Name',
P.Nationality,
P.Goals,
P.Appearances
from PlayerStats P
left join TeamStats  T on P.TeamID = T.TeamID
order by P.Goals desc


---Top 10 Assist Players

select top 10
P.Player_Name as 'Plyaer Name',
T.TeamName as 'Team Name',
P.Nationality,
P.Assists,
P.Appearances
from PlayerStats P
left join TeamStats  T on P.TeamID = T.TeamID
order by P.Assists desc

---Top 10 Goals Involvement Players

select top 10
P.Player_Name,
T.TeamName,
P.Goals,
P.Assists,
(SUM(P.Goals) + sum(P.Assists) ) as 'Goals Invovement'
from PlayerStats P
left join TeamStats  T on P.TeamID = T.TeamID
group by P.Player_Name,T.TeamName,P.Goals,P.Assists
order by [Goals Invovement] desc




