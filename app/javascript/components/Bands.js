import React, { useState, useEffect } from "react";

function Bands() {
  const [bands, setBands] = useState([]);
  const [city, setCity] = useState("");
  const [error, setError] = useState(null);

  const fetchBands = async (searchCity = "") => {
    try {
      const res = await fetch(`/api/v1/bands?city=${searchCity}`);
      if (!res.ok) throw new Error("Error fetching bands data.");
      const data = await res.json();
      setBands(data);
    } catch (err) {
      setError("Could not fetch bands data. Please try again.");
    }
  };

  useEffect(() => {
    const getLocation = async () => {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          async (position) => {
            const { latitude, longitude } = position.coords;
            try {
              const geoRes = await fetch(
                `https://get.geojs.io/v1/ip/geo.json?latitude=${latitude}&longitude=${longitude}`
              );
              const geoData = await geoRes.json();
              const detectedCity = geoData.city;
              setCity(detectedCity);
              fetchBands(detectedCity);
            } catch {
              setError("Could not determine your city.");
            }
          },
          async () => {
            try {
              const fallbackRes = await fetch("https://get.geojs.io/v1/ip/geo.json");
              const fallbackData = await fallbackRes.json();
              const fallbackCity = fallbackData.city;
              setCity(fallbackCity);
              fetchBands(fallbackCity);
            } catch {
              setError("Could not determine your location.");
            }
          }
        );
      } else {
        setError("Geolocation is not supported by this browser.");
      }
    };

    getLocation();
  }, []);

  const handleSearch = (e) => {
    e.preventDefault();
    fetchBands(city);
  };

  return (
    <div>
      <h1>Band Finder</h1>
      <form onSubmit={handleSearch}>
        <input
          type="text"
          value={city}
          onChange={(e) => setCity(e.target.value)}
          placeholder="Enter city"
        />
        <button type="submit">Search</button>
      </form>
      {error && <p>{error}</p>}
      <ul>
        {bands.map((band) => (
          <li key={band.id}>
            {console.log("band.life_span",band["life-span"].begin)}
            {band.name} - Founded in {band["life-span"].begin? band["life-span"].begin : "Unknown"}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Bands;
