create or replace procedure registeration_activity(given_Id in registration.cid%type, 
    given_act_Id in registration.aid%type)

is 
-- variables to hold the differnt values. 
mean_Age campers.age%type;
camper_age campers.age%type; 
camper_zipcode campers.zipcode%type;
Id_new_add activities.aid%type;
count_zip campers.zipcode%type;
name_A activities.name%type;
empty_act number;
capacity_A activities.capacity%type;
price_A activities.price%type;

 

BEGIN
-- getting the campers age and zip code by using the given campers id and assign it to
-- camper_age and camper_zipcode
    SELECT c.age, c.zipcode into camper_age, camper_zipcode  from campers c where c.cid = given_Id;
        
-- getting the campers average age or mean age. 
    SELECT avg(c.age) into mean_Age from campers c, registration r, activities a   where a.aid = r.aid and c.cid = r.cid; 
    
-- the query will return the count for the zipcode count for he given camper and assigne to count_zip.
    SELECT count (c.cid) into count_zip from campers c, activities a, registration r  where a.aid = r.aid and c.cid = r.cid and c.zipcode = camper_zipcode and a.aid = given_act_Id;  

       
    --cehcking for the registration table if there is any activuty which is empty.
    select count (r.aid) into empty_act from registration r where r.aid =  given_act_Id; 
               
-- getting the activity name, capacity, and price for the given activity ID. 
    select a.name, a.price, a.capacity into name_A, price_A, capacity_A  from activities a where a.aid = given_act_Id;
-- to generrate the new activity ID so i just grab he max ID from the table and will add one to it to generate the new ID. 
    select max(a.aid)  into Id_new_add from activities a;

/*.  there are no other campers already
registered for an activity, register the given camper for that activity. */
    if empty_act = 0 then 
        insert into registration values  (given_Id, given_act_Id);
	dbms_output.put_line('Empty activity, registered camper');
/* If the camper’s age is greater than or equal to 50% of the mean age of the other campers registered for
this activity AND if no other camper registered for the given activity shares the zip code of the camper
given as the argument, register the given camper for the activity. */
       
    elsif camper_age >= (mean_Age/2) and count_zip = 0 then
        insert into registration values (given_Id, given_act_Id);
	   dbms_output.put_line('registered camper');

/*if the input camper’s age is less than 50% of the mean age of the campers enrolled in that
activity OR if someone in that activity shares the same zip code as them, create a new activity and
registerthe given camperin it. This new activity should have the same name, be half the price, and be
double the capacity of the input activity. */
     
    elsif camper_age < (mean_age/2) or count_zip > 0 then
        insert into activities values (Id_new_add +1, name_A, price_A/2, capacity_A *2);
        insert into registration values (given_Id, Id_new_add+1);
    
        dbms_output.put_line('registered camper for new activity');
    end if; 
end;
/
set serveroutput on;
BEGIN
    registeration_activity(1, 2001);
END;
/