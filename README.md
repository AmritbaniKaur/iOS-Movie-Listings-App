# iOS Movie Listings App

----------------------------------------------------------------------------------

This app uses UIViews, UITableViews, NavigationController and other Swift MVC features to show all the movies present in the TMDB.

It connects with the TMDB dev API and shows the movie details with posters and pictures on the go.

----------------------------------------------------------------------------------

Requirements:

Do not use Storyboards, will have to create everything programmatically

In demo video, show both in X and a smaller screen

Master/Detail flow:

	Master view must be tableview

	Create your own custom cell

	Fetch movie list from TMDB server through Json downloading

	Show small image of the poster, title

	Download images from the poster link

	Select a movie by tapping a row, then load detail view of your design

	Delete a movie with swiping action

Detail view:

	Customize/design your detail view
	
	Title, rating, description, ...
	
	Ratings must be visual (not text)
	
	Download movie details from TMDB with id of Movie
	
	Show poster/backdrop images within a collection
	
	View and make swiping action
	
	Download images from the server (NO local image)
	
	Use 2 poster/backdrop images to manipulate >= 4 collection view items

MVC design pattern!

Define your model for fetching Movie Json data

Movie list/movie detail

Must be Decodable (No need to parse JSON data)

----------------------------------------------------------------------------------

P.S.: You will have to:

Create a TMDB Dev Account (https://www.themoviedb.org)

Get the API Key

You can load movie data information with your API key with the following urls:

Get Now Playing : http://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>

Get Popular : http://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>

Get Top Rated : http://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>

Get Upcoming : http://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>

Each movie entry has a field called “poster_path” or , which is where you should download the picture for the movies

URI: http://image.tmdb.org/t/p/<<size>>/<<poster_path>>"; // size : "w92", "w154", "w185", "w342", "w500", "w780", or "original".

