const movieSelect = document.getElementById("movie_movie");
const dateSelect = document.getElementById("show_date")
const screenSelect = document.getElementById("show_screen")
const timeSelect = document.getElementById("show_time")

timeSelect.addEventListener("change", function(e) {
	$.ajax({
		url: "/populate_screen?movie_id="+ movieSelect.value +"&show_date=" + dateSelect.value +"&screen_id=" + screenSelect.value + "&time_slot_id="+ timeSelect.value,
		type: "GET"
	});

});

movieSelect.addEventListener("change", function(e) {
	$.ajax({			                        
		url: "/populate_show?movie_id=" + movieSelect.value,
                type: "GET"
        });
});

