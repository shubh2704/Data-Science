-- Question 2: We want to reward the user who has been around the longest, Find the 5 oldest users.
Select * from users 
order by created_at asc 
limit 5;

-- Question 3: To understand when to run the ad campaign, figure out the day of the week most users register on? 
With day_count as(
Select DAYNAME(created_at) AS day_of_week, COUNT(*) AS user_count
from users
group by DAYNAME(created_at))
Select user_count, day_of_week from day_count where user_count in (Select max(user_count) from day_count);
;


-- Question 4: To target inactive users in an email ad campaign, find the users who have never posted a photo.
Select id,username from users 
where id not in (Select user_id from photos);

-- Question 5: Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
with count_of_like as (
Select count(l.photo_id) as like_count, l.photo_id from likes l group by l.photo_id)
Select username from count_of_like cl, users u, photos p where p.user_id = u.id and cl.photo_id = p.id 
and  cl.like_count = (Select max(like_count) from count_of_like);


-- Question 6: The investors want to know how many times does the average user post.
with count_of_post as (
Select count(p.id) as photo_count, p.user_id from photos p group by p.user_id)
Select avg(photo_count) from count_of_post;



-- Question 7: A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
with count_of_tags as (
Select count(tag_id) as tag_count, tag_id from photo_tags group by tag_id)
Select ct.tag_count, t.tag_name from count_of_tags ct, tags t where t.id = ct.tag_id 
order by tag_count desc LIMIT 5;


-- Question 8: To find out if there are bots, find users who have liked every single photo on the site.
with bot_finder as (Select count(photo_id) Photo_count, user_id from likes group by user_id)
Select Photo_count, username from bot_finder btf, users u where btf.user_id = u.id 
and photo_count = (Select count(id) from photos); 



-- Question 9: To know who the celebrities are, find users who have never commented on a photo.
Select * from users 
where id not in (Select user_id from comments);

-- Question 10: Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every photo.
Select id, username from users where id in(
(with No_comments as (Select * from users where id not in (Select user_id from comments))
Select id from No_comments)
union all
(with count_of_photos as (Select count(photo_id) Photo_count, user_id from comments group by user_Id),
every_comment as (Select * from count_of_photos where photo_count = (Select count(id) from photos))
Select user_id from every_comment));
