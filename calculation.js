function fetchPrayerTimes() {
  const citySelect = document.getElementById('city');
  const methodSelect = document.getElementById('method');
  const schoolSelect = document.getElementById('school');

  const cityValue = localStorage.getItem('city') || 'Africa/Abidjan';
  const methodValue = localStorage.getItem('method') || '1';
  const schoolValue = localStorage.getItem('school') || '0';

  let country, state, city;

  if (cityValue.includes('/')) {
    const parts = cityValue.split('/');
    if (parts.length === 2) {
      country = parts[0];
      city = parts[1];
    } else if (parts.length === 3) {
      country = parts[0];
      state = parts[1];
      city = parts[2];
    }
  }

  // Get the current date in the format MM-DD-YYYY
  const currentDate = new Date();
  const month = String(currentDate.getMonth() + 1).padStart(2, '0'); // Months are zero-based
  const day = String(currentDate.getDate()).padStart(2, '0');
  const year = currentDate.getFullYear();
  const formattedDate = `${year}-${month}-${day}`;

  const apiUrl = `http://api.aladhan.com/v1/timingsByCity/${formattedDate}?city=${city}&country=${country}&state=${state}&method=${methodValue}&school=${schoolValue}`;

  fetch(apiUrl)
      .then(response => response.json())
      .then(data => {
          if (data.code === 200) {
              const timings = data.data.timings;
              document.getElementById('fajr').innerText = timings.Fajr;
              document.getElementById('sunrise').innerText = timings.Sunrise;
              document.getElementById('dhuhr').innerText = timings.Dhuhr;
              document.getElementById('asr').innerText = timings.Asr;
              document.getElementById('maghrib').innerText = timings.Maghrib;
              document.getElementById('isha').innerText = timings.Isha;

              // Store prayer times in localStorage
              localStorage.setItem('fajr', timings.Fajr);
              localStorage.setItem('dhuhr', timings.Dhuhr);
              localStorage.setItem('asr', timings.Asr);
              localStorage.setItem('maghrib', timings.Maghrib);
              localStorage.setItem('isha', timings.Isha);
          } else {
              console.error('Error fetching prayer times:', data);
          }
      })
      .catch(error => {
          console.error('Error fetching prayer times:', error);
      });
}

// Call fetchPrayerTimes on page load
window.onload = fetchPrayerTimes;
