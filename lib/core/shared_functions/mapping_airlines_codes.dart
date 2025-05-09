const Map<String, String> airlineCodes = {
  // Middle Eastern Airlines
  'SV': 'Saudi Arabian Airlines',
  'QR': 'Qatar Airways',
  'EK': 'Emirates',
  'EY': 'Etihad Airways',
  'GF': 'Gulf Air',
  'KU': 'Kuwait Airways',
  'RJ': 'Royal Jordanian',
  'MS': 'EgyptAir',
  'FZ': 'Flydubai',
  'XY': 'Flynas',
  'VF': 'AJET', // Formerly SaudiGulf Airlines
  'WY': 'Oman Air',
  'IA': 'Iraqi Airways',
  '6H': 'Israir',
  'J9': 'Jazeera Airways',
  'OV': 'Salam Air',
  'P9': 'Peruvian Airlines', // Also operates in Middle East
  'R5': 'Jordan Aviation',
  '3S': 'Air Arabia Egypt',
  '3O': 'Air Arabia Maroc',
  'G9': 'Air Arabia',
  '5W': 'Wizz Air Abu Dhabi',
  'NP': 'Nile Air',
  'X': 'HAHN AIR TECHNOLOGIES',

  // Major Global Airlines
  'AA': 'American Airlines',
  'DL': 'Delta Air Lines',
  'UA': 'United Airlines',
  'BA': 'British Airways',
  'LH': 'Lufthansa',
  'AF': 'Air France',
  'KL': 'KLM',
  'AY': 'Finnair',
  'JL': 'Japan Airlines',
  'NH': 'ANA All Nippon Airways',
  'SQ': 'Singapore Airlines',
  'CX': 'Cathay Pacific',
  'QF': 'Qantas',
  'CA': 'Air China',
  'MU': 'China Eastern',
  'CZ': 'China Southern',
  'KE': 'Korean Air',
  'OZ': 'Asiana Airlines',
  'TG': 'Thai Airways',
  'AI': 'Air India',
  'ET': 'Ethiopian Airlines',
  'SA': 'South African Airways',
  'AC': 'Air Canada',
  'TK': 'Turkish Airlines',
  'SU': 'Aeroflot',
  'LO': 'LOT Polish Airlines',
  'LX': 'Swiss International Air Lines',
  'OS': 'Austrian Airlines',
  'SK': 'SAS Scandinavian Airlines',
  'AZ': 'ITA Airways',
  'TP': 'TAP Portugal',
  'IB': 'Iberia',
  'LY': 'El Al',
  'VS': 'Virgin Atlantic',
  'B6': 'JetBlue',
  'WN': 'Southwest Airlines',
  'AS': 'Alaska Airlines',
  'HA': 'Hawaiian Airlines',
  'NZ': 'Air New Zealand',
  'VA': 'Virgin Australia'
};

String getAirlineName(String? iataCode) {
  if (iataCode == null) {
    return 'Unknown Airline';
  }
  return airlineCodes[iataCode] ?? 'Unknown Airline (Code: $iataCode)';
}
