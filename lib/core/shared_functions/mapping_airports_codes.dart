// lib/airport_mapper.dart

/// A class to hold the detailed information for an airport.
class _AirportDetails {
  final String name;
  final String city;
  final String country;

  _AirportDetails(
      {required this.name, required this.city, required this.country});

  /// Converts the AirportDetails object to a Map for convenient access
  /// if a raw Map<String, String> is preferred by the caller.
  Map<String, String> toMap() {
    return {
      'name': name,
      'city': city,
      'country': country,
    };
  }
}

/// A global map containing details for famous airports, keyed by their IATA codes.
/// This map prioritizes famous airports, with a strong focus on the Middle East.
final Map<String, _AirportDetails> _famousAirports = {
  // --- Middle East & North Africa Airports (Prioritized) ---
  'DXB': _AirportDetails(
      name: 'Dubai International Airport',
      city: 'Dubai',
      country: 'United Arab Emirates'),
  'DOH': _AirportDetails(
      name: 'Hamad International Airport', city: 'Doha', country: 'Qatar'),
  'CAI': _AirportDetails(
      name: 'Cairo International Airport', city: 'Cairo', country: 'Egypt'),
  'JED': _AirportDetails(
      name: 'King Abdulaziz International Airport',
      city: 'Jeddah',
      country: 'Saudi Arabia'),
  'RUH': _AirportDetails(
      name: 'King Khalid International Airport',
      city: 'Riyadh',
      country: 'Saudi Arabia'),
  'AMM': _AirportDetails(
      name: 'Queen Alia International Airport',
      city: 'Amman',
      country: 'Jordan'),
  'KWI': _AirportDetails(
      name: 'Kuwait International Airport',
      city: 'Kuwait City',
      country: 'Kuwait'),
  'BAH': _AirportDetails(
      name: 'Bahrain International Airport',
      city: 'Manama',
      country: 'Bahrain'),
  'MCT': _AirportDetails(
      name: 'Muscat International Airport', city: 'Muscat', country: 'Oman'),
  'TLV': _AirportDetails(
      name: 'Ben Gurion Airport', city: 'Tel Aviv', country: 'Israel'),
  'BEY': _AirportDetails(
      name: 'Beirut-Rafic Hariri International Airport',
      city: 'Beirut',
      country: 'Lebanon'),
  'IKA': _AirportDetails(
      name: 'Imam Khomeini International Airport',
      city: 'Tehran',
      country: 'Iran'),
  'ISB': _AirportDetails(
      name: 'Islamabad International Airport',
      city: 'Islamabad',
      country: 'Pakistan'),
  'IST': _AirportDetails(
      name: 'Istanbul Airport', city: 'Istanbul', country: 'Turkey'),
  'SAW': _AirportDetails(
      name: 'Sabiha Gökçen International Airport',
      city: 'Istanbul',
      country: 'Turkey'),
  'ESB': _AirportDetails(
      name: 'Ankara Esenboğa Airport', city: 'Ankara', country: 'Turkey'),
  'ADB': _AirportDetails(
      name: 'Adnan Menderes Airport', city: 'İzmir', country: 'Turkey'),
  'AUH': _AirportDetails(
      name: 'Abu Dhabi International Airport',
      city: 'Abu Dhabi',
      country: 'United Arab Emirates'),
  'SHJ': _AirportDetails(
      name: 'Sharjah International Airport',
      city: 'Sharjah',
      country: 'United Arab Emirates'),
  'MED': _AirportDetails(
      name: 'Prince Mohammad bin Abdulaziz International Airport',
      city: 'Medina',
      country: 'Saudi Arabia'),
  'AHB': _AirportDetails(
      name: 'Abha International Airport',
      city: 'Abha',
      country: 'Saudi Arabia'),
  'ELQ': _AirportDetails(
      name: 'Prince Naif bin Abdulaziz International Airport',
      city: 'Qassim',
      country: 'Saudi Arabia'),
  'JZN': _AirportDetails(
      name: 'Jazan Airport', city: 'Jazan', country: 'Saudi Arabia'),
  'KFJ': _AirportDetails(
      name: 'King Fahd International Airport',
      city: 'Dammam',
      country: 'Saudi Arabia'),
  'DAM': _AirportDetails(
      name: 'Damascus International Airport',
      city: 'Damascus',
      country: 'Syria'),
  'BAG': _AirportDetails(
      name: 'Baghdad International Airport', city: 'Baghdad', country: 'Iraq'),
  'HRG': _AirportDetails(
      name: 'Hurghada International Airport',
      city: 'Hurghada',
      country: 'Egypt'),
  'SSH': _AirportDetails(
      name: 'Sharm El Sheikh International Airport',
      city: 'Sharm El Sheikh',
      country: 'Egypt'),
  'ALG': _AirportDetails(
      name: 'Houari Boumédiène Airport', city: 'Algiers', country: 'Algeria'),
  'ORN': _AirportDetails(
      name: 'Oran Es Sénia Airport', city: 'Oran', country: 'Algeria'),
  'CMN': _AirportDetails(
      name: 'Mohammed V International Airport',
      city: 'Casablanca',
      country: 'Morocco'),
  'RAK': _AirportDetails(
      name: 'Marrakech Menara Airport', city: 'Marrakech', country: 'Morocco'),
  'FEZ': _AirportDetails(
      name: 'Fès–Saïs Airport', city: 'Fes', country: 'Morocco'),
  'TUN': _AirportDetails(
      name: 'Tunis–Carthage International Airport',
      city: 'Tunis',
      country: 'Tunisia'),
  'DJE': _AirportDetails(
      name: 'Djerba–Zarzis International Airport',
      city: 'Djerba',
      country: 'Tunisia'),
  'NBE': _AirportDetails(
      name: 'Enfidha–Hammamet International Airport',
      city: 'Enfidha',
      country: 'Tunisia'),
  'KRT': _AirportDetails(
      name: 'Khartoum International Airport',
      city: 'Khartoum',
      country: 'Sudan'),

  // --- Global Famous Airports ---
  'JFK': _AirportDetails(
      name: 'John F. Kennedy International Airport',
      city: 'New York',
      country: 'United States'),
  'LAX': _AirportDetails(
      name: 'Los Angeles International Airport',
      city: 'Los Angeles',
      country: 'United States'),
  'LHR': _AirportDetails(
      name: 'London Heathrow Airport',
      city: 'London',
      country: 'United Kingdom'),
  'CDG': _AirportDetails(
      name: 'Paris Charles de Gaulle Airport',
      city: 'Paris',
      country: 'France'),
  'AMS': _AirportDetails(
      name: 'Amsterdam Airport Schiphol',
      city: 'Amsterdam',
      country: 'Netherlands'),
  'FRA': _AirportDetails(
      name: 'Frankfurt Airport', city: 'Frankfurt', country: 'Germany'),
  'SIN': _AirportDetails(
      name: 'Singapore Changi Airport',
      city: 'Singapore',
      country: 'Singapore'),
  'NRT': _AirportDetails(
      name: 'Narita International Airport', city: 'Tokyo', country: 'Japan'),
  'HND': _AirportDetails(
      name: 'Tokyo Haneda Airport', city: 'Tokyo', country: 'Japan'),
  'ICN': _AirportDetails(
      name: 'Incheon International Airport',
      city: 'Seoul',
      country: 'South Korea'),
  'BKK': _AirportDetails(
      name: 'Suvarnabhumi Airport', city: 'Bangkok', country: 'Thailand'),
  'SYD': _AirportDetails(
      name: 'Sydney Kingsford Smith Airport',
      city: 'Sydney',
      country: 'Australia'),
  'YYZ': _AirportDetails(
      name: 'Toronto Pearson International Airport',
      city: 'Toronto',
      country: 'Canada'),
  'ORD': _AirportDetails(
      name: 'Chicago O\'Hare International Airport',
      city: 'Chicago',
      country: 'United States'),
  'ATL': _AirportDetails(
      name: 'Hartsfield-Jackson Atlanta International Airport',
      city: 'Atlanta',
      country: 'United States'),
  'DEN': _AirportDetails(
      name: 'Denver International Airport',
      city: 'Denver',
      country: 'United States'),
  'MIA': _AirportDetails(
      name: 'Miami International Airport',
      city: 'Miami',
      country: 'United States'),
  'EWR': _AirportDetails(
      name: 'Newark Liberty International Airport',
      city: 'Newark',
      country: 'United States'),
  'SFO': _AirportDetails(
      name: 'San Francisco International Airport',
      city: 'San Francisco',
      country: 'United States'),
  'SEA': _AirportDetails(
      name: 'Seattle-Tacoma International Airport',
      city: 'Seattle',
      country: 'United States'),
  'MCO': _AirportDetails(
      name: 'Orlando International Airport',
      city: 'Orlando',
      country: 'United States'),
  'LAS': _AirportDetails(
      name: 'Harry Reid International Airport',
      city: 'Las Vegas',
      country: 'United States'),
  'CLT': _AirportDetails(
      name: 'Charlotte Douglas International Airport',
      city: 'Charlotte',
      country: 'United States'),
  'PHX': _AirportDetails(
      name: 'Phoenix Sky Harbor International Airport',
      city: 'Phoenix',
      country: 'United States'),
  'DFW': _AirportDetails(
      name: 'Dallas/Fort Worth International Airport',
      city: 'Dallas/Fort Worth',
      country: 'United States'),
  'BCN': _AirportDetails(
      name: 'Josep Tarradellas Barcelona–El Prat Airport',
      city: 'Barcelona',
      country: 'Spain'),
  'MUC': _AirportDetails(
      name: 'Munich Airport', city: 'Munich', country: 'Germany'),
  'FCO': _AirportDetails(
      name: 'Leonardo da Vinci–Fiumicino Airport',
      city: 'Rome',
      country: 'Italy'),
  'MAD': _AirportDetails(
      name: 'Adolfo Suárez Madrid–Barajas Airport',
      city: 'Madrid',
      country: 'Spain'),
  'CPH': _AirportDetails(
      name: 'Copenhagen Airport', city: 'Copenhagen', country: 'Denmark'),
  'OSL': _AirportDetails(
      name: 'Oslo Airport, Gardermoen', city: 'Oslo', country: 'Norway'),
  'ARN': _AirportDetails(
      name: 'Stockholm Arlanda Airport', city: 'Stockholm', country: 'Sweden'),
  'HEL': _AirportDetails(
      name: 'Helsinki Airport', city: 'Helsinki', country: 'Finland'),
  'DUB': _AirportDetails(
      name: 'Dublin Airport', city: 'Dublin', country: 'Ireland'),
  'ZRH': _AirportDetails(
      name: 'Zurich Airport', city: 'Zurich', country: 'Switzerland'),
  'VIE': _AirportDetails(
      name: 'Vienna International Airport', city: 'Vienna', country: 'Austria'),
  'BRU': _AirportDetails(
      name: 'Brussels Airport', city: 'Brussels', country: 'Belgium'),
  'LIS': _AirportDetails(
      name: 'Lisbon Airport', city: 'Lisbon', country: 'Portugal'),
  'PRG': _AirportDetails(
      name: 'Václav Havel Airport Prague',
      city: 'Prague',
      country: 'Czech Republic'),
  'WAW': _AirportDetails(
      name: 'Warsaw Chopin Airport', city: 'Warsaw', country: 'Poland'),
  'BUD': _AirportDetails(
      name: 'Budapest Ferenc Liszt International Airport',
      city: 'Budapest',
      country: 'Hungary'),
  'ATH': _AirportDetails(
      name: 'Athens International Airport', city: 'Athens', country: 'Greece'),
  'CPT': _AirportDetails(
      name: 'Cape Town International Airport',
      city: 'Cape Town',
      country: 'South Africa'),
  'JNB': _AirportDetails(
      name: 'O. R. Tambo International Airport',
      city: 'Johannesburg',
      country: 'South Africa'),
  'NBO': _AirportDetails(
      name: 'Jomo Kenyatta International Airport',
      city: 'Nairobi',
      country: 'Kenya'),
  'ADD': _AirportDetails(
      name: 'Addis Ababa Bole International Airport',
      city: 'Addis Ababa',
      country: 'Ethiopia'),
  'LOS': _AirportDetails(
      name: 'Murtala Muhammed International Airport',
      city: 'Lagos',
      country: 'Nigeria'),
  'ACC': _AirportDetails(
      name: 'Kotoka International Airport', city: 'Accra', country: 'Ghana'),
  'DAR': _AirportDetails(
      name: 'Julius Nyerere International Airport',
      city: 'Dar es Salaam',
      country: 'Tanzania'),
  'KUL': _AirportDetails(
      name: 'Kuala Lumpur International Airport',
      city: 'Kuala Lumpur',
      country: 'Malaysia'),
  'MNL': _AirportDetails(
      name: 'Ninoy Aquino International Airport',
      city: 'Manila',
      country: 'Philippines'),
  'CGK': _AirportDetails(
      name: 'Soekarno-Hatta International Airport',
      city: 'Jakarta',
      country: 'Indonesia'),
  'SGN': _AirportDetails(
      name: 'Tan Son Nhat International Airport',
      city: 'Ho Chi Minh City',
      country: 'Vietnam'),
  'HAN': _AirportDetails(
      name: 'Noi Bai International Airport', city: 'Hanoi', country: 'Vietnam'),
  'DEL': _AirportDetails(
      name: 'Indira Gandhi International Airport',
      city: 'Delhi',
      country: 'India'),
  'BOM': _AirportDetails(
      name: 'Chhatrapati Shivaji Maharaj International Airport',
      city: 'Mumbai',
      country: 'India'),
  'BLR': _AirportDetails(
      name: 'Kempegowda International Airport',
      city: 'Bengaluru',
      country: 'India'),
  'MAA': _AirportDetails(
      name: 'Chennai International Airport', city: 'Chennai', country: 'India'),
  'CCU': _AirportDetails(
      name: 'Netaji Subhas Chandra Bose International Airport',
      city: 'Kolkata',
      country: 'India'),
  'KIX': _AirportDetails(
      name: 'Kansai International Airport', city: 'Osaka', country: 'Japan'),
  'PVG': _AirportDetails(
      name: 'Shanghai Pudong International Airport',
      city: 'Shanghai',
      country: 'China'),
  'CAN': _AirportDetails(
      name: 'Guangzhou Baiyun International Airport',
      city: 'Guangzhou',
      country: 'China'),
  'CTU': _AirportDetails(
      name: 'Chengdu Shuangliu International Airport',
      city: 'Chengdu',
      country: 'China'),
  'SZX': _AirportDetails(
      name: 'Shenzhen Bao\'an International Airport',
      city: 'Shenzhen',
      country: 'China'),
  'TPE': _AirportDetails(
      name: 'Taiwan Taoyuan International Airport',
      city: 'Taipei',
      country: 'Taiwan'),
  'AKL': _AirportDetails(
      name: 'Auckland Airport', city: 'Auckland', country: 'New Zealand'),
  'MEL': _AirportDetails(
      name: 'Melbourne Airport', city: 'Melbourne', country: 'Australia'),
  'BNE': _AirportDetails(
      name: 'Brisbane Airport', city: 'Brisbane', country: 'Australia'),
  'PER': _AirportDetails(
      name: 'Perth Airport', city: 'Perth', country: 'Australia'),
  'ADL': _AirportDetails(
      name: 'Adelaide Airport', city: 'Adelaide', country: 'Australia'),
  'YVR': _AirportDetails(
      name: 'Vancouver International Airport',
      city: 'Vancouver',
      country: 'Canada'),
  'YUL': _AirportDetails(
      name: 'Montréal–Pierre Elliott Trudeau International Airport',
      city: 'Montreal',
      country: 'Canada'),
  'YYC': _AirportDetails(
      name: 'Calgary International Airport',
      city: 'Calgary',
      country: 'Canada'),
  'MEX': _AirportDetails(
      name: 'Mexico City International Airport',
      city: 'Mexico City',
      country: 'Mexico'),
  'CUN': _AirportDetails(
      name: 'Cancún International Airport', city: 'Cancún', country: 'Mexico'),
  'GRU': _AirportDetails(
      name:
          'São Paulo/Guarulhos–Governador André Franco Montoro International Airport',
      city: 'São Paulo',
      country: 'Brazil'),
  'GIG': _AirportDetails(
      name: 'Rio de Janeiro/Galeão–Antonio Carlos Jobim International Airport',
      city: 'Rio de Janeiro',
      country: 'Brazil'),
  'BOG': _AirportDetails(
      name: 'El Dorado International Airport',
      city: 'Bogotá',
      country: 'Colombia'),
  'LIM': _AirportDetails(
      name: 'Jorge Chávez International Airport',
      city: 'Lima',
      country: 'Peru'),
  'SCL': _AirportDetails(
      name: 'Arturo Merino Benítez International Airport',
      city: 'Santiago',
      country: 'Chile'),
  'EZE': _AirportDetails(
      name: 'Ministro Pistarini International Airport',
      city: 'Buenos Aires',
      country: 'Argentina'),
  'SJO': _AirportDetails(
      name: 'Juan Santamaría International Airport',
      city: 'San José',
      country: 'Costa Rica'),
  'PTY': _AirportDetails(
      name: 'Tocumen International Airport',
      city: 'Panama City',
      country: 'Panama'),
  'HAV': _AirportDetails(
      name: 'José Martí International Airport',
      city: 'Havana',
      country: 'Cuba'),
  'SJU': _AirportDetails(
      name: 'Luis Muñoz Marín International Airport',
      city: 'San Juan',
      country: 'Puerto Rico'),
  'MBJ': _AirportDetails(
      name: 'Sangster International Airport',
      city: 'Montego Bay',
      country: 'Jamaica'),
  'NAS': _AirportDetails(
      name: 'Lynden Pindling International Airport',
      city: 'Nassau',
      country: 'Bahamas'),
  'PUJ': _AirportDetails(
      name: 'Punta Cana International Airport',
      city: 'Punta Cana',
      country: 'Dominican Republic'),
  'LGW': _AirportDetails(
      name: 'London Gatwick Airport',
      city: 'London',
      country: 'United Kingdom'),
  'MAN': _AirportDetails(
      name: 'Manchester Airport',
      city: 'Manchester',
      country: 'United Kingdom'),
  'DUS': _AirportDetails(
      name: 'Düsseldorf Airport', city: 'Düsseldorf', country: 'Germany'),
  'BER': _AirportDetails(
      name: 'Berlin Brandenburg Airport', city: 'Berlin', country: 'Germany'),
  'PMI': _AirportDetails(
      name: 'Palma de Mallorca Airport',
      city: 'Palma de Mallorca',
      country: 'Spain'),
  'SOF': _AirportDetails(
      name: 'Sofia Airport', city: 'Sofia', country: 'Bulgaria'),
  'OTP': _AirportDetails(
      name: 'Henri Coandă International Airport',
      city: 'Bucharest',
      country: 'Romania'),
  'KBP': _AirportDetails(
      name: 'Boryspil International Airport', city: 'Kyiv', country: 'Ukraine'),
  'LED': _AirportDetails(
      name: 'Pulkovo Airport', city: 'Saint Petersburg', country: 'Russia'),
  'VKO': _AirportDetails(
      name: 'Vnukovo International Airport', city: 'Moscow', country: 'Russia'),
  'DME': _AirportDetails(
      name: 'Domodedovo International Airport',
      city: 'Moscow',
      country: 'Russia'),
  'SVO': _AirportDetails(
      name: 'Sheremetyevo International Airport',
      city: 'Moscow',
      country: 'Russia'),
  'HNL': _AirportDetails(
      name: 'Daniel K. Inouye International Airport',
      city: 'Honolulu',
      country: 'United States'),
  'OGG': _AirportDetails(
      name: 'Kahului Airport', city: 'Kahului', country: 'United States'),
  'ANC': _AirportDetails(
      name: 'Ted Stevens Anchorage International Airport',
      city: 'Anchorage',
      country: 'United States'),
  'PDX': _AirportDetails(
      name: 'Portland International Airport',
      city: 'Portland',
      country: 'United States'),
  'SAN': _AirportDetails(
      name: 'San Diego International Airport',
      city: 'San Diego',
      country: 'United States'),
  'STL': _AirportDetails(
      name: 'St. Louis Lambert International Airport',
      city: 'St. Louis',
      country: 'United States'),
  'MSP': _AirportDetails(
      name: 'Minneapolis–Saint Paul International Airport',
      city: 'Minneapolis',
      country: 'United States'),
  'DTW': _AirportDetails(
      name: 'Detroit Metropolitan Wayne County Airport',
      city: 'Detroit',
      country: 'United States'),
  'MCI': _AirportDetails(
      name: 'Kansas City International Airport',
      city: 'Kansas City',
      country: 'United States'),
  'CLE': _AirportDetails(
      name: 'Cleveland Hopkins International Airport',
      city: 'Cleveland',
      country: 'United States'),
  'IND': _AirportDetails(
      name: 'Indianapolis International Airport',
      city: 'Indianapolis',
      country: 'United States'),
  'CMH': _AirportDetails(
      name: 'John Glenn Columbus International Airport',
      city: 'Columbus',
      country: 'United States'),
  'PIT': _AirportDetails(
      name: 'Pittsburgh International Airport',
      city: 'Pittsburgh',
      country: 'United States'),
  'RDU': _AirportDetails(
      name: 'Raleigh–Durham International Airport',
      city: 'Raleigh/Durham',
      country: 'United States'),
  'BNA': _AirportDetails(
      name: 'Nashville International Airport',
      city: 'Nashville',
      country: 'United States'),
  'MEM': _AirportDetails(
      name: 'Memphis International Airport',
      city: 'Memphis',
      country: 'United States'),
  'BHM': _AirportDetails(
      name: 'Birmingham-Shuttlesworth International Airport',
      city: 'Birmingham',
      country: 'United States'),
  'MSY': _AirportDetails(
      name: 'Louis Armstrong New Orleans International Airport',
      city: 'New Orleans',
      country: 'United States'),
  'HOU': _AirportDetails(
      name: 'William P. Hobby Airport',
      city: 'Houston',
      country: 'United States'),
  'AUS': _AirportDetails(
      name: 'Austin-Bergstrom International Airport',
      city: 'Austin',
      country: 'United States'),
  'SAT': _AirportDetails(
      name: 'San Antonio International Airport',
      city: 'San Antonio',
      country: 'United States'),
  'OKC': _AirportDetails(
      name: 'Will Rogers World Airport',
      city: 'Oklahoma City',
      country: 'United States'),
  'TUL': _AirportDetails(
      name: 'Tulsa International Airport',
      city: 'Tulsa',
      country: 'United States'),
  'ICT': _AirportDetails(
      name: 'Wichita Dwight D. Eisenhower National Airport',
      city: 'Wichita',
      country: 'United States'),
  'OMA': _AirportDetails(
      name: 'Eppley Airfield', city: 'Omaha', country: 'United States'),
  'DSM': _AirportDetails(
      name: 'Des Moines International Airport',
      city: 'Des Moines',
      country: 'United States'),
  'MKE': _AirportDetails(
      name: 'Milwaukee Mitchell International Airport',
      city: 'Milwaukee',
      country: 'United States'),
  'GRR': _AirportDetails(
      name: 'Gerald R. Ford International Airport',
      city: 'Grand Rapids',
      country: 'United States'),
  'CVG': _AirportDetails(
      name: 'Cincinnati/Northern Kentucky International Airport',
      city: 'Cincinnati',
      country: 'United States'),
  'BUF': _AirportDetails(
      name: 'Buffalo Niagara International Airport',
      city: 'Buffalo',
      country: 'United States'),
  'ROC': _AirportDetails(
      name: 'Greater Rochester International Airport',
      city: 'Rochester',
      country: 'United States'),
  'SYR': _AirportDetails(
      name: 'Syracuse Hancock International Airport',
      city: 'Syracuse',
      country: 'United States'),
  'BOS': _AirportDetails(
      name: 'Logan International Airport',
      city: 'Boston',
      country: 'United States'),
  'PVD': _AirportDetails(
      name: 'T. F. Green Airport',
      city: 'Providence',
      country: 'United States'),
  'PHL': _AirportDetails(
      name: 'Philadelphia International Airport',
      city: 'Philadelphia',
      country: 'United States'),
  'BWI': _AirportDetails(
      name: 'Baltimore/Washington International Thurgood Marshall Airport',
      city: 'Baltimore',
      country: 'United States'),
  'IAD': _AirportDetails(
      name: 'Dulles International Airport',
      city: 'Washington D.C.',
      country: 'United States'),
  'DCA': _AirportDetails(
      name: 'Ronald Reagan Washington National Airport',
      city: 'Washington D.C.',
      country: 'United States'),
  'RIC': _AirportDetails(
      name: 'Richmond International Airport',
      city: 'Richmond',
      country: 'United States'),
  'ORF': _AirportDetails(
      name: 'Norfolk International Airport',
      city: 'Norfolk',
      country: 'United States'),
  'GSO': _AirportDetails(
      name: 'Piedmont Triad International Airport',
      city: 'Greensboro',
      country: 'United States'),
  'CHS': _AirportDetails(
      name: 'Charleston International Airport',
      city: 'Charleston',
      country: 'United States'),
  'SAV': _AirportDetails(
      name: 'Savannah/Hilton Head International Airport',
      city: 'Savannah',
      country: 'United States'),
  'JAX': _AirportDetails(
      name: 'Jacksonville International Airport',
      city: 'Jacksonville',
      country: 'United States'),
  'TPA': _AirportDetails(
      name: 'Tampa International Airport',
      city: 'Tampa',
      country: 'United States'),
  'FLL': _AirportDetails(
      name: 'Fort Lauderdale–Hollywood International Airport',
      city: 'Fort Lauderdale',
      country: 'United States'),
  'PBI': _AirportDetails(
      name: 'Palm Beach International Airport',
      city: 'West Palm Beach',
      country: 'United States'),
  'RSW': _AirportDetails(
      name: 'Southwest Florida International Airport',
      city: 'Fort Myers',
      country: 'United States'),
  'SRQ': _AirportDetails(
      name: 'Sarasota–Bradenton International Airport',
      city: 'Sarasota',
      country: 'United States'),
  'GSP': _AirportDetails(
      name: 'Greenville–Spartanburg International Airport',
      city: 'Greenville',
      country: 'United States'),
  'TRI': _AirportDetails(
      name: 'Tri-Cities Airport',
      city: 'Blountville',
      country: 'United States'),
  'CAE': _AirportDetails(
      name: 'Columbia Metropolitan Airport',
      city: 'Columbia',
      country: 'United States'),
  'BZN': _AirportDetails(
      name: 'Bozeman Yellowstone International Airport',
      city: 'Bozeman',
      country: 'United States'),
  'FCA': _AirportDetails(
      name: 'Glacier Park International Airport',
      city: 'Kalispell',
      country: 'United States'),
  'SLC': _AirportDetails(
      name: 'Salt Lake City International Airport',
      city: 'Salt Lake City',
      country: 'United States'),
  'BOI': _AirportDetails(
      name: 'Boise Airport', city: 'Boise', country: 'United States'),
  'GEG': _AirportDetails(
      name: 'Spokane International Airport',
      city: 'Spokane',
      country: 'United States'),
  'PSC': _AirportDetails(
      name: 'Tri-Cities Airport (Washington)',
      city: 'Pasco',
      country: 'United States'),
  'EUG': _AirportDetails(
      name: 'Eugene Airport', city: 'Eugene', country: 'United States'),
  'SMF': _AirportDetails(
      name: 'Sacramento International Airport',
      city: 'Sacramento',
      country: 'United States'),
  'SJC': _AirportDetails(
      name: 'San Jose International Airport',
      city: 'San Jose',
      country: 'United States'),
  'OAK': _AirportDetails(
      name: 'Oakland International Airport',
      city: 'Oakland',
      country: 'United States'),
  'BUR': _AirportDetails(
      name: 'Hollywood Burbank Airport',
      city: 'Burbank',
      country: 'United States'),
  'SNA': _AirportDetails(
      name: 'John Wayne Airport', city: 'Santa Ana', country: 'United States'),
  'ONT': _AirportDetails(
      name: 'Ontario International Airport',
      city: 'Ontario',
      country: 'United States'),
  'ABQ': _AirportDetails(
      name: 'Albuquerque International Sunport',
      city: 'Albuquerque',
      country: 'United States'),
  'ELP': _AirportDetails(
      name: 'El Paso International Airport',
      city: 'El Paso',
      country: 'United States'),
  'TUS': _AirportDetails(
      name: 'Tucson International Airport',
      city: 'Tucson',
      country: 'United States'),
  'MDW': _AirportDetails(
      name: 'Chicago Midway International Airport',
      city: 'Chicago',
      country: 'United States'),
  'BTV': _AirportDetails(
      name: 'Burlington International Airport',
      city: 'Burlington',
      country: 'United States'),
  'PWM': _AirportDetails(
      name: 'Portland International Jetport',
      city: 'Portland',
      country: 'United States'),
  'MHT': _AirportDetails(
      name: 'Manchester-Boston Regional Airport',
      city: 'Manchester',
      country: 'United States'),
  'ALB': _AirportDetails(
      name: 'Albany International Airport',
      city: 'Albany',
      country: 'United States'),
  'BDL': _AirportDetails(
      name: 'Bradley International Airport',
      city: 'Windsor Locks',
      country: 'United States'),
  'SDF': _AirportDetails(
      name: 'Louisville Muhammad Ali International Airport',
      city: 'Louisville',
      country: 'United States'),
  'TYS': _AirportDetails(
      name: 'McGhee Tyson Airport',
      city: 'Knoxville',
      country: 'United States'),
  'CHA': _AirportDetails(
      name: 'Chattanooga Metropolitan Airport',
      city: 'Chattanooga',
      country: 'United States'),
  'AVL': _AirportDetails(
      name: 'Asheville Regional Airport',
      city: 'Asheville',
      country: 'United States'),
  'EDI': _AirportDetails(
      name: 'Edinburgh Airport', city: 'Edinburgh', country: 'United Kingdom'),
  'GLA': _AirportDetails(
      name: 'Glasgow Airport', city: 'Glasgow', country: 'United Kingdom'),
  'BHX': _AirportDetails(
      name: 'Birmingham Airport',
      city: 'Birmingham',
      country: 'United Kingdom'),
  'MRS': _AirportDetails(
      name: 'Marseille Provence Airport', city: 'Marseille', country: 'France'),
  'NCE': _AirportDetails(
      name: 'Nice Côte d\'Azur Airport', city: 'Nice', country: 'France'),
  'LYS': _AirportDetails(
      name: 'Lyon–Saint-Exupéry Airport', city: 'Lyon', country: 'France'),
  'GVA': _AirportDetails(
      name: 'Geneva Airport', city: 'Geneva', country: 'Switzerland'),
  'BSL': _AirportDetails(
      name: 'EuroAirport Basel Mulhouse Freiburg',
      city: 'Basel/Mulhouse',
      country: 'Switzerland/France/Germany'),
  'BRN': _AirportDetails(
      name: 'Bern Airport', city: 'Bern', country: 'Switzerland'),
  'INN': _AirportDetails(
      name: 'Innsbruck Airport', city: 'Innsbruck', country: 'Austria'),
  'GRZ':
      _AirportDetails(name: 'Graz Airport', city: 'Graz', country: 'Austria'),
  'SZG': _AirportDetails(
      name: 'Salzburg Airport', city: 'Salzburg', country: 'Austria'),
  'HAJ': _AirportDetails(
      name: 'Hannover Airport', city: 'Hannover', country: 'Germany'),
  'CGN': _AirportDetails(
      name: 'Cologne Bonn Airport', city: 'Cologne/Bonn', country: 'Germany'),
  'LEJ': _AirportDetails(
      name: 'Leipzig/Halle Airport', city: 'Leipzig/Halle', country: 'Germany'),
  'STR': _AirportDetails(
      name: 'Stuttgart Airport', city: 'Stuttgart', country: 'Germany'),
  'NUE': _AirportDetails(
      name: 'Nuremberg Airport', city: 'Nuremberg', country: 'Germany'),
  'HAM': _AirportDetails(
      name: 'Hamburg Airport', city: 'Hamburg', country: 'Germany'),
  'BRE': _AirportDetails(
      name: 'Bremen Airport', city: 'Bremen', country: 'Germany'),
  'DRS': _AirportDetails(
      name: 'Dresden Airport', city: 'Dresden', country: 'Germany'),
  'FLR': _AirportDetails(
      name: 'Florence Airport, Peretola', city: 'Florence', country: 'Italy'),
  'VCE': _AirportDetails(
      name: 'Venice Marco Polo Airport', city: 'Venice', country: 'Italy'),
  'MXP': _AirportDetails(
      name: 'Milan Malpensa Airport', city: 'Milan', country: 'Italy'),
  'LIN': _AirportDetails(
      name: 'Milan Linate Airport', city: 'Milan', country: 'Italy'),
  'NAP': _AirportDetails(
      name: 'Naples International Airport', city: 'Naples', country: 'Italy'),
  'BLQ': _AirportDetails(
      name: 'Bologna Guglielmo Marconi Airport',
      city: 'Bologna',
      country: 'Italy'),
  'PSA': _AirportDetails(
      name: 'Pisa International Airport', city: 'Pisa', country: 'Italy'),
  'CTA': _AirportDetails(
      name: 'Catania–Fontanarossa Airport', city: 'Catania', country: 'Italy'),
  'PMO': _AirportDetails(
      name: 'Falcone Borsellino Airport', city: 'Palermo', country: 'Italy'),
  'ZNZ': _AirportDetails(
      name: 'Abeid Amani Karume International Airport',
      city: 'Zanzibar City',
      country: 'Tanzania'),
  'KGL': _AirportDetails(
      name: 'Kigali International Airport', city: 'Kigali', country: 'Rwanda'),
  'EBB': _AirportDetails(
      name: 'Entebbe International Airport',
      city: 'Entebbe',
      country: 'Uganda'),
  'LLW': _AirportDetails(
      name: 'Lilongwe International Airport',
      city: 'Lilongwe',
      country: 'Malawi'),
  'LUN': _AirportDetails(
      name: 'Kenneth Kaunda International Airport',
      city: 'Lusaka',
      country: 'Zambia'),
  'HRE': _AirportDetails(
      name: 'Robert Gabriel Mugabe International Airport',
      city: 'Harare',
      country: 'Zimbabwe'),
  'MRU': _AirportDetails(
      name: 'Sir Seewoosagur Ramgoolam International Airport',
      city: 'Port Louis',
      country: 'Mauritius'),
  'SEZ': _AirportDetails(
      name: 'Seychelles International Airport',
      city: 'Mahé',
      country: 'Seychelles'),
  'FIH': _AirportDetails(
      name: 'N\'djili Airport', city: 'Kinshasa', country: 'DR Congo'),
  'CKY': _AirportDetails(
      name: 'Conakry International Airport',
      city: 'Conakry',
      country: 'Guinea'),
  'BXO': _AirportDetails(
      name: 'Osvaldo Vieira International Airport',
      city: 'Bissau',
      country: 'Guinea-Bissau'),
  'SID': _AirportDetails(
      name: 'Amílcar Cabral International Airport',
      city: 'Sal',
      country: 'Cape Verde'),
  'RAI': _AirportDetails(
      name: 'Nelson Mandela International Airport',
      city: 'Praia',
      country: 'Cape Verde'),
  'RUN': _AirportDetails(
      name: 'Roland Garros Airport', city: 'Saint-Denis', country: 'Réunion'),
  'DZA': _AirportDetails(
      name: 'Dzaoudzi–Pamandzi International Airport',
      city: 'Dzaoudzi',
      country: 'Mayotte'),
  'TNR': _AirportDetails(
      name: 'Ivato International Airport',
      city: 'Antananarivo',
      country: 'Madagascar'),
  'EAS': _AirportDetails(
      name: 'San Sebastián Airport', city: 'San Sebastián', country: 'Spain'),
  'BIO':
      _AirportDetails(name: 'Bilbao Airport', city: 'Bilbao', country: 'Spain'),
  'AGP':
      _AirportDetails(name: 'Málaga Airport', city: 'Málaga', country: 'Spain'),
  'FAO':
      _AirportDetails(name: 'Faro Airport', city: 'Faro', country: 'Portugal'),
  'OPO': _AirportDetails(
      name: 'Porto Airport', city: 'Porto', country: 'Portugal'),
  'FNC': _AirportDetails(
      name: 'Madeira Airport', city: 'Funchal', country: 'Portugal'),
  'PIR': _AirportDetails(
      name: 'Priština International Airport Adem Jashari',
      city: 'Pristina',
      country: 'Kosovo'),
  'SJJ': _AirportDetails(
      name: 'Sarajevo International Airport',
      city: 'Sarajevo',
      country: 'Bosnia and Herzegovina'),
  'SKP': _AirportDetails(
      name: 'Skopje International Airport',
      city: 'Skopje',
      country: 'North Macedonia'),
  'TGD': _AirportDetails(
      name: 'Podgorica Airport', city: 'Podgorica', country: 'Montenegro'),
  'TIV': _AirportDetails(
      name: 'Tivat Airport', city: 'Tivat', country: 'Montenegro'),
  'DBV': _AirportDetails(
      name: 'Dubrovnik Airport', city: 'Dubrovnik', country: 'Croatia'),
  'SPU':
      _AirportDetails(name: 'Split Airport', city: 'Split', country: 'Croatia'),
  'ZAD':
      _AirportDetails(name: 'Zadar Airport', city: 'Zadar', country: 'Croatia'),
  'PUY':
      _AirportDetails(name: 'Pula Airport', city: 'Pula', country: 'Croatia'),
  'LJU': _AirportDetails(
      name: 'Ljubljana Jože Pučnik Airport',
      city: 'Ljubljana',
      country: 'Slovenia'),
  'BTS': _AirportDetails(
      name: 'Bratislava Airport', city: 'Bratislava', country: 'Slovakia'),
  'KTW': _AirportDetails(
      name: 'Katowice Airport', city: 'Katowice', country: 'Poland'),
  'POZ': _AirportDetails(
      name: 'Poznań–Ławica Henryk Wieniawski Airport',
      city: 'Poznań',
      country: 'Poland'),
  'GDN': _AirportDetails(
      name: 'Gdańsk Lech Wałęsa Airport', city: 'Gdańsk', country: 'Poland'),
  'VNO': _AirportDetails(
      name: 'Vilnius Airport', city: 'Vilnius', country: 'Lithuania'),
  'RIX': _AirportDetails(
      name: 'Riga International Airport', city: 'Riga', country: 'Latvia'),
  'TLL': _AirportDetails(
      name: 'Tallinn Airport', city: 'Tallinn', country: 'Estonia'),
  'KIV': _AirportDetails(
      name: 'Chișinău International Airport',
      city: 'Chișinău',
      country: 'Moldova'),
  'VAR': _AirportDetails(
      name: 'Varna Airport', city: 'Varna', country: 'Bulgaria'),
  'CLJ': _AirportDetails(
      name: 'Cluj International Airport',
      city: 'Cluj-Napoca',
      country: 'Romania'),
  'IAS': _AirportDetails(
      name: 'Iași International Airport', city: 'Iași', country: 'Romania'),
  'KGD': _AirportDetails(
      name: 'Khrabrovo Airport', city: 'Kaliningrad', country: 'Russia'),
  'KZN': _AirportDetails(
      name: 'Kazan International Airport', city: 'Kazan', country: 'Russia'),
  'OVB': _AirportDetails(
      name: 'Tolmachevo Airport', city: 'Novosibirsk', country: 'Russia'),
  'CEK': _AirportDetails(
      name: 'Chelyabinsk Airport', city: 'Chelyabinsk', country: 'Russia'),
  'UFA': _AirportDetails(
      name: 'Ufa International Airport', city: 'Ufa', country: 'Russia'),
  'KRR': _AirportDetails(
      name: 'Krasnodar International Airport',
      city: 'Krasnodar',
      country: 'Russia'),
  'ROV': _AirportDetails(
      name: 'Platov International Airport',
      city: 'Rostov-on-Don',
      country: 'Russia'),
  'AER': _AirportDetails(
      name: 'Sochi International Airport', city: 'Sochi', country: 'Russia'),
  'SVX': _AirportDetails(
      name: 'Koltsovo International Airport',
      city: 'Yekaterinburg',
      country: 'Russia'),
  'OMS': _AirportDetails(
      name: 'Omsk Tsentralny Airport', city: 'Omsk', country: 'Russia'),
  'IRK': _AirportDetails(
      name: 'Irkutsk International Airport',
      city: 'Irkutsk',
      country: 'Russia'),
  'KHV': _AirportDetails(
      name: 'Khabarovsk Novy Airport', city: 'Khabarovsk', country: 'Russia'),
  'VVO': _AirportDetails(
      name: 'Vladivostok International Airport',
      city: 'Vladivostok',
      country: 'Russia'),
  'YKS': _AirportDetails(
      name: 'Yakutsk Airport', city: 'Yakutsk', country: 'Russia'),
  'KRK': _AirportDetails(
      name: 'John Paul II International Airport Kraków-Balice',
      city: 'Kraków',
      country: 'Poland'),
  'WRO': _AirportDetails(
      name: 'Copernicus Airport Wrocław', city: 'Wrocław', country: 'Poland'),
  'LUZ': _AirportDetails(
      name: 'Lublin Airport', city: 'Lublin', country: 'Poland'),
  'RZE': _AirportDetails(
      name: 'Rzeszów–Jasionka Airport', city: 'Rzeszów', country: 'Poland'),
  'SZC': _AirportDetails(
      name: 'Solidarity Szczecin–Goleniów Airport',
      city: 'Szczecin',
      country: 'Poland'),
  'DEB': _AirportDetails(
      name: 'Debrecen International Airport',
      city: 'Debrecen',
      country: 'Hungary'),
  'LNZ':
      _AirportDetails(name: 'Linz Airport', city: 'Linz', country: 'Austria'),
  'LUX': _AirportDetails(
      name: 'Luxembourg Airport',
      city: 'Luxembourg City',
      country: 'Luxembourg'),
  'CRL': _AirportDetails(
      name: 'Brussels South Charleroi Airport',
      city: 'Charleroi',
      country: 'Belgium'),
  'EIN': _AirportDetails(
      name: 'Eindhoven Airport', city: 'Eindhoven', country: 'Netherlands'),
  'RTM': _AirportDetails(
      name: 'Rotterdam The Hague Airport',
      city: 'Rotterdam',
      country: 'Netherlands'),
  'AAL': _AirportDetails(
      name: 'Aalborg Airport', city: 'Aalborg', country: 'Denmark'),
  'BLL': _AirportDetails(
      name: 'Billund Airport', city: 'Billund', country: 'Denmark'),
  'BGO': _AirportDetails(
      name: 'Bergen Airport, Flesland', city: 'Bergen', country: 'Norway'),
  'TRD': _AirportDetails(
      name: 'Trondheim Airport, Værnes', city: 'Trondheim', country: 'Norway'),
  'SVG': _AirportDetails(
      name: 'Stavanger Airport, Sola', city: 'Stavanger', country: 'Norway'),
  'GOT': _AirportDetails(
      name: 'Göteborg Landvetter Airport',
      city: 'Gothenburg',
      country: 'Sweden'),
  'MMX':
      _AirportDetails(name: 'Malmö Airport', city: 'Malmö', country: 'Sweden'),
  'KEF': _AirportDetails(
      name: 'Keflavík International Airport',
      city: 'Reykjavík',
      country: 'Iceland'),
  'LPA': _AirportDetails(
      name: 'Gran Canaria Airport', city: 'Las Palmas', country: 'Spain'),
  'TFS': _AirportDetails(
      name: 'Tenerife South Airport', city: 'Tenerife', country: 'Spain'),
  'ACE': _AirportDetails(
      name: 'Lanzarote Airport', city: 'Arrecife', country: 'Spain'),
  'FUE': _AirportDetails(
      name: 'Fuerteventura Airport', city: 'Fuerteventura', country: 'Spain'),
  'SPC': _AirportDetails(
      name: 'La Palma Airport',
      city: 'Santa Cruz de La Palma',
      country: 'Spain'),
  'IBZ':
      _AirportDetails(name: 'Ibiza Airport', city: 'Ibiza', country: 'Spain'),
  'MAH': _AirportDetails(
      name: 'Menorca Airport', city: 'Menorca', country: 'Spain'),
  'SVQ': _AirportDetails(
      name: 'Seville Airport', city: 'Seville', country: 'Spain'),
  'VLC': _AirportDetails(
      name: 'Valencia Airport', city: 'Valencia', country: 'Spain'),
  'SNN': _AirportDetails(
      name: 'Shannon Airport', city: 'Shannon', country: 'Ireland'),
  'ORK':
      _AirportDetails(name: 'Cork Airport', city: 'Cork', country: 'Ireland'),
  'BFS': _AirportDetails(
      name: 'George Best Belfast City Airport',
      city: 'Belfast',
      country: 'United Kingdom'),
  'BHD': _AirportDetails(
      name: 'Belfast International Airport',
      city: 'Belfast',
      country: 'United Kingdom'),
  'GIB': _AirportDetails(
      name: 'Gibraltar International Airport',
      city: 'Gibraltar',
      country: 'Gibraltar'),
  'HER': _AirportDetails(
      name: 'Heraklion International Airport, "Nikos Kazantzakis"',
      city: 'Heraklion',
      country: 'Greece'),
  'RHO': _AirportDetails(
      name: 'Rhodes International Airport, "Diagoras"',
      city: 'Rhodes',
      country: 'Greece'),
  'KGS': _AirportDetails(
      name: 'Kos International Airport, "Hippocrates"',
      city: 'Kos',
      country: 'Greece'),
  'JTR': _AirportDetails(
      name: 'Santorini (Thira) International Airport',
      city: 'Santorini',
      country: 'Greece'),
  'MYK': _AirportDetails(
      name: 'Mykonos Island National Airport',
      city: 'Mykonos',
      country: 'Greece'),
  'MLE': _AirportDetails(
      name: 'Velana International Airport', city: 'Malé', country: 'Maldives'),
  'CMB': _AirportDetails(
      name: 'Bandaranaike International Airport',
      city: 'Colombo',
      country: 'Sri Lanka'),
  'KTM': _AirportDetails(
      name: 'Tribhuvan International Airport',
      city: 'Kathmandu',
      country: 'Nepal'),
  'DAC': _AirportDetails(
      name: 'Hazrat Shahjalal International Airport',
      city: 'Dhaka',
      country: 'Bangladesh'),
  'RGN': _AirportDetails(
      name: 'Yangon International Airport', city: 'Yangon', country: 'Myanmar'),
  'PHN': _AirportDetails(
      name: 'Phnom Penh International Airport',
      city: 'Phnom Penh',
      country: 'Cambodia'),
  'VTE': _AirportDetails(
      name: 'Wattay International Airport', city: 'Vientiane', country: 'Laos'),
  'ULN': _AirportDetails(
      name: 'Chinggis Khaan International Airport',
      city: 'Ulaanbaatar',
      country: 'Mongolia'),
  'TSE': _AirportDetails(
      name: 'Nursultan Nazarbayev International Airport',
      city: 'Nur-Sultan',
      country: 'Kazakhstan'),
  'TAS': _AirportDetails(
      name: 'Tashkent International Airport',
      city: 'Tashkent',
      country: 'Uzbekistan'),
  'FRU': _AirportDetails(
      name: 'Manas International Airport',
      city: 'Bishkek',
      country: 'Kyrgyzstan'),
  'DYU': _AirportDetails(
      name: 'Dushanbe International Airport',
      city: 'Dushanbe',
      country: 'Tajikistan'),
  'ASB': _AirportDetails(
      name: 'Ashgabat International Airport',
      city: 'Ashgabat',
      country: 'Turkmenistan'),
  'BAK': _AirportDetails(
      name: 'Heydar Aliyev International Airport',
      city: 'Baku',
      country: 'Azerbaijan'),
  'TBS': _AirportDetails(
      name: 'Tbilisi International Airport',
      city: 'Tbilisi',
      country: 'Georgia'),
  'EVN': _AirportDetails(
      name: 'Zvartnots International Airport',
      city: 'Yerevan',
      country: 'Armenia'),
};

/// Returns a map of airport details (name, city, country) for a given IATA code.
///
/// The [iataCode] is case-insensitive.
/// Returns null if the IATA code is not found in the `famousAirports` map.
Map<String, String> getAirportDetails(String iataCode) {
  final airportDetails = _famousAirports[iataCode.toUpperCase()];
  return airportDetails?.toMap() ??
      {
        'name': 'Unknown Airport',
        'city': 'Unknown City',
        'country': 'Unknown Country',
      };
}

/// Returns the AirportDetails object for a given IATA code.
///
/// The [iataCode] is case-insensitive.
/// Returns null if the IATA code is not found in the `famousAirports` map.
// _AirportDetails? getAirportDetailsObject(String iataCode) {
//   return _famousAirports[iataCode.toUpperCase()];
// }
