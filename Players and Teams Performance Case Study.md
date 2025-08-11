# Club World Cup 2025 Players and Teams Performance 

## Case Study
### 1. Team Performance Analysis.
````sql
  Select 
TeamName,MatchesPlayed,
Wins as 'Total wins by Team',
Draws as 'Total Draws by Team',
Loses as 'Total Loses by Team',
GoalsScored,GoalsConceded,
(GoalsScored - GoalsConceded) as 'Goal Differences'
from TeamStats
order by wins desc
````
**Result**
<img width="1011" height="554" alt="Team Performance " src="https://github.com/user-attachments/assets/36f59233-d532-4201-9d4e-eb494ad4c7b7" />

***

### 2. Team with the most Goals Scored

````sql
select top 1
TeamName,MatchesPlayed,GoalsScored
from TeamStats
order by GoalsScored desc
````
**Result**

<img width="375" height="142" alt="mg" src="https://github.com/user-attachments/assets/902a77a6-25ca-4d3f-8c49-3106d815e669" />

***
### 3. The top 3 Team with the most discipline.
  - Discipline Formula
  - 1 Yellow Card = 1 point, 1 Red Card = 3 points
````sql
select top 3<img width="375" height="142" alt="disupdate" src="https://github.com/user-attachments/assets/4c03c780-0041-465f-9d6e-17232619abf6" />

TeamName,
SUM(YellowCards) as 'Total Yellow Cards',
SUM(RedCards) as 'Total Red Cards',
(SUM(YellowCards)*1) + (SUM(RedCards)* 3) as 'Disciplines Points'
from TeamStats
group by TeamName
order by [Disciplines Points] asc 
````

**Result**

<img width="375" height="142" alt="disupdate" src="https://github.com/user-attachments/assets/2c326e89-311d-4c8c-a2ba-e8739b58f354" />

***

### 4.Calculating the Average Goal per match.
- Logic Average = (total Goals Scored in all matches )/(Total Matches)

````sql
  select 
ROUND(sum(Home_Goals + Away_Goals)*1/Count(*),2)
 as'Average Goals per Match'
from Matches
````

**Result**

<img width="498" height="119" alt="Avg goals per match" src="https://github.com/user-attachments/assets/8dff3931-6b28-42e0-842c-741bfd1bc3e8" />

***

### 5. Calculating the both teams scored percentage 
- Logic Condition Home_Goals and Away_Goals >0
- Percentage = (Matches where both scored /Total Matches)*100%

````sql
 select 
ROUND(Count(case when Home_Goals >0 and Away_Goals>0 then 1 end)* 100/count(*),2) as 'Both Teams Scored Percentage'
from Matches
````

**Result**

<img width="498" height="119" alt="both teams scored pct" src="https://github.com/user-attachments/assets/4467451d-dcd5-4135-9832-ff3aa35fe007" />

***

### 6. Home Team vs Away Team winning Analysis
````sql
select 
Result,
COUNT(*) as 'Total Matches'
from Matches
group by Result 
order by Result desc

````
**Result**

<img width="375" height="142" alt="Screenshot 2025-08-11 at 18 32 49" src="https://github.com/user-attachments/assets/8057cf78-f4f0-4d67-879d-fac4401c6422" />

***

### 7. The team with the biggest goal difference win match
````sql
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

````
**Result**

<img width="498" height="119" alt="BiggestWin1" src="https://github.com/user-attachments/assets/c9a8e9c0-9c7e-4a09-971d-d17d6519806e" />

***

### 8. The team with the biggest goal difference lose match


````sql

select top 1 
 Home_Team,Away_Team,Home_Goals,Away_Goals,
 abs(Home_Goals - Away_Goals) as 'Goal Diff',
 case 
 when Home_Goals>Away_Goals then Away_Team
 else Home_Team
 end as 'Losing_Team'
from Matches
order by [Goal Diff] desc
````

**Result**

<img width="498" height="119" alt="Biggest Lost" src="https://github.com/user-attachments/assets/b3b2c5cc-ea01-4861-87e9-ea3cda8a2159" />

***
### 9. The Match with the most attandence 

````sql

select top 1 
Date,Home_Team, Away_Team, Home_Goals,Away_Goals,Result,Venue,Attendance
from Matches
order by Attendance desc

````

**Result**

<img width="657" height="116" alt="Most Attandence" src="https://github.com/user-attachments/assets/51843592-084e-4bbc-9599-da7a4dda0bc1" />

***

### 10. Top 10 Goal Scorer 

````sql

select top 10
P.Player_Name as 'Plyaer Name',
T.TeamName as 'Team Name',
P.Nationality,
P.Goals,
P.Appearances
from PlayerStats P
left join TeamStats  T on P.TeamID = T.TeamID
order by P.Goals desc

````

**Result**

<img width="498" height="206" alt="TopGoalScoring" src="https://github.com/user-attachments/assets/5398c7cb-c7fd-4527-9302-2a3575775376" />

***

### 11. Top 10 Assit Players

````sql

select top 10
P.Player_Name as 'Plyaer Name',
T.TeamName as 'Team Name',
P.Nationality,
P.Assists,
P.Appearances
from PlayerStats P
left join TeamStats  T on P.TeamID = T.TeamID
order by P.Assists desc

````

**Result**

<img width="657" height="214" alt="Top Assist" src="https://github.com/user-attachments/assets/65f503c2-c81b-49e8-853c-7f2d2b02120b" />

***

### 12. Top 10 Goals Involvement Players

````sql

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

````

**Result**

<img width="657" height="214" alt="Top Golas Involvement" src="https://github.com/user-attachments/assets/53563280-1f9c-44ba-86d3-64ae5a945a8b" />


***



 

















