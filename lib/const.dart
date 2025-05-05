
final semester=[
  "spring",
  "summer",
  "fall",
];
final years = List.generate(
  DateTime.now().year - 2022 + 1, // Calculate the number of years
  (index) => (2022 + index).toString(), // Generate years starting from 2022
);
