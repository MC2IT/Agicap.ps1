namespace Mc2it.Agicap.Payments;

/// <summary>
/// The postal address of a beneficiary.
/// </summary>
public class PostalAddress {

	/// <summary>
	/// The name of the city.
	/// </summary>
	public string City { get; set; } = "";

	/// <summary>
	/// The ISO 3166 alpha-2 code of the country in which the beneficiary is located.
	/// </summary>
	public string Country { get; set; } = "";

	/// <summary>
	/// Value indicating whether this postal address is empty.
	/// </summary>
	public bool IsEmpty =>
		string.IsNullOrWhiteSpace(City) &&
		string.IsNullOrWhiteSpace(Country) &&
		string.IsNullOrWhiteSpace(Number) &&
		string.IsNullOrWhiteSpace(State) &&
		string.IsNullOrWhiteSpace(StreetName) &&
		string.IsNullOrWhiteSpace(ZipCode);

	/// <summary>
	/// The number of the building.
	/// </summary>
	public string Number { get; set; } = "";

	/// <summary>
	/// The state in which the beneficiary is located.
	/// </summary>
	public string State { get; set; } = "";

	/// <summary>
	/// The name of the street.
	/// </summary>
	public string StreetName { get; set; } = "";

	/// <summary>
	/// The ZIP code of the beneficiary location.
	/// </summary>
	public string ZipCode { get; set; } = "";

	/// <summary>
	/// Creates a new postal address from the specified JSON entity.
	/// </summary>
	/// <param name="psObject">The JSON entity.</param>
	/// <returns>The postal address corresponding to the specified JSON entity.</returns>
	public static explicit operator PostalAddress(PSObject psObject) {
		var json = (dynamic) psObject;
		return new PostalAddress() {
			City = json.city is string city ? city : "",
			Country = json.country is string country ? country : "",
			Number = json.number is string number ? number : "",
			State = json.state is string state ? state : "",
			StreetName = json.streetName is string streetName ? streetName : "",
			ZipCode = json.zipCode is string zipCode ? zipCode : ""
		};
	}
}
