const seats = document.querySelectorAll(".row .seat:not(.occupied)");
const seatContainer = document.querySelector(".row-container");
const count = document.getElementById("booking_seats");
const total = document.getElementById("booking_total_price");
const selectedMovieTicket = document.getElementById("booking_movie_tickets");

populateUI();

function setMovieData(movieIndex, moviePrice) {
	localStorage.setItem("selectedMovieIndex", movieIndex);
	localStorage.setItem("selectedMoviePrice", moviePrice);
}

function updateSelectedCount() {
	const selectedSeats = document.querySelectorAll(".container .selected");
	var totalPrice = 0;
	var selectedTicket = [];
        console.log(selectedSeats.length);
	seatsIndex = [...selectedSeats].map(function(seat) {
		selectedSeat = [...seats].indexOf(seat);
		count.value = selectedSeats.length-1;
		if( selectedSeat != -1 ){
			selectedTicket.push(selectedSeat);
			switch (true) {
				case (selectedSeat <= 9):
					totalPrice += parseInt(150)
					break;
				case (selectedSeat > 9 && selectedSeat <= 19):
					totalPrice += parseInt(200)
					break;
				case (selectedSeat > 19):
					totalPrice += parseInt(250)
					break;
			}     }
		total.value = totalPrice;
		selectedMovieTicket.value = selectedTicket;
		return selectedSeat;
	});

	localStorage.setItem("selectedSeats", JSON.stringify(seatsIndex));

}
function populateUI() {
	const selectedSeats = JSON.parse(localStorage.getItem("selectedSeats"));

	if (selectedSeats !== null && selectedSeats.length > 0) {
		seats.forEach(function(seat, index) {
			if (selectedSeats.indexOf(index) > -1) {
				seat.classList.add("selected");
			}
		});
	}

	const selectedMovieIndex = localStorage.getItem("selectedMovieIndex");

	if (selectedMovieIndex !== null) {
		//movieSelect.selectedIndex = selectedMovieIndex;
	}
}

seatContainer.addEventListener("click", function(e) {
	if (
		e.target.classList.contains("seat") &&
		!e.target.classList.contains("occupied")
	) {
		e.target.classList.toggle("selected");
		updateSelectedCount();
	}
});

updateSelectedCount();

