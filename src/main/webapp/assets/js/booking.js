/**
 * Apex Drive - Dynamic Booking Calculator & Date Validator
 */
document.addEventListener('DOMContentLoaded', () => {
    const pickupInput = document.getElementById('pickupDate');
    const returnInput = document.getElementById('returnDate');
    const pricePerDayEl = document.getElementById('pricePerDayVal');
    const calcDaysEl = document.getElementById('calculatedDays');
    const calcPriceEl = document.getElementById('calculatedTotalPrice');
    const submitBtn = document.getElementById('bookSubmitBtn');

    if (!pickupInput || !returnInput) return;

    // Set today as min date for pickup
    const today = new Date().toISOString().split('T')[0];
    pickupInput.setAttribute('min', today);
    if (!pickupInput.value) {
        pickupInput.value = today;
    }

    // Set return min date
    returnInput.setAttribute('min', pickupInput.value);

    function updateCalculations() {
        const pickupVal = pickupInput.value;
        const returnVal = returnInput.value;

        if (!pickupVal || !returnVal) {
            return;
        }

        const pickupDate = new Date(pickupVal);
        const returnDate = new Date(returnVal);

        if (returnDate < pickupDate) {
            returnInput.value = pickupVal;
        }

        // Adjust min of returnDate
        returnInput.setAttribute('min', pickupVal);

        const diffTime = Math.abs(returnDate - pickupDate);
        let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
        if (diffDays === 0) diffDays = 1; // Minimum 1 day

        const pricePerDay = parseFloat(pricePerDayEl ? pricePerDayEl.dataset.price : '0');
        const totalPrice = diffDays * pricePerDay;

        if (calcDaysEl) {
            calcDaysEl.textContent = diffDays + (diffDays === 1 ? ' Day' : ' Days');
        }
        if (calcPriceEl) {
            calcPriceEl.textContent = '$' + totalPrice.toFixed(2);
        }
    }

    pickupInput.addEventListener('change', () => {
        returnInput.setAttribute('min', pickupInput.value);
        if (returnInput.value && returnInput.value < pickupInput.value) {
            returnInput.value = pickupInput.value;
        }
        updateCalculations();
    });

    returnInput.addEventListener('change', updateCalculations);

    // Initial calculation on page load
    updateCalculations();
});

