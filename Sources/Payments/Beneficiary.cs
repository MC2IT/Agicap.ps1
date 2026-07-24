namespace Mc2it.Agicap.Payments;

/// <summary>
/// Represents a beneficiary.
/// </summary>
public class Beneficiary {

	/// <summary>
	/// The bank account of the beneficiary.
	/// </summary>
	public BankAccount? BankAccount { get; set; }

	/// <summary>
	/// The unique identifier of the beneficiary.
	/// </summary>
	public Guid Id { get; set; } = Guid.Empty;

	/// <summary>
	/// The name of the beneficiary.
	/// </summary>
	public string Name { get; set; } = "";

	/// <summary>
	/// The postal address of the beneficiary.
	/// </summary>
	public PostalAddress? PostalAddress { get; set; }

	/// <summary>
	/// The uncertainty status.
	/// </summary>
	public UncertaintyStatus UncertaintyStatus { get; set; } = UncertaintyStatus.Uncertain;

	/// <summary>
	/// The validation status.
	/// </summary>
	public ValidationStatus ValidationStatus { get; set; } = ValidationStatus.PendingValidation;

	/// <summary>
	/// Creates a new beneficiary from the specified JSON entity.
	/// </summary>
	/// <param name="psObject">The JSON entity.</param>
	/// <returns>The beneficiary corresponding to the specified JSON entity.</returns>
	public static explicit operator Beneficiary(PSObject psObject) {
		var json = (dynamic) psObject;
		var bankAccount = (BankAccount) (json.bankAccount is PSObject psBankAccount ? psBankAccount : new PSObject());
		var postalAddress = (PostalAddress) (json.postalAddress is PSObject psPostalAddress ? psPostalAddress : new PSObject());

		return new Beneficiary() {
			BankAccount = bankAccount.IsEmpty ? null : bankAccount,
			Id = json.id is string id ? Guid.Parse(id) : Guid.Empty,
			Name = json.name is string name ? name : "",
			PostalAddress = postalAddress.IsEmpty ? null : postalAddress,
			UncertaintyStatus = json.uncertaintyStatus is string uncertaintyStatus ? Enum.Parse<UncertaintyStatus>(uncertaintyStatus, ignoreCase: true) : UncertaintyStatus.Uncertain,
			ValidationStatus = json.validationStatus is string validationStatus ? Enum.Parse<ValidationStatus>(validationStatus, ignoreCase: true) : ValidationStatus.PendingValidation
		};
	}
}
