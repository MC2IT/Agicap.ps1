namespace Mc2it.Agicap.Payments;

/// <summary>
/// Represents a beneficiary.
/// </summary>
public class Beneficiary {

	/// <summary>
	/// The bank account of the beneficiary.
	/// </summary>
	[BankAccount] $BankAccount { get; set; }

	/// <summary>
	/// The unique identifier of the beneficiary.
	/// </summary>
	[guid] $Guid { get; set; } = (New-Guid -Empty)

	/// <summary>
	/// The name of the beneficiary.
	/// </summary>
	public string Name { get; set; } = ""

	/// <summary>
	/// The postal address of the beneficiary.
	/// </summary>
	[PostalAddress] $PostalAddress { get; set; }

	/// <summary>
	/// The key of the associated Sage third-party account.
	/// </summary>
	public string ThirdPartyKey { get; set; } = ""

	/// <summary>
	/// The uncertainty status.
	/// </summary>
	[UncertaintyStatus] $UncertaintyStatus { get; set; } = [UncertaintyStatus]::Uncertain

	/// <summary>
	/// The validation status.
	/// </summary>
	[ValidationStatus] $ValidationStatus { get; set; } = [ValidationStatus]::PendingValidation

	/// <summary>
	/// Creates a new beneficiary from the specified JSON entity.
	/// </summary>
	/// <param name="psObject">The JSON entity.</param>
	/// <returns>The beneficiary corresponding to the specified JSON entity.</returns>
	public static explicit operator Beneficiary(PSObject psObject) {
		var json = (dynamic) psObject;
		return new Beneficiary() {
			CurrentPageItemsCount = json.currentPageItemsCount is int currentPageItemsCount ? currentPageItemsCount : 0,
			CurrentPageNumber = json.currentPageNumber is int currentPageNumber ? currentPageNumber : 1,
			PagesCount = json.pagesCount is int pagesCount ? pagesCount : 0,
			PageSize = json.pageSize is int pageSize ? pageSize : 1_000,
			TotalItemsCount = json.totalItemsCount is int totalItemsCount ? totalItemsCount : 0
		};
	}
}
