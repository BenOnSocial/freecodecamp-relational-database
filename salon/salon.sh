#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

main_menu() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?"
  echo ""
  echo "$($PSQL "select service_id, name from services order by service_id;")" | while read ID BAR SERVICE
  do
    echo "$ID) $SERVICE"
  done
  echo "0) Exit"
  echo ""

  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    service_menu $SERVICE_ID_SELECTED
  else 
    main_menu "Please enter a valid option."
  fi
}

service_menu() {
  SERVICE_ID=$1
  SERVICE=$(get_service_by_id $1)
  CUSTOMER_NAME=

  if [[ $SERVICE_ID -eq 0 ]]
  then
    bye
    exit 0
  fi

  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_ID=$(get_id_by_phone $CUSTOMER_PHONE)
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers (name, phone) values ('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
    CUSTOMER_ID=$(get_id_by_phone $CUSTOMER_PHONE)
  fi

  echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
  read SERVICE_TIME

  INSERT_APPOINTMENT_RESULT=$($PSQL "insert into appointments (customer_id, service_id, time) values ($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME');")
  echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
}

get_id_by_phone() {
  echo "$($PSQL "select customer_id from customers where phone='$1';")"
}

get_name_by_id() {
  echo "$($PSQL "select name from customers where customer_id='$1';")"
}

get_service_by_id() {
  echo "$($PSQL "select name from services where service_id='$1';")"
}

bye() {
  echo -e "\nThank you for using the salon appointment scheduler.\n"
}

main_menu
