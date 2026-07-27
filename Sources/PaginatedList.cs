namespace Mc2it.Agicap;

/// <summary>
/// A list with information relevant to the pagination of its items.
/// </summary>
/// <typeparam name="T">The type of items in the list.</typeparam>
public class PaginatedList<T> {

	/// <summary>
	/// The list items.
	/// </summary>
	public IList<T> Items { get; set; } = [];

	/// <summary>
	/// The information relevant to the pagination of list items.
	/// </summary>
	public Pagination Pagination { get; set; } = new();

	/// <summary>
	/// Creates a new paginated list from the specified JSON payload.
	/// </summary>
	/// <typeparam name="TItem">The type of items in the list.</typeparam>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The paginated list corresponding to the specified JSON payload.</returns>
	public static PaginatedList<TItem> FromJson<TItem>(PSObject psObject) {
		var json = (dynamic) psObject;
		return new() {
			Items = Convert.ToList<TItem>(json.items),
			Pagination = json.pagination is PSObject pagination ? (Pagination) pagination : new()
		};
	}
}
