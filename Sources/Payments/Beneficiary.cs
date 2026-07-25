namespace Mc2it.Agicap.Payments;

using System.Collections;

/// <summary>
/// Represents a beneficiary.
/// </summary>
public class Beneficiary: IEquatable<Beneficiary> {

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
	/// Determines whether the two specified objects are equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <paramref name="object1"/> equals <paramref name="object2"/>, otherwise <see langword="false"/>.</returns>
	public static bool operator ==(Beneficiary? object1, Beneficiary? object2) =>
		ReferenceEquals(object1, object2) || (object1?.Equals(object2) ?? false);

	/// <summary>
	/// Determines whether the two specified objects are not equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <paramref name="object1"/> does not equal <paramref name="object2"/>, otherwise <see langword="false"/>.</returns>
	public static bool operator !=(Beneficiary? object1, Beneficiary? object2) => !(object1 == object2);

	/// <summary>
	/// Creates a new beneficiary from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The beneficiary corresponding to the specified JSON payload.</returns>
	public static explicit operator Beneficiary(PSObject psObject) {
		var json = (dynamic) psObject;
		var bankAccount = json.bankAccount is PSObject psBankAccount ? (BankAccount) psBankAccount : new BankAccount();
		var postalAddress = json.postalAddress is PSObject psPostalAddress ? (PostalAddress) psPostalAddress : new PostalAddress();

		return new Beneficiary() {
			BankAccount = bankAccount.IsEmpty ? null : bankAccount,
			Id = Convert.ToGuid(json.id) ?? Guid.Empty,
			Name = Convert.ToString(json.name) ?? "",
			PostalAddress = postalAddress.IsEmpty ? null : postalAddress,
			UncertaintyStatus = Convert.ToEnum<UncertaintyStatus>(json.uncertaintyStatus) ?? UncertaintyStatus.Uncertain,
			ValidationStatus = Convert.ToEnum<ValidationStatus>(json.validationStatus) ?? ValidationStatus.PendingValidation
		};
	}

	/// <summary>
	/// Converts the specified beneficiary to a hash table.
	/// </summary>
	/// <param name="beneficiary">The beneficiary to convert.</param>
	/// <returns>The hash table corresponding to the specified beneficiary.</returns>
	public static explicit operator Hashtable(Beneficiary beneficiary) => new() {
		["bankAccount"] = beneficiary.BankAccount is null ? null : (Hashtable) beneficiary.BankAccount,
		["name"] = beneficiary.Name,
		["postalAddress"] = beneficiary.PostalAddress is null ? null : (Hashtable) beneficiary.PostalAddress,
	};

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public override bool Equals(object? other) => Equals(other as Beneficiary);

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public bool Equals(Beneficiary? other) => other is not null &&
		BankAccount == other.BankAccount &&
		Id == other.Id &&
		Name == other.Name &&
		PostalAddress == other.PostalAddress &&
		UncertaintyStatus == other.UncertaintyStatus &&
		ValidationStatus == other.ValidationStatus;

	/// <summary>
	/// Gets the hash code for this object.
	/// </summary>
	/// <returns>The hash code for this object.</returns>
	public override int GetHashCode() =>
		HashCode.Combine(BankAccount, Id, Name, PostalAddress, UncertaintyStatus, ValidationStatus);
}
