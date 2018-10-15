select *
from survey
limit 10;

select question, count (distinct user_id)
from survey
group by question;
select *
from quiz
limit 5;
select * from home_try_on
limit 5;
select * 
from purchase
limit 5;
select style, count(*)
from quiz
group by style;
select model_name, count(*)
from purchase
group by model_name
order by 2 desc;

SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as "number_of_pairs",
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id
   limit 10;

 with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select count(*) as 'total quiz', sum(is_purchase) as 'purchased', 1.0 * sum(is_purchase) / (count(*)) as 'overall conversion rate'
from funnel;

with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select count(*) as 'total quiz', sum(is_home_try_on) as 'home try on', 1.0 * sum(is_home_try_on) / (count(*)) as 'quiz to try on rate'
from funnel;      
                                                                       
with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select sum(is_home_try_on) as 'home try on', sum(is_purchase) as purchase, 1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try on to purchase rate'
from funnel;                                
                                                                        with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select sum(is_home_try_on) as 'try on - 3 pairs', sum(is_purchase) as 'purchase - 3 pairs', 1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try on to purchase rate - 3 pairs'                                   
from funnel
where number_of_pairs = '3 pairs';         
                                                                       with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select sum(is_home_try_on) as 'try on - 5 pairs', sum(is_purchase) as 'purchase - 5 pairs', 1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try on to purchase rate - 5 pairs'                              
from funnel
where number_of_pairs = '5 pairs';                               
                                                                                             
                                                                                             
with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
select number_of_pairs, sum(is_home_try_on) as 'sent home'
from funnel
where number_of_pairs is not null
group by number_of_pairs;                                                                                                          
with funnel as 
(SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs as 'number_of_pairs',
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
      select number_of_pairs, count(*) as purchased
   from funnel
   where is_purchase = 1
   group by number_of_pairs;
