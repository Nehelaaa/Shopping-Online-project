create or replace procedure activity_name (input in activities.capacity%type, activ_name out activities.name%type)
-- the procedure will return the activity name. 
is
    holder activities.capacity%type;
    input_half activities.capacity%type;
    id activities.aid%type;
    price activities.price%type;
    temp_activities activities%rowtype;
    cursor curs_activity is 
        select *
        from activities a;
begin
    holder := input;
    input_half := input/2;
    open curs_activity;
    loop
        fetch curs_activity into temp_activities;
        exit when curs_activity%notfound;
        if ABS(input_half-temp_activities.capacity) < holder then
            holder := ABS(input_half-temp_activities.capacity);
            activ_name := temp_activities.name;
            price := temp_activities.price;
            id := temp_activities.aid;
        elsif holder = input_half-temp_activities.capacity
 then
            if temp_activities.price < price then
                holder := ABS(input_half-temp_activities.capacity);
                activ_name := temp_activities.name;
                price := temp_activities.price;
                id := temp_activities.aid;
                elsif temp_activities.price = price then
                    if temp_activities.aid > id then 
                         holder := ABS(input_half-temp_activities.capacity);
                        activ_name := temp_activities.name;
                        price := temp_activities.price;
                        id := temp_activities.aid;
                    end if;
            end if;
        end if;
    end loop;
    close curs_activity;
end;
/
declare
    activity_name1 activities.name%type;
begin
    activity_name(30, activity_name1);
    -- returning the activity name.
    DBMS_OUTPUT.PUT_LINE('The activity to perform: '|| activity_name1);
end;
/