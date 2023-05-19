Use mavenmovies;

# Question 1 
	#Approach 1 Assuming first 10 names based on their first_name
Select Concat(first_name, ' ', Last_name),  #to display full name together
	(
		CHAR_LENGTH(TRIM(First_name))+CHAR_LENGTH(TRIM((Last_name)))  #to remove any space from the end as no middle name is available
        ) as 'Name length' # Using Alias
from actor #table name
	order by first_name asc LIMIT 10; # sort on the basis of name and display first 10 rows
    
 #Approach 2   Assuming first 10 names based on their length of name
 
Select Concat(first_name, ' ', Last_name), #to display full name together
	length(replace(first_name, ' ',''))+length(replace(last_name, ' ','')) length #to find the length without any space by replacing space with no space
		from actor 
			order by Length limit 10;


            
#Question 2            
Select Concat(first_name, ' ', Last_name) FULLNAME, # Actors with full name
CHAR_LENGTH(First_name)+CHAR_LENGTH(Last_name) LENGTH, #to count the length of their name including spaces if any
 awards #awards they have won
 from actor_award where Upper(awards) like '%OSCAR%'; #to include oscar awardees



            
#Question 3


Select actor.actor_id, Concat(actor.first_name, ' ', actor.last_name) actor_name #to get actor_id and actor name
 from film_actor #contains both actor_id and film_id
	JOIN FILM ON film.film_id = film_actor.film_id #join condition to pick the film title
	JOIN actor on film_actor.actor_id = actor.actor_id #actor join to pick actor full name from the table
		where upper(film.title) like '%FROST HEAD%'; #condition to pick only film with title FROST HEAD


#Question 4

Select film.title #to get the film title acted by Will Wilson
	FROM film_actor #contains both actor_id and film_id
	JOIN FILM ON film.film_id = film_actor.film_id #join condition to pick the film title
    JOIN actor on film_actor.actor_id = actor.actor_id #actor join to pick actor first_name and last_name from the table
    where upper(actor.first_name) = 'WILL' and upper(actor.last_name) = 'WILSON'; #where condition to display title acted by actor Will Wilson
    
    
#Question 5


Select distinct f.title, return_date #film name and return data of the film 
from inventory i #table to join with film with film_id and rental with inventory_id
Join film f on i.film_id = f.film_id #to get the film title
Join rental r on i.inventory_id = r.inventory_id #to get the rental information
where monthname (r.return_date) = 'May'; #films that were rented and returned in the month of may


#Question 6

#Approach 1 using subquery
Select distinct title #to pull the distinct title name
	from film_category as fc #contains film_id and category_id
	JOIN film as f on fc.film_id = f.film_id  #Join of film table to pull the title
	where category_id = (Select category_id from category where upper(name) = 'COMEDY'); #using subquery to fetch the comedy category

#Approach 2 using only Joins
Select distinct title #to pull the distinct title name
	from film_category as fc #contains film_id and category_id
	JOIN film as f on fc.film_id = f.film_id #Join of film table to pull the title
	JOIN category as c on fc.category_id = c.category_id #join of category table to include only comedy category
		where upper(c.name) = 'COMEDY'; #where condition to get comedy category


