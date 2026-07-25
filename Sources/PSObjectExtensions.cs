namespace Mc2it.Agicap;

/// <summary>
/// Provides extension members for PowerShell objects.
/// </summary>
internal static class PSObjectExtensions {
	extension(PSObject psObject) {

		/// <summary>
		/// Converts the properties of this object to a dictionary.
		/// </summary>
		/// <typeparam name="T">The type of values in the dictionary.</typeparam>
		/// <returns>The dictionary corresponding to the properties of this object.</returns>
		public IDictionary<string, T> ToDictionary<T>() =>
			psObject.Properties.ToDictionary(property => property.Name, property => property.Value is T value ? value : default!);
	}
}
