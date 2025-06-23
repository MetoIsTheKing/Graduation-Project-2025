// lib/airport_mapper.dart

/// A class to hold the detailed information for an airport.
class AirportDetails {
  final String name;
  final String city;
  final String country;

  AirportDetails(
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
final Map<String, AirportDetails> famousAirports = {
  // --- Middle East & North Africa Airports (Prioritized) ---
  'DXB': AirportDetails(
      name: 'Dubai International Airport',
      city: 'Dubai',
      country: 'United Arab Emirates'),
  'DOH': AirportDetails(
      name: 'Hamad International Airport', city: 'Doha', country: 'Qatar'),
  'CAI': AirportDetails(
      name: 'Cairo International Airport', city: 'Cairo', country: 'Egypt'),
  'JED': AirportDetails(
      name: 'King Abdulaziz International Airport',
      city: 'Jeddah',
      country: 'Saudi Arabia'),
  'RUH': AirportDetails(
      name: 'King Khalid International Airport',
      city: 'Riyadh',
      country: 'Saudi Arabia'),
  'AMM': AirportDetails(
      name: 'Queen Alia International Airport',
      city: 'Amman',
      country: 'Jordan'),
  'KWI': AirportDetails(
      name: 'Kuwait International Airport',
      city: 'Kuwait City',
      country: 'Kuwait'),
  'BAH': AirportDetails(
      name: 'Bahrain International Airport',
      city: 'Manama',
      country: 'Bahrain'),
  'MCT': AirportDetails(
      name: 'Muscat International Airport', city: 'Muscat', country: 'Oman'),
  'TLV': AirportDetails(
      name: 'Ben Gurion Airport', city: 'Tel Aviv', country: 'Israel'),
  'BEY': AirportDetails(
      name: 'Beirut-Rafic Hariri International Airport',
      city: 'Beirut',
      country: 'Lebanon'),
  'IKA': AirportDetails(
      name: 'Imam Khomeini International Airport',
      city: 'Tehran',
      country: 'Iran'),
  'ISB': AirportDetails(
      name: 'Islamabad International Airport',
      city: 'Islamabad',
      country: 'Pakistan'),
  'IST': AirportDetails(
      name: 'Istanbul Airport', city: 'Istanbul', country: 'Turkey'),
  'SAW': AirportDetails(
      name: 'Sabiha Gökçen International Airport',
      city: 'Istanbul',
      country: 'Turkey'),
  'ESB': AirportDetails(
      name: 'Ankara Esenboğa Airport', city: 'Ankara', country: 'Turkey'),
  'ADB': AirportDetails(
      name: 'Adnan Menderes Airport', city: 'İzmir', country: 'Turkey'),
  'AUH': AirportDetails(
      name: 'Abu Dhabi International Airport',
      city: 'Abu Dhabi',
      country: 'United Arab Emirates'),
  'SHJ': AirportDetails(
      name: 'Sharjah International Airport',
      city: 'Sharjah',
      country: 'United Arab Emirates'),
  'MED': AirportDetails(
      name: 'Prince Mohammad bin Abdulaziz International Airport',
      city: 'Medina',
      country: 'Saudi Arabia'),
  'AHB': AirportDetails(
      name: 'Abha International Airport',
      city: 'Abha',
      country: 'Saudi Arabia'),
  'ELQ': AirportDetails(
      name: 'Prince Naif bin Abdulaziz International Airport',
      city: 'Qassim',
      country: 'Saudi Arabia'),
  'JZN': AirportDetails(
      name: 'Jazan Airport', city: 'Jazan', country: 'Saudi Arabia'),
  'KFJ': AirportDetails(
      name: 'King Fahd International Airport',
      city: 'Dammam',
      country: 'Saudi Arabia'),
  'DAM': AirportDetails(
      name: 'Damascus International Airport',
      city: 'Damascus',
      country: 'Syria'),
  'BAG': AirportDetails(
      name: 'Baghdad International Airport', city: 'Baghdad', country: 'Iraq'),
  'HRG': AirportDetails(
      name: 'Hurghada International Airport',
      city: 'Hurghada',
      country: 'Egypt'),
  'SSH': AirportDetails(
      name: 'Sharm El Sheikh International Airport',
      city: 'Sharm El Sheikh',
      country: 'Egypt'),
  'ALG': AirportDetails(
      name: 'Houari Boumédiène Airport', city: 'Algiers', country: 'Algeria'),
  'ORN': AirportDetails(
      name: 'Oran Es Sénia Airport', city: 'Oran', country: 'Algeria'),
  'CMN': AirportDetails(
      name: 'Mohammed V International Airport',
      city: 'Casablanca',
      country: 'Morocco'),
  'RAK': AirportDetails(
      name: 'Marrakech Menara Airport', city: 'Marrakech', country: 'Morocco'),
  'FEZ':
      AirportDetails(name: 'Fès–Saïs Airport', city: 'Fes', country: 'Morocco'),
  'TUN': AirportDetails(
      name: 'Tunis–Carthage International Airport',
      city: 'Tunis',
      country: 'Tunisia'),
  'DJE': AirportDetails(
      name: 'Djerba–Zarzis International Airport',
      city: 'Djerba',
      country: 'Tunisia'),
  'NBE': AirportDetails(
      name: 'Enfidha–Hammamet International Airport',
      city: 'Enfidha',
      country: 'Tunisia'),
  'KRT': AirportDetails(
      name: 'Khartoum International Airport',
      city: 'Khartoum',
      country: 'Sudan'),

  // --- Global Famous Airports ---
  'JFK': AirportDetails(
      name: 'John F. Kennedy International Airport',
      city: 'New York',
      country: 'United States'),
  'LAX': AirportDetails(
      name: 'Los Angeles International Airport',
      city: 'Los Angeles',
      country: 'United States'),
  'LHR': AirportDetails(
      name: 'London Heathrow Airport',
      city: 'London',
      country: 'United Kingdom'),
  'CDG': AirportDetails(
      name: 'Paris Charles de Gaulle Airport',
      city: 'Paris',
      country: 'France'),
  'AMS': AirportDetails(
      name: 'Amsterdam Airport Schiphol',
      city: 'Amsterdam',
      country: 'Netherlands'),
  'FRA': AirportDetails(
      name: 'Frankfurt Airport', city: 'Frankfurt', country: 'Germany'),
  'SIN': AirportDetails(
      name: 'Singapore Changi Airport',
      city: 'Singapore',
      country: 'Singapore'),
  'NRT': AirportDetails(
      name: 'Narita International Airport', city: 'Tokyo', country: 'Japan'),
  'HND': AirportDetails(
      name: 'Tokyo Haneda Airport', city: 'Tokyo', country: 'Japan'),
  'ICN': AirportDetails(
      name: 'Incheon International Airport',
      city: 'Seoul',
      country: 'South Korea'),
  'BKK': AirportDetails(
      name: 'Suvarnabhumi Airport', city: 'Bangkok', country: 'Thailand'),
  'SYD': AirportDetails(
      name: 'Sydney Kingsford Smith Airport',
      city: 'Sydney',
      country: 'Australia'),
  'YYZ': AirportDetails(
      name: 'Toronto Pearson International Airport',
      city: 'Toronto',
      country: 'Canada'),
  'ORD': AirportDetails(
      name: 'Chicago O\'Hare International Airport',
      city: 'Chicago',
      country: 'United States'),
  'ATL': AirportDetails(
      name: 'Hartsfield-Jackson Atlanta International Airport',
      city: 'Atlanta',
      country: 'United States'),
  'DEN': AirportDetails(
      name: 'Denver International Airport',
      city: 'Denver',
      country: 'United States'),
  'MIA': AirportDetails(
      name: 'Miami International Airport',
      city: 'Miami',
      country: 'United States'),
  'EWR': AirportDetails(
      name: 'Newark Liberty International Airport',
      city: 'Newark',
      country: 'United States'),
  'SFO': AirportDetails(
      name: 'San Francisco International Airport',
      city: 'San Francisco',
      country: 'United States'),
  'SEA': AirportDetails(
      name: 'Seattle-Tacoma International Airport',
      city: 'Seattle',
      country: 'United States'),
  'MCO': AirportDetails(
      name: 'Orlando International Airport',
      city: 'Orlando',
      country: 'United States'),
  'LAS': AirportDetails(
      name: 'Harry Reid International Airport',
      city: 'Las Vegas',
      country: 'United States'),
  'CLT': AirportDetails(
      name: 'Charlotte Douglas International Airport',
      city: 'Charlotte',
      country: 'United States'),
  'PHX': AirportDetails(
      name: 'Phoenix Sky Harbor International Airport',
      city: 'Phoenix',
      country: 'United States'),
  'DFW': AirportDetails(
      name: 'Dallas/Fort Worth International Airport',
      city: 'Dallas/Fort Worth',
      country: 'United States'),
  'BCN': AirportDetails(
      name: 'Josep Tarradellas Barcelona–El Prat Airport',
      city: 'Barcelona',
      country: 'Spain'),
  'MUC': AirportDetails(
      name: 'Munich Airport', city: 'Munich', country: 'Germany'),
  'FCO': AirportDetails(
      name: 'Leonardo da Vinci–Fiumicino Airport',
      city: 'Rome',
      country: 'Italy'),
  'MAD': AirportDetails(
      name: 'Adolfo Suárez Madrid–Barajas Airport',
      city: 'Madrid',
      country: 'Spain'),
  'CPH': AirportDetails(
      name: 'Copenhagen Airport', city: 'Copenhagen', country: 'Denmark'),
  'OSL': AirportDetails(
      name: 'Oslo Airport, Gardermoen', city: 'Oslo', country: 'Norway'),
  'ARN': AirportDetails(
      name: 'Stockholm Arlanda Airport', city: 'Stockholm', country: 'Sweden'),
  'HEL': AirportDetails(
      name: 'Helsinki Airport', city: 'Helsinki', country: 'Finland'),
  'DUB': AirportDetails(
      name: 'Dublin Airport', city: 'Dublin', country: 'Ireland'),
  'ZRH': AirportDetails(
      name: 'Zurich Airport', city: 'Zurich', country: 'Switzerland'),
  'VIE': AirportDetails(
      name: 'Vienna International Airport', city: 'Vienna', country: 'Austria'),
  'BRU': AirportDetails(
      name: 'Brussels Airport', city: 'Brussels', country: 'Belgium'),
  'LIS': AirportDetails(
      name: 'Lisbon Airport', city: 'Lisbon', country: 'Portugal'),
  'PRG': AirportDetails(
      name: 'Václav Havel Airport Prague',
      city: 'Prague',
      country: 'Czech Republic'),
  'WAW': AirportDetails(
      name: 'Warsaw Chopin Airport', city: 'Warsaw', country: 'Poland'),
  'BUD': AirportDetails(
      name: 'Budapest Ferenc Liszt International Airport',
      city: 'Budapest',
      country: 'Hungary'),
  'ATH': AirportDetails(
      name: 'Athens International Airport', city: 'Athens', country: 'Greece'),
  'CPT': AirportDetails(
      name: 'Cape Town International Airport',
      city: 'Cape Town',
      country: 'South Africa'),
  'JNB': AirportDetails(
      name: 'O. R. Tambo International Airport',
      city: 'Johannesburg',
      country: 'South Africa'),
  'NBO': AirportDetails(
      name: 'Jomo Kenyatta International Airport',
      city: 'Nairobi',
      country: 'Kenya'),
  'ADD': AirportDetails(
      name: 'Addis Ababa Bole International Airport',
      city: 'Addis Ababa',
      country: 'Ethiopia'),
  'LOS': AirportDetails(
      name: 'Murtala Muhammed International Airport',
      city: 'Lagos',
      country: 'Nigeria'),
  'ACC': AirportDetails(
      name: 'Kotoka International Airport', city: 'Accra', country: 'Ghana'),
  'DAR': AirportDetails(
      name: 'Julius Nyerere International Airport',
      city: 'Dar es Salaam',
      country: 'Tanzania'),
  'KUL': AirportDetails(
      name: 'Kuala Lumpur International Airport',
      city: 'Kuala Lumpur',
      country: 'Malaysia'),
  'MNL': AirportDetails(
      name: 'Ninoy Aquino International Airport',
      city: 'Manila',
      country: 'Philippines'),
  'CGK': AirportDetails(
      name: 'Soekarno-Hatta International Airport',
      city: 'Jakarta',
      country: 'Indonesia'),
  'SGN': AirportDetails(
      name: 'Tan Son Nhat International Airport',
      city: 'Ho Chi Minh City',
      country: 'Vietnam'),
  'HAN': AirportDetails(
      name: 'Noi Bai International Airport', city: 'Hanoi', country: 'Vietnam'),
  'DEL': AirportDetails(
      name: 'Indira Gandhi International Airport',
      city: 'Delhi',
      country: 'India'),
  'BOM': AirportDetails(
      name: 'Chhatrapati Shivaji Maharaj International Airport',
      city: 'Mumbai',
      country: 'India'),
  'BLR': AirportDetails(
      name: 'Kempegowda International Airport',
      city: 'Bengaluru',
      country: 'India'),
  'MAA': AirportDetails(
      name: 'Chennai International Airport', city: 'Chennai', country: 'India'),
  'CCU': AirportDetails(
      name: 'Netaji Subhas Chandra Bose International Airport',
      city: 'Kolkata',
      country: 'India'),
  'KIX': AirportDetails(
      name: 'Kansai International Airport', city: 'Osaka', country: 'Japan'),
  'PVG': AirportDetails(
      name: 'Shanghai Pudong International Airport',
      city: 'Shanghai',
      country: 'China'),
  'CAN': AirportDetails(
      name: 'Guangzhou Baiyun International Airport',
      city: 'Guangzhou',
      country: 'China'),
  'CTU': AirportDetails(
      name: 'Chengdu Shuangliu International Airport',
      city: 'Chengdu',
      country: 'China'),
  'SZX': AirportDetails(
      name: 'Shenzhen Bao\'an International Airport',
      city: 'Shenzhen',
      country: 'China'),
  'TPE': AirportDetails(
      name: 'Taiwan Taoyuan International Airport',
      city: 'Taipei',
      country: 'Taiwan'),
  'AKL': AirportDetails(
      name: 'Auckland Airport', city: 'Auckland', country: 'New Zealand'),
  'MEL': AirportDetails(
      name: 'Melbourne Airport', city: 'Melbourne', country: 'Australia'),
  'BNE': AirportDetails(
      name: 'Brisbane Airport', city: 'Brisbane', country: 'Australia'),
  'PER': AirportDetails(
      name: 'Perth Airport', city: 'Perth', country: 'Australia'),
  'ADL': AirportDetails(
      name: 'Adelaide Airport', city: 'Adelaide', country: 'Australia'),
  'YVR': AirportDetails(
      name: 'Vancouver International Airport',
      city: 'Vancouver',
      country: 'Canada'),
  'YUL': AirportDetails(
      name: 'Montréal–Pierre Elliott Trudeau International Airport',
      city: 'Montreal',
      country: 'Canada'),
  'YYC': AirportDetails(
      name: 'Calgary International Airport',
      city: 'Calgary',
      country: 'Canada'),
  'MEX': AirportDetails(
      name: 'Mexico City International Airport',
      city: 'Mexico City',
      country: 'Mexico'),
  'CUN': AirportDetails(
      name: 'Cancún International Airport', city: 'Cancún', country: 'Mexico'),
  'GRU': AirportDetails(
      name:
          'São Paulo/Guarulhos–Governador André Franco Montoro International Airport',
      city: 'São Paulo',
      country: 'Brazil'),
  'GIG': AirportDetails(
      name: 'Rio de Janeiro/Galeão–Antonio Carlos Jobim International Airport',
      city: 'Rio de Janeiro',
      country: 'Brazil'),
  'BOG': AirportDetails(
      name: 'El Dorado International Airport',
      city: 'Bogotá',
      country: 'Colombia'),
  'LIM': AirportDetails(
      name: 'Jorge Chávez International Airport',
      city: 'Lima',
      country: 'Peru'),
  'SCL': AirportDetails(
      name: 'Arturo Merino Benítez International Airport',
      city: 'Santiago',
      country: 'Chile'),
  'EZE': AirportDetails(
      name: 'Ministro Pistarini International Airport',
      city: 'Buenos Aires',
      country: 'Argentina'),
  'SJO': AirportDetails(
      name: 'Juan Santamaría International Airport',
      city: 'San José',
      country: 'Costa Rica'),
  'PTY': AirportDetails(
      name: 'Tocumen International Airport',
      city: 'Panama City',
      country: 'Panama'),
  'HAV': AirportDetails(
      name: 'José Martí International Airport',
      city: 'Havana',
      country: 'Cuba'),
  'SJU': AirportDetails(
      name: 'Luis Muñoz Marín International Airport',
      city: 'San Juan',
      country: 'Puerto Rico'),
  'MBJ': AirportDetails(
      name: 'Sangster International Airport',
      city: 'Montego Bay',
      country: 'Jamaica'),
  'NAS': AirportDetails(
      name: 'Lynden Pindling International Airport',
      city: 'Nassau',
      country: 'Bahamas'),
  'PUJ': AirportDetails(
      name: 'Punta Cana International Airport',
      city: 'Punta Cana',
      country: 'Dominican Republic'),
  'LGW': AirportDetails(
      name: 'London Gatwick Airport',
      city: 'London',
      country: 'United Kingdom'),
  'MAN': AirportDetails(
      name: 'Manchester Airport',
      city: 'Manchester',
      country: 'United Kingdom'),
  'DUS': AirportDetails(
      name: 'Düsseldorf Airport', city: 'Düsseldorf', country: 'Germany'),
  'BER': AirportDetails(
      name: 'Berlin Brandenburg Airport', city: 'Berlin', country: 'Germany'),
  'PMI': AirportDetails(
      name: 'Palma de Mallorca Airport',
      city: 'Palma de Mallorca',
      country: 'Spain'),
  'SOF':
      AirportDetails(name: 'Sofia Airport', city: 'Sofia', country: 'Bulgaria'),
  'OTP': AirportDetails(
      name: 'Henri Coandă International Airport',
      city: 'Bucharest',
      country: 'Romania'),
  'KBP': AirportDetails(
      name: 'Boryspil International Airport', city: 'Kyiv', country: 'Ukraine'),
  'LED': AirportDetails(
      name: 'Pulkovo Airport', city: 'Saint Petersburg', country: 'Russia'),
  'VKO': AirportDetails(
      name: 'Vnukovo International Airport', city: 'Moscow', country: 'Russia'),
  'DME': AirportDetails(
      name: 'Domodedovo International Airport',
      city: 'Moscow',
      country: 'Russia'),
  'SVO': AirportDetails(
      name: 'Sheremetyevo International Airport',
      city: 'Moscow',
      country: 'Russia'),
  'HNL': AirportDetails(
      name: 'Daniel K. Inouye International Airport',
      city: 'Honolulu',
      country: 'United States'),
  'OGG': AirportDetails(
      name: 'Kahului Airport', city: 'Kahului', country: 'United States'),
  'ANC': AirportDetails(
      name: 'Ted Stevens Anchorage International Airport',
      city: 'Anchorage',
      country: 'United States'),
  'PDX': AirportDetails(
      name: 'Portland International Airport',
      city: 'Portland',
      country: 'United States'),
  'SAN': AirportDetails(
      name: 'San Diego International Airport',
      city: 'San Diego',
      country: 'United States'),
  'STL': AirportDetails(
      name: 'St. Louis Lambert International Airport',
      city: 'St. Louis',
      country: 'United States'),
  'MSP': AirportDetails(
      name: 'Minneapolis–Saint Paul International Airport',
      city: 'Minneapolis',
      country: 'United States'),
  'DTW': AirportDetails(
      name: 'Detroit Metropolitan Wayne County Airport',
      city: 'Detroit',
      country: 'United States'),
  'MCI': AirportDetails(
      name: 'Kansas City International Airport',
      city: 'Kansas City',
      country: 'United States'),
  'CLE': AirportDetails(
      name: 'Cleveland Hopkins International Airport',
      city: 'Cleveland',
      country: 'United States'),
  'IND': AirportDetails(
      name: 'Indianapolis International Airport',
      city: 'Indianapolis',
      country: 'United States'),
  'CMH': AirportDetails(
      name: 'John Glenn Columbus International Airport',
      city: 'Columbus',
      country: 'United States'),
  'PIT': AirportDetails(
      name: 'Pittsburgh International Airport',
      city: 'Pittsburgh',
      country: 'United States'),
  'RDU': AirportDetails(
      name: 'Raleigh–Durham International Airport',
      city: 'Raleigh/Durham',
      country: 'United States'),
  'BNA': AirportDetails(
      name: 'Nashville International Airport',
      city: 'Nashville',
      country: 'United States'),
  'MEM': AirportDetails(
      name: 'Memphis International Airport',
      city: 'Memphis',
      country: 'United States'),
  'BHM': AirportDetails(
      name: 'Birmingham-Shuttlesworth International Airport',
      city: 'Birmingham',
      country: 'United States'),
  'MSY': AirportDetails(
      name: 'Louis Armstrong New Orleans International Airport',
      city: 'New Orleans',
      country: 'United States'),
  'HOU': AirportDetails(
      name: 'William P. Hobby Airport',
      city: 'Houston',
      country: 'United States'),
  'AUS': AirportDetails(
      name: 'Austin-Bergstrom International Airport',
      city: 'Austin',
      country: 'United States'),
  'SAT': AirportDetails(
      name: 'San Antonio International Airport',
      city: 'San Antonio',
      country: 'United States'),
  'OKC': AirportDetails(
      name: 'Will Rogers World Airport',
      city: 'Oklahoma City',
      country: 'United States'),
  'TUL': AirportDetails(
      name: 'Tulsa International Airport',
      city: 'Tulsa',
      country: 'United States'),
  'ICT': AirportDetails(
      name: 'Wichita Dwight D. Eisenhower National Airport',
      city: 'Wichita',
      country: 'United States'),
  'OMA': AirportDetails(
      name: 'Eppley Airfield', city: 'Omaha', country: 'United States'),
  'DSM': AirportDetails(
      name: 'Des Moines International Airport',
      city: 'Des Moines',
      country: 'United States'),
  'MKE': AirportDetails(
      name: 'Milwaukee Mitchell International Airport',
      city: 'Milwaukee',
      country: 'United States'),
  'GRR': AirportDetails(
      name: 'Gerald R. Ford International Airport',
      city: 'Grand Rapids',
      country: 'United States'),
  'CVG': AirportDetails(
      name: 'Cincinnati/Northern Kentucky International Airport',
      city: 'Cincinnati',
      country: 'United States'),
  'BUF': AirportDetails(
      name: 'Buffalo Niagara International Airport',
      city: 'Buffalo',
      country: 'United States'),
  'ROC': AirportDetails(
      name: 'Greater Rochester International Airport',
      city: 'Rochester',
      country: 'United States'),
  'SYR': AirportDetails(
      name: 'Syracuse Hancock International Airport',
      city: 'Syracuse',
      country: 'United States'),
  'BOS': AirportDetails(
      name: 'Logan International Airport',
      city: 'Boston',
      country: 'United States'),
  'PVD': AirportDetails(
      name: 'T. F. Green Airport',
      city: 'Providence',
      country: 'United States'),
  'PHL': AirportDetails(
      name: 'Philadelphia International Airport',
      city: 'Philadelphia',
      country: 'United States'),
  'BWI': AirportDetails(
      name: 'Baltimore/Washington International Thurgood Marshall Airport',
      city: 'Baltimore',
      country: 'United States'),
  'IAD': AirportDetails(
      name: 'Dulles International Airport',
      city: 'Washington D.C.',
      country: 'United States'),
  'DCA': AirportDetails(
      name: 'Ronald Reagan Washington National Airport',
      city: 'Washington D.C.',
      country: 'United States'),
  'RIC': AirportDetails(
      name: 'Richmond International Airport',
      city: 'Richmond',
      country: 'United States'),
  'ORF': AirportDetails(
      name: 'Norfolk International Airport',
      city: 'Norfolk',
      country: 'United States'),
  'GSO': AirportDetails(
      name: 'Piedmont Triad International Airport',
      city: 'Greensboro',
      country: 'United States'),
  'CHS': AirportDetails(
      name: 'Charleston International Airport',
      city: 'Charleston',
      country: 'United States'),
  'SAV': AirportDetails(
      name: 'Savannah/Hilton Head International Airport',
      city: 'Savannah',
      country: 'United States'),
  'JAX': AirportDetails(
      name: 'Jacksonville International Airport',
      city: 'Jacksonville',
      country: 'United States'),
  'TPA': AirportDetails(
      name: 'Tampa International Airport',
      city: 'Tampa',
      country: 'United States'),
  'FLL': AirportDetails(
      name: 'Fort Lauderdale–Hollywood International Airport',
      city: 'Fort Lauderdale',
      country: 'United States'),
  'PBI': AirportDetails(
      name: 'Palm Beach International Airport',
      city: 'West Palm Beach',
      country: 'United States'),
  'RSW': AirportDetails(
      name: 'Southwest Florida International Airport',
      city: 'Fort Myers',
      country: 'United States'),
  'SRQ': AirportDetails(
      name: 'Sarasota–Bradenton International Airport',
      city: 'Sarasota',
      country: 'United States'),
  'GSP': AirportDetails(
      name: 'Greenville–Spartanburg International Airport',
      city: 'Greenville',
      country: 'United States'),
  'TRI': AirportDetails(
      name: 'Tri-Cities Airport',
      city: 'Blountville',
      country: 'United States'),
  'CAE': AirportDetails(
      name: 'Columbia Metropolitan Airport',
      city: 'Columbia',
      country: 'United States'),
  'BZN': AirportDetails(
      name: 'Bozeman Yellowstone International Airport',
      city: 'Bozeman',
      country: 'United States'),
  'FCA': AirportDetails(
      name: 'Glacier Park International Airport',
      city: 'Kalispell',
      country: 'United States'),
  'SLC': AirportDetails(
      name: 'Salt Lake City International Airport',
      city: 'Salt Lake City',
      country: 'United States'),
  'BOI': AirportDetails(
      name: 'Boise Airport', city: 'Boise', country: 'United States'),
  'GEG': AirportDetails(
      name: 'Spokane International Airport',
      city: 'Spokane',
      country: 'United States'),
  'PSC': AirportDetails(
      name: 'Tri-Cities Airport (Washington)',
      city: 'Pasco',
      country: 'United States'),
  'EUG': AirportDetails(
      name: 'Eugene Airport', city: 'Eugene', country: 'United States'),
  'SMF': AirportDetails(
      name: 'Sacramento International Airport',
      city: 'Sacramento',
      country: 'United States'),
  'SJC': AirportDetails(
      name: 'San Jose International Airport',
      city: 'San Jose',
      country: 'United States'),
  'OAK': AirportDetails(
      name: 'Oakland International Airport',
      city: 'Oakland',
      country: 'United States'),
  'BUR': AirportDetails(
      name: 'Hollywood Burbank Airport',
      city: 'Burbank',
      country: 'United States'),
  'SNA': AirportDetails(
      name: 'John Wayne Airport', city: 'Santa Ana', country: 'United States'),
  'ONT': AirportDetails(
      name: 'Ontario International Airport',
      city: 'Ontario',
      country: 'United States'),
  'ABQ': AirportDetails(
      name: 'Albuquerque International Sunport',
      city: 'Albuquerque',
      country: 'United States'),
  'ELP': AirportDetails(
      name: 'El Paso International Airport',
      city: 'El Paso',
      country: 'United States'),
  'TUS': AirportDetails(
      name: 'Tucson International Airport',
      city: 'Tucson',
      country: 'United States'),
  'MDW': AirportDetails(
      name: 'Chicago Midway International Airport',
      city: 'Chicago',
      country: 'United States'),
  'BTV': AirportDetails(
      name: 'Burlington International Airport',
      city: 'Burlington',
      country: 'United States'),
  'PWM': AirportDetails(
      name: 'Portland International Jetport',
      city: 'Portland',
      country: 'United States'),
  'MHT': AirportDetails(
      name: 'Manchester-Boston Regional Airport',
      city: 'Manchester',
      country: 'United States'),
  'ALB': AirportDetails(
      name: 'Albany International Airport',
      city: 'Albany',
      country: 'United States'),
  'BDL': AirportDetails(
      name: 'Bradley International Airport',
      city: 'Windsor Locks',
      country: 'United States'),
  'SDF': AirportDetails(
      name: 'Louisville Muhammad Ali International Airport',
      city: 'Louisville',
      country: 'United States'),
  'TYS': AirportDetails(
      name: 'McGhee Tyson Airport',
      city: 'Knoxville',
      country: 'United States'),
  'CHA': AirportDetails(
      name: 'Chattanooga Metropolitan Airport',
      city: 'Chattanooga',
      country: 'United States'),
  'AVL': AirportDetails(
      name: 'Asheville Regional Airport',
      city: 'Asheville',
      country: 'United States'),
  'EDI': AirportDetails(
      name: 'Edinburgh Airport', city: 'Edinburgh', country: 'United Kingdom'),
  'GLA': AirportDetails(
      name: 'Glasgow Airport', city: 'Glasgow', country: 'United Kingdom'),
  'BHX': AirportDetails(
      name: 'Birmingham Airport',
      city: 'Birmingham',
      country: 'United Kingdom'),
  'MRS': AirportDetails(
      name: 'Marseille Provence Airport', city: 'Marseille', country: 'France'),
  'NCE': AirportDetails(
      name: 'Nice Côte d\'Azur Airport', city: 'Nice', country: 'France'),
  'LYS': AirportDetails(
      name: 'Lyon–Saint-Exupéry Airport', city: 'Lyon', country: 'France'),
  'GVA': AirportDetails(
      name: 'Geneva Airport', city: 'Geneva', country: 'Switzerland'),
  'BSL': AirportDetails(
      name: 'EuroAirport Basel Mulhouse Freiburg',
      city: 'Basel/Mulhouse',
      country: 'Switzerland/France/Germany'),
  'BRN': AirportDetails(
      name: 'Bern Airport', city: 'Bern', country: 'Switzerland'),
  'INN': AirportDetails(
      name: 'Innsbruck Airport', city: 'Innsbruck', country: 'Austria'),
  'GRZ': AirportDetails(name: 'Graz Airport', city: 'Graz', country: 'Austria'),
  'SZG': AirportDetails(
      name: 'Salzburg Airport', city: 'Salzburg', country: 'Austria'),
  'HAJ': AirportDetails(
      name: 'Hannover Airport', city: 'Hannover', country: 'Germany'),
  'CGN': AirportDetails(
      name: 'Cologne Bonn Airport', city: 'Cologne/Bonn', country: 'Germany'),
  'LEJ': AirportDetails(
      name: 'Leipzig/Halle Airport', city: 'Leipzig/Halle', country: 'Germany'),
  'STR': AirportDetails(
      name: 'Stuttgart Airport', city: 'Stuttgart', country: 'Germany'),
  'NUE': AirportDetails(
      name: 'Nuremberg Airport', city: 'Nuremberg', country: 'Germany'),
  'HAM': AirportDetails(
      name: 'Hamburg Airport', city: 'Hamburg', country: 'Germany'),
  'BRE': AirportDetails(
      name: 'Bremen Airport', city: 'Bremen', country: 'Germany'),
  'DRS': AirportDetails(
      name: 'Dresden Airport', city: 'Dresden', country: 'Germany'),
  'FLR': AirportDetails(
      name: 'Florence Airport, Peretola', city: 'Florence', country: 'Italy'),
  'VCE': AirportDetails(
      name: 'Venice Marco Polo Airport', city: 'Venice', country: 'Italy'),
  'MXP': AirportDetails(
      name: 'Milan Malpensa Airport', city: 'Milan', country: 'Italy'),
  'LIN': AirportDetails(
      name: 'Milan Linate Airport', city: 'Milan', country: 'Italy'),
  'NAP': AirportDetails(
      name: 'Naples International Airport', city: 'Naples', country: 'Italy'),
  'BLQ': AirportDetails(
      name: 'Bologna Guglielmo Marconi Airport',
      city: 'Bologna',
      country: 'Italy'),
  'PSA': AirportDetails(
      name: 'Pisa International Airport', city: 'Pisa', country: 'Italy'),
  'CTA': AirportDetails(
      name: 'Catania–Fontanarossa Airport', city: 'Catania', country: 'Italy'),
  'PMO': AirportDetails(
      name: 'Falcone Borsellino Airport', city: 'Palermo', country: 'Italy'),
  'ZNZ': AirportDetails(
      name: 'Abeid Amani Karume International Airport',
      city: 'Zanzibar City',
      country: 'Tanzania'),
  'KGL': AirportDetails(
      name: 'Kigali International Airport', city: 'Kigali', country: 'Rwanda'),
  'EBB': AirportDetails(
      name: 'Entebbe International Airport',
      city: 'Entebbe',
      country: 'Uganda'),
  'LLW': AirportDetails(
      name: 'Lilongwe International Airport',
      city: 'Lilongwe',
      country: 'Malawi'),
  'LUN': AirportDetails(
      name: 'Kenneth Kaunda International Airport',
      city: 'Lusaka',
      country: 'Zambia'),
  'HRE': AirportDetails(
      name: 'Robert Gabriel Mugabe International Airport',
      city: 'Harare',
      country: 'Zimbabwe'),
  'MRU': AirportDetails(
      name: 'Sir Seewoosagur Ramgoolam International Airport',
      city: 'Port Louis',
      country: 'Mauritius'),
  'SEZ': AirportDetails(
      name: 'Seychelles International Airport',
      city: 'Mahé',
      country: 'Seychelles'),
  'FIH': AirportDetails(
      name: 'N\'djili Airport', city: 'Kinshasa', country: 'DR Congo'),
  'CKY': AirportDetails(
      name: 'Conakry International Airport',
      city: 'Conakry',
      country: 'Guinea'),
  'BXO': AirportDetails(
      name: 'Osvaldo Vieira International Airport',
      city: 'Bissau',
      country: 'Guinea-Bissau'),
  'SID': AirportDetails(
      name: 'Amílcar Cabral International Airport',
      city: 'Sal',
      country: 'Cape Verde'),
  'RAI': AirportDetails(
      name: 'Nelson Mandela International Airport',
      city: 'Praia',
      country: 'Cape Verde'),
  'RUN': AirportDetails(
      name: 'Roland Garros Airport', city: 'Saint-Denis', country: 'Réunion'),
  'DZA': AirportDetails(
      name: 'Dzaoudzi–Pamandzi International Airport',
      city: 'Dzaoudzi',
      country: 'Mayotte'),
  'TNR': AirportDetails(
      name: 'Ivato International Airport',
      city: 'Antananarivo',
      country: 'Madagascar'),
  'EAS': AirportDetails(
      name: 'San Sebastián Airport', city: 'San Sebastián', country: 'Spain'),
  'BIO':
      AirportDetails(name: 'Bilbao Airport', city: 'Bilbao', country: 'Spain'),
  'AGP':
      AirportDetails(name: 'Málaga Airport', city: 'Málaga', country: 'Spain'),
  'FAO':
      AirportDetails(name: 'Faro Airport', city: 'Faro', country: 'Portugal'),
  'OPO':
      AirportDetails(name: 'Porto Airport', city: 'Porto', country: 'Portugal'),
  'FNC': AirportDetails(
      name: 'Madeira Airport', city: 'Funchal', country: 'Portugal'),
  'PIR': AirportDetails(
      name: 'Priština International Airport Adem Jashari',
      city: 'Pristina',
      country: 'Kosovo'),
  'SJJ': AirportDetails(
      name: 'Sarajevo International Airport',
      city: 'Sarajevo',
      country: 'Bosnia and Herzegovina'),
  'SKP': AirportDetails(
      name: 'Skopje International Airport',
      city: 'Skopje',
      country: 'North Macedonia'),
  'TGD': AirportDetails(
      name: 'Podgorica Airport', city: 'Podgorica', country: 'Montenegro'),
  'TIV': AirportDetails(
      name: 'Tivat Airport', city: 'Tivat', country: 'Montenegro'),
  'DBV': AirportDetails(
      name: 'Dubrovnik Airport', city: 'Dubrovnik', country: 'Croatia'),
  'SPU':
      AirportDetails(name: 'Split Airport', city: 'Split', country: 'Croatia'),
  'ZAD':
      AirportDetails(name: 'Zadar Airport', city: 'Zadar', country: 'Croatia'),
  'PUY': AirportDetails(name: 'Pula Airport', city: 'Pula', country: 'Croatia'),
  'LJU': AirportDetails(
      name: 'Ljubljana Jože Pučnik Airport',
      city: 'Ljubljana',
      country: 'Slovenia'),
  'BTS': AirportDetails(
      name: 'Bratislava Airport', city: 'Bratislava', country: 'Slovakia'),
  'KTW': AirportDetails(
      name: 'Katowice Airport', city: 'Katowice', country: 'Poland'),
  'POZ': AirportDetails(
      name: 'Poznań–Ławica Henryk Wieniawski Airport',
      city: 'Poznań',
      country: 'Poland'),
  'GDN': AirportDetails(
      name: 'Gdańsk Lech Wałęsa Airport', city: 'Gdańsk', country: 'Poland'),
  'VNO': AirportDetails(
      name: 'Vilnius Airport', city: 'Vilnius', country: 'Lithuania'),
  'RIX': AirportDetails(
      name: 'Riga International Airport', city: 'Riga', country: 'Latvia'),
  'TLL': AirportDetails(
      name: 'Tallinn Airport', city: 'Tallinn', country: 'Estonia'),
  'KIV': AirportDetails(
      name: 'Chișinău International Airport',
      city: 'Chișinău',
      country: 'Moldova'),
  'VAR':
      AirportDetails(name: 'Varna Airport', city: 'Varna', country: 'Bulgaria'),
  'CLJ': AirportDetails(
      name: 'Cluj International Airport',
      city: 'Cluj-Napoca',
      country: 'Romania'),
  'IAS': AirportDetails(
      name: 'Iași International Airport', city: 'Iași', country: 'Romania'),
  'KGD': AirportDetails(
      name: 'Khrabrovo Airport', city: 'Kaliningrad', country: 'Russia'),
  'KZN': AirportDetails(
      name: 'Kazan International Airport', city: 'Kazan', country: 'Russia'),
  'OVB': AirportDetails(
      name: 'Tolmachevo Airport', city: 'Novosibirsk', country: 'Russia'),
  'CEK': AirportDetails(
      name: 'Chelyabinsk Airport', city: 'Chelyabinsk', country: 'Russia'),
  'UFA': AirportDetails(
      name: 'Ufa International Airport', city: 'Ufa', country: 'Russia'),
  'KRR': AirportDetails(
      name: 'Krasnodar International Airport',
      city: 'Krasnodar',
      country: 'Russia'),
  'ROV': AirportDetails(
      name: 'Platov International Airport',
      city: 'Rostov-on-Don',
      country: 'Russia'),
  'AER': AirportDetails(
      name: 'Sochi International Airport', city: 'Sochi', country: 'Russia'),
  'SVX': AirportDetails(
      name: 'Koltsovo International Airport',
      city: 'Yekaterinburg',
      country: 'Russia'),
  'OMS': AirportDetails(
      name: 'Omsk Tsentralny Airport', city: 'Omsk', country: 'Russia'),
  'IRK': AirportDetails(
      name: 'Irkutsk International Airport',
      city: 'Irkutsk',
      country: 'Russia'),
  'KHV': AirportDetails(
      name: 'Khabarovsk Novy Airport', city: 'Khabarovsk', country: 'Russia'),
  'VVO': AirportDetails(
      name: 'Vladivostok International Airport',
      city: 'Vladivostok',
      country: 'Russia'),
  'YKS': AirportDetails(
      name: 'Yakutsk Airport', city: 'Yakutsk', country: 'Russia'),
  'KRK': AirportDetails(
      name: 'John Paul II International Airport Kraków-Balice',
      city: 'Kraków',
      country: 'Poland'),
  'WRO': AirportDetails(
      name: 'Copernicus Airport Wrocław', city: 'Wrocław', country: 'Poland'),
  'LUZ':
      AirportDetails(name: 'Lublin Airport', city: 'Lublin', country: 'Poland'),
  'RZE': AirportDetails(
      name: 'Rzeszów–Jasionka Airport', city: 'Rzeszów', country: 'Poland'),
  'SZC': AirportDetails(
      name: 'Solidarity Szczecin–Goleniów Airport',
      city: 'Szczecin',
      country: 'Poland'),
  'DEB': AirportDetails(
      name: 'Debrecen International Airport',
      city: 'Debrecen',
      country: 'Hungary'),
  'LNZ': AirportDetails(name: 'Linz Airport', city: 'Linz', country: 'Austria'),
  'LUX': AirportDetails(
      name: 'Luxembourg Airport',
      city: 'Luxembourg City',
      country: 'Luxembourg'),
  'CRL': AirportDetails(
      name: 'Brussels South Charleroi Airport',
      city: 'Charleroi',
      country: 'Belgium'),
  'EIN': AirportDetails(
      name: 'Eindhoven Airport', city: 'Eindhoven', country: 'Netherlands'),
  'RTM': AirportDetails(
      name: 'Rotterdam The Hague Airport',
      city: 'Rotterdam',
      country: 'Netherlands'),
  'AAL': AirportDetails(
      name: 'Aalborg Airport', city: 'Aalborg', country: 'Denmark'),
  'BLL': AirportDetails(
      name: 'Billund Airport', city: 'Billund', country: 'Denmark'),
  'BGO': AirportDetails(
      name: 'Bergen Airport, Flesland', city: 'Bergen', country: 'Norway'),
  'TRD': AirportDetails(
      name: 'Trondheim Airport, Værnes', city: 'Trondheim', country: 'Norway'),
  'SVG': AirportDetails(
      name: 'Stavanger Airport, Sola', city: 'Stavanger', country: 'Norway'),
  'GOT': AirportDetails(
      name: 'Göteborg Landvetter Airport',
      city: 'Gothenburg',
      country: 'Sweden'),
  'MMX':
      AirportDetails(name: 'Malmö Airport', city: 'Malmö', country: 'Sweden'),
  'KEF': AirportDetails(
      name: 'Keflavík International Airport',
      city: 'Reykjavík',
      country: 'Iceland'),
  'LPA': AirportDetails(
      name: 'Gran Canaria Airport', city: 'Las Palmas', country: 'Spain'),
  'TFS': AirportDetails(
      name: 'Tenerife South Airport', city: 'Tenerife', country: 'Spain'),
  'ACE': AirportDetails(
      name: 'Lanzarote Airport', city: 'Arrecife', country: 'Spain'),
  'FUE': AirportDetails(
      name: 'Fuerteventura Airport', city: 'Fuerteventura', country: 'Spain'),
  'SPC': AirportDetails(
      name: 'La Palma Airport',
      city: 'Santa Cruz de La Palma',
      country: 'Spain'),
  'IBZ': AirportDetails(name: 'Ibiza Airport', city: 'Ibiza', country: 'Spain'),
  'MAH': AirportDetails(
      name: 'Menorca Airport', city: 'Menorca', country: 'Spain'),
  'SVQ': AirportDetails(
      name: 'Seville Airport', city: 'Seville', country: 'Spain'),
  'VLC': AirportDetails(
      name: 'Valencia Airport', city: 'Valencia', country: 'Spain'),
  'SNN': AirportDetails(
      name: 'Shannon Airport', city: 'Shannon', country: 'Ireland'),
  'ORK': AirportDetails(name: 'Cork Airport', city: 'Cork', country: 'Ireland'),
  'BFS': AirportDetails(
      name: 'George Best Belfast City Airport',
      city: 'Belfast',
      country: 'United Kingdom'),
  'BHD': AirportDetails(
      name: 'Belfast International Airport',
      city: 'Belfast',
      country: 'United Kingdom'),
  'GIB': AirportDetails(
      name: 'Gibraltar International Airport',
      city: 'Gibraltar',
      country: 'Gibraltar'),
  'HER': AirportDetails(
      name: 'Heraklion International Airport, "Nikos Kazantzakis"',
      city: 'Heraklion',
      country: 'Greece'),
  'RHO': AirportDetails(
      name: 'Rhodes International Airport, "Diagoras"',
      city: 'Rhodes',
      country: 'Greece'),
  'KGS': AirportDetails(
      name: 'Kos International Airport, "Hippocrates"',
      city: 'Kos',
      country: 'Greece'),
  'JTR': AirportDetails(
      name: 'Santorini (Thira) International Airport',
      city: 'Santorini',
      country: 'Greece'),
  'MYK': AirportDetails(
      name: 'Mykonos Island National Airport',
      city: 'Mykonos',
      country: 'Greece'),
  'MLE': AirportDetails(
      name: 'Velana International Airport', city: 'Malé', country: 'Maldives'),
  'CMB': AirportDetails(
      name: 'Bandaranaike International Airport',
      city: 'Colombo',
      country: 'Sri Lanka'),
  'KTM': AirportDetails(
      name: 'Tribhuvan International Airport',
      city: 'Kathmandu',
      country: 'Nepal'),
  'DAC': AirportDetails(
      name: 'Hazrat Shahjalal International Airport',
      city: 'Dhaka',
      country: 'Bangladesh'),
  'RGN': AirportDetails(
      name: 'Yangon International Airport', city: 'Yangon', country: 'Myanmar'),
  'PHN': AirportDetails(
      name: 'Phnom Penh International Airport',
      city: 'Phnom Penh',
      country: 'Cambodia'),
  'VTE': AirportDetails(
      name: 'Wattay International Airport', city: 'Vientiane', country: 'Laos'),
  'ULN': AirportDetails(
      name: 'Chinggis Khaan International Airport',
      city: 'Ulaanbaatar',
      country: 'Mongolia'),
  'TSE': AirportDetails(
      name: 'Nursultan Nazarbayev International Airport',
      city: 'Nur-Sultan',
      country: 'Kazakhstan'),
  'TAS': AirportDetails(
      name: 'Tashkent International Airport',
      city: 'Tashkent',
      country: 'Uzbekistan'),
  'FRU': AirportDetails(
      name: 'Manas International Airport',
      city: 'Bishkek',
      country: 'Kyrgyzstan'),
  'DYU': AirportDetails(
      name: 'Dushanbe International Airport',
      city: 'Dushanbe',
      country: 'Tajikistan'),
  'ASB': AirportDetails(
      name: 'Ashgabat International Airport',
      city: 'Ashgabat',
      country: 'Turkmenistan'),
  'BAK': AirportDetails(
      name: 'Heydar Aliyev International Airport',
      city: 'Baku',
      country: 'Azerbaijan'),
  'TBS': AirportDetails(
      name: 'Tbilisi International Airport',
      city: 'Tbilisi',
      country: 'Georgia'),
  'EVN': AirportDetails(
      name: 'Zvartnots International Airport',
      city: 'Yerevan',
      country: 'Armenia'),
};

/// Returns a map of airport details (name, city, country) for a given IATA code.
///
/// The [iataCode] is case-insensitive.
/// Returns null if the IATA code is not found in the `famousAirports` map.
Map<String, String> getAirportDetails(String iataCode) {
  final airportDetails = famousAirports[iataCode.toUpperCase()];
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
AirportDetails? getAirportDetailsObject(String iataCode) {
  return famousAirports[iataCode.toUpperCase()];
}
