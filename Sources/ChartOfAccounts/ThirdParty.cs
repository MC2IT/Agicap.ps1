namespace Mc2it.Agicap.ChartOfAccounts;

using System.Collections;

/// <summary>
/// Represents a third-party.
/// </summary>
public class ThirdParty: IEquatable<ThirdParty> {

	/// <summary>
	/// The accounting account number.
	/// </summary>
	public string AccountingAccountNumber { get; set; } = "";

	/// <summary>
	/// An optional ERP-specific external identifier.
	/// </summary>
	public string ExternalId { get; set; } = "";

	/// <summary>
	/// The code of the third-party.
	/// </summary>
	public string ThirdPartyCode { get; set; } = "";

	/// <summary>
	/// The name of the third-party.
	/// </summary>
	public string ThirdPartyName { get; set; } = "";

	/// <summary>
	/// Determines whether the two specified objects are equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> equals <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator ==(ThirdParty? object1, ThirdParty? object2) =>
		ReferenceEquals(object1, object2) || (object1?.Equals(object2) ?? false);

	/// <summary>
	/// Determines whether the two specified objects are not equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> does not equal <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator !=(ThirdParty? object1, ThirdParty? object2) => !(object1 == object2);

	/// <summary>
	/// Converts the specified third-party to a hash table.
	/// </summary>
	/// <param name="thirdParty">The third-party to convert.</param>
	/// <returns>The hash table corresponding to the specified third-party.</returns>
	public static explicit operator Hashtable(ThirdParty thirdParty) => new() {
		["accountingAccountNumber"] = string.IsNullOrWhiteSpace(thirdParty.AccountingAccountNumber) ? null : thirdParty.AccountingAccountNumber,
		["externalId"] = string.IsNullOrWhiteSpace(thirdParty.ExternalId) ? null : thirdParty.ExternalId,
		["thirdPartyCode"] = string.IsNullOrWhiteSpace(thirdParty.ThirdPartyCode) ? null : thirdParty.ThirdPartyCode,
		["thirdPartyName"] = string.IsNullOrWhiteSpace(thirdParty.ThirdPartyName) ? null : thirdParty.ThirdPartyName
	};

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public override bool Equals(object? other) => Equals(other as ThirdParty);

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public bool Equals(ThirdParty? other) => other is not null &&
		AccountingAccountNumber == other.AccountingAccountNumber &&
		ExternalId == other.ExternalId &&
		ThirdPartyCode == other.ThirdPartyCode &&
		ThirdPartyName == other.ThirdPartyName;

	/// <summary>
	/// Gets the hash code for this object.
	/// </summary>
	/// <returns>The hash code for this object.</returns>
	public override int GetHashCode() =>
		HashCode.Combine(AccountingAccountNumber, ExternalId, ThirdPartyCode, ThirdPartyName);
}
