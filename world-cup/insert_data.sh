#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

get_team_id() {
  TEAM=$1
  TEAM_ID=$($PSQL "select team_id from teams where name='$TEAM';")
  echo $TEAM_ID
}

insert_team() {
  TEAM=$1
  TEAM_ID=$(get_team_id "$TEAM")

  if [[ -z $TEAM_ID ]]
  then
    INSERT_TEAM_RESULT=$($PSQL "insert into teams (name) values ('$TEAM');")

    if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into teams, $TEAM
    fi
  fi
}

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    insert_team "$WINNER"
    insert_team "$OPPONENT"
  fi
done


cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    WINNER_ID=$(get_team_id "$WINNER")
    OPPONENT_ID=$(get_team_id "$OPPONENT")
    INSERT_GAME_RESULT=$($PSQL "insert into games (year, round, winner_id, winner_goals, opponent_id, opponent_goals) values ($YEAR, '$ROUND', $WINNER_ID, $WINNER_GOALS, $OPPONENT_ID, $OPPONENT_GOALS);")

    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted $YEAR $ROUND game, $WINNER vs. $OPPONENT
    fi
  fi
done
