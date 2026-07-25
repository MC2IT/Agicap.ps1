namespace Mc2it.Agicap;

/// <summary>
/// Represents information relevant to the pagination of data items.
/// </summary>
public sealed class Pagination {

	/// <summary>
	/// The number of items of the current page.
	/// </summary>
	public int CurrentPageItemsCount { get; set => field = Math.Max(0, value); }

	/// <summary>
	/// The number of the current page.
	/// </summary>
	public int CurrentPageNumber { get; set => field = Math.Max(1, value); } = 1;

	/// <summary>
	/// Value indicating whether a next page exists.
	/// </summary>
	public bool HasNextPage => CurrentPageNumber < PagesCount;

	/// <summary>
	/// The total number of pages.
	/// </summary>
	public int PagesCount { get; set => field = Math.Max(0, value); }

	/// <summary>
	/// The number of items per page.
	/// </summary>
	public int PageSize { get; set => field = Math.Max(1, value); } = 1_000;

	/// <summary>
	/// Value indicating whether a previous page exists.
	/// </summary>
	public bool HasPreviousPage => CurrentPageNumber > 1;

	/// <summary>
	/// The total number of items.
	/// </summary>
	public int TotalItemsCount { get; set => field = Math.Max(0, value); }

	/// <summary>
	/// Creates a new pagination from the specified JSON payload.
	/// </summary>
	/// <param name="psObject">The JSON payload.</param>
	/// <returns>The pagination corresponding to the specified JSON payload.</returns>
	public static explicit operator Pagination(PSObject psObject) {
		var json = (dynamic) psObject;
		return new Pagination() {
			CurrentPageItemsCount = Convert.AsInt32(json.currentPageItemsCount),
			CurrentPageNumber = Convert.AsInt32(json.currentPageNumber, 1),
			PagesCount = Convert.AsInt32(json.pagesCount),
			PageSize = Convert.AsInt32(json.pageSize, 1_000),
			TotalItemsCount = Convert.AsInt32(json.totalItemsCount)
		};
	}
}
