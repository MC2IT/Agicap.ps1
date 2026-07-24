namespace Mc2it.Agicap.Payments;

using System.Collections;

/// <summary>
/// The postal address of a beneficiary.
/// </summary>
public class PostalAddress: IEquatable<PostalAddress> {

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
	/// Determines whether the two specified objects are equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> equals <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator ==(PostalAddress? object1, PostalAddress? object2) =>
		ReferenceEquals(object1, object2) || (object1?.Equals(object2) ?? false);

	/// <summary>
	/// Determines whether the two specified objects are not equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> does not equal <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator !=(PostalAddress? object1, PostalAddress? object2) => !(object1 == object2);

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

	/// <summary>
	/// Converts the specified postal address to a hash table.
	/// </summary>
	/// <param name="postalAddress">The postal address to convert.</param>
	/// <returns>The hash table corresponding to the specified postal address.</returns>
	public static explicit operator Hashtable(PostalAddress postalAddress) => new() {
		["city"] = string.IsNullOrWhiteSpace(postalAddress.City) ? null : postalAddress.City,
		["country"] = string.IsNullOrWhiteSpace(postalAddress.Country) ? null : postalAddress.Country,
		["number"] = string.IsNullOrWhiteSpace(postalAddress.Number) ? null : postalAddress.Number,
		["state"] = string.IsNullOrWhiteSpace(postalAddress.State) ? null : postalAddress.State,
		["streetName"] = string.IsNullOrWhiteSpace(postalAddress.StreetName) ? null : postalAddress.StreetName,
		["zipCode"] = string.IsNullOrWhiteSpace(postalAddress.ZipCode) ? null : postalAddress.ZipCode
	};

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public override bool Equals(object? other) => Equals(other as PostalAddress);

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public bool Equals(PostalAddress? other) => other is not null &&
		City == other.City &&
		Country == other.Country &&
		Number == other.Number &&
		State == other.State &&
		StreetName == other.StreetName &&
		ZipCode == other.ZipCode;

	/// <summary>
	/// Gets the hash code for this object.
	/// </summary>
	/// <returns>The hash code for this object.</returns>
	public override int GetHashCode() =>
		HashCode.Combine(City, Country, Number, State, StreetName, ZipCode);
}
