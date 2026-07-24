namespace Mc2it.Agicap.ChartOfAccounts;

/// <summary>
/// Represents an accounting account.
/// </summary>
public class AccountingAccount: IEquatable<AccountingAccount> {

	/// <summary>
	/// The accounting account name.
	/// </summary>
	public string AccountingAccountName { get; set; } = "";

	/// <summary>
	/// The accounting account number.
	/// </summary>
	public string AccountingAccountNumber { get; set; } = "";

	/// <summary>
	/// The accounting account type.
	/// </summary>
	public AccountingAccountType AccountingAccountType = AccountingAccountType.Other;

	/// <summary>
	/// An optional ERP-specific external identifier.
	/// </summary>
	public string ExternalId { get; set; } = "";

	/// <summary>
	/// The tax key.
	/// </summary>
	public string TaxKey { get; set; } = "";

	/// <summary>
	/// The VAT rate.
	/// </summary>
	public double VatRate { get; set; }

	/// <summary>
	/// Determines whether the two specified objects are equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> equals <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator ==(AccountingAccount? object1, AccountingAccount? object2) =>
		ReferenceEquals(object1, object2) || (object1?.Equals(object2) ?? false);

	/// <summary>
	/// Determines whether the two specified objects are not equal.
	/// </summary>
	/// <param name="object1">The first object.</param>
	/// <param name="object2">The second object.</param>
	/// <returns><see langword="true"/> if <c>object1</c> does not equal <c>object2</c>, otherwise <see langword="false"/>.</returns>
	public static bool operator !=(AccountingAccount? object1, AccountingAccount? object2) => !(object1 == object2);

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public override bool Equals(object? other) => Equals(other as AccountingAccount);

	/// <summary>
	/// Determines whether the specified object is equal to this object.
	/// </summary>
	/// <param name="other">An object to compare with this object.</param>
	/// <returns><see langword="true"/> if the specified object is equal to this object, otherwise <see langword="false"/>.</returns>
	public bool Equals(AccountingAccount? other) => other is not null &&
		AccountingAccountName == other.AccountingAccountName &&
		AccountingAccountNumber == other.AccountingAccountNumber &&
		AccountingAccountType == other.AccountingAccountType &&
		ExternalId == other.ExternalId &&
		TaxKey == other.TaxKey &&
		Math.Abs(VatRate - other.VatRate) < 0.000001;

	/// <summary>
	/// Gets the hash code for this object.
	/// </summary>
	/// <returns>The hash code for this object.</returns>
	public override int GetHashCode() =>
		HashCode.Combine(AccountingAccountName, AccountingAccountNumber, AccountingAccountType, ExternalId, TaxKey, VatRate);
}
