namespace Mc2it.Agicap.Payments;

/// <summary>
/// The postal address of a beneficiary.
/// </summary>
public class PostalAddress {

	/// <summary>
	/// The row identifier of the associated beneficiary.
	/// </summary>
	public int BeneficiaryId { get; set; }

	/// <summary>
	/// The name of the city.
	/// </summary>
	public string City { get; set; } = "";

	/// <summary>
	/// The ISO 3166 alpha-2 code of the country in which the beneficiary is located.
	/// </summary>
	public string Country { get; set; } = "";

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
			CurrentPageItemsCount = json.currentPageItemsCount is int currentPageItemsCount ? currentPageItemsCount : 0,
			CurrentPageNumber = json.currentPageNumber is int currentPageNumber ? currentPageNumber : 1,
			PagesCount = json.pagesCount is int pagesCount ? pagesCount : 0,
			PageSize = json.pageSize is int pageSize ? pageSize : 1_000,
			TotalItemsCount = json.totalItemsCount is int totalItemsCount ? totalItemsCount : 0
		};
	}
}
