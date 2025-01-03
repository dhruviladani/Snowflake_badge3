set mystery_bag = 'What is in here?';

select $mystery_bag;

set var1 = -10.5;
set var2 = 2;
set var3 = 1000;

select $var1+$var2;

create function sum_mystery_bag_vars(var1 number, var2 number, var3 number )
returns number as 'select var1+var2+var3';

select sum_mystery_bag_vars ($var1,$var2,$var3);

set this = -10.5 ;
set that = 2 ;
set the_other = 1000 ;

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW006' as step
 ,( select util_db.public.sum_mystery_bag_vars($this,$that,$the_other)) as actual
 , 991.5 as expected
 ,'Mystery Bag Function Output' as description
);



create or replace function NEUTRALIZE_WHINING(mystrey_bag text )
returns text as 'select INITCAP(mystrey_bag)';

select NEUTRALIZE_WHINING($mystery_bag);

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW007' as step
 ,( select hash(neutralize_whining('bUt mOm i wAsHeD tHe dIsHes yEsTeRdAy'))) as actual
 , -4759027801154767056 as expected
 ,'WHINGE UDF Works' as description
);
