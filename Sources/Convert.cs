namespace Mc2it.Agicap;

using System.Collections;
using System.Globalization;

/// <summary>
/// Converts a data type to another data type.
/// </summary>
internal static class Convert {

	/// <summary>
	/// Converts the specified value to a date and time.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A date and time that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static DateTime? ToDateTime(object? value) => value switch {
		string dateTime => DateTime.TryParse(dateTime, CultureInfo.InvariantCulture, out var result) ? result : null,
		DateTime dateTime => dateTime,
		PSObject psObject => ToDateTime(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a decimal floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A decimal floating-point number that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static decimal? ToDecimal(object? value) => value switch {
		decimal number => number,
		float number => number >= (float) decimal.MinValue && number <= (float) decimal.MaxValue ? (decimal) number : null,
		double number => number >= (double) decimal.MinValue && number <= (double) decimal.MaxValue ? (decimal) number : null,
		sbyte number => number,
		short number => number,
		int number => number,
		long number => number,
		byte number => number,
		ushort number => number,
		uint number => number,
		ulong number => number,
		PSObject psObject => ToDecimal(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a dictionary.
	/// </summary>
	/// <typeparam name="T">The type of values in the dictionary.</typeparam>
	/// <param name="value">The value to convert.</param>
	/// <returns>A dictionary that is equivalent to the specified value.</returns>
	public static IDictionary<string, T> ToDictionary<T>(object? value) => value switch {
		Hashtable hashtable => hashtable.Cast<DictionaryEntry>().ToDictionary(
			entry => ToString(entry.Key) ?? "",
			entry => entry.Value is T expected ? expected : default!
		),
		PSObject psObject => psObject.Properties.ToDictionary(
			property => property.Name,
			property => property.Value is T expected ? expected : default!
		),
		_ => []
	};

	/// <summary>
	/// Converts the specified value to a double-precision floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A double-precision floating-point number that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static double? ToDouble(object? value) => value switch {
		sbyte number => number,
		short number => number,
		int number => number,
		long number => number,
		byte number => number,
		ushort number => number,
		uint number => number,
		ulong number => number,
		decimal number => decimal.ToDouble(number),
		float number => number,
		double number => number,
		PSObject psObject => ToDouble(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a enumerated value.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>An enumerated value that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static T? ToEnum<T>(object? value) where T: struct, Enum => value switch {
		T enumValue => enumValue,
		string name => Enum.TryParse<T>(name, ignoreCase: true, out var result) ? result : null,
		PSObject psObject => ToEnum<T>(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a globally unique identifier (GUID).
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A globally unique identifier (GUID) that is equivalent to the specified value.</returns>
	public static Guid? ToGuid(object? value) => value switch {
		string guid => Guid.TryParse(guid, CultureInfo.InvariantCulture, out var result) ? result : null,
		Guid guid => guid,
		PSObject psObject => ToGuid(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a 32-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A 32-bit signed integer that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static int? ToInt32(object? value) => value switch {
		sbyte number => number,
		short number => number,
		int number => number,
		long number => number >= int.MinValue && number <= int.MaxValue ? (int) number : null,
		byte number => number,
		ushort number => number,
		uint number => number <= int.MaxValue ? (int) number : null,
		ulong number => number <= int.MaxValue ? (int) number : null,
		decimal number => decimal.IsInteger(number) && number >= int.MinValue && number <= int.MaxValue ? (int) number : null,
		float number => float.IsInteger(number) && number >= int.MinValue && number <= int.MaxValue ? (int) number : null,
		double number => double.IsInteger(number) && number >= int.MinValue && number <= int.MaxValue ? (int) number : null,
		PSObject psObject => ToInt32(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// Converts the specified value to a 64-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A 64-bit signed integer that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static long? ToInt64(object? value) => value switch {
		sbyte number => number,
		short number => number,
		int number => number,
		long number => number,
		byte number => number,
		ushort number => number,
		uint number => number,
		ulong number => number <= long.MaxValue ? (long) number : null,
		decimal number => decimal.IsInteger(number) && number >= long.MinValue && number <= long.MaxValue ? (long) number : null,
		float number => float.IsInteger(number) && number >= long.MinValue && number <= long.MaxValue ? (long) number : null,
		double number => double.IsInteger(number) && number >= long.MinValue && number <= long.MaxValue ? (long) number : null,
		PSObject psObject => ToInt64(psObject.BaseObject),
		_ => null
	};

	/// <summary>
	/// TODO Converts the specified value to a list.
	/// </summary>
	/// <typeparam name="T">The type of elements in the list.</typeparam>
	/// <param name="value">The value to convert.</param>
	/// <returns>A list that is equivalent to the specified value.</returns>
	public static IList<T> ToList<T>(object? value) {
		// TODO: to be removed!
		var type = value?.GetType();
		Console.WriteLine(type?.FullName ?? "<NULL>");
		Console.WriteLine(type?.IsArray.ToString() ?? "<NULL>");
		// TODO: to be removed!

		return [];

		// return value switch {
		// 	object[] list => list.Select(item => item switch {
		// 		PSObject psObject => (T) System.Convert.ChangeType(psObject, typeof(T)),
		// 		_ => item is T expected ? expected : default!
		// 	}).ToList(),
		// 	_ => []
		// };
	}

	/// <summary>
	/// Converts the specified value to a string.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A string that is equivalent to the specified value.</returns>
	public static string? ToString(object? value) => value switch {
		null => null,
		string stringValue => stringValue,
		PSObject psObject => ToString(psObject.BaseObject),
		_ => System.Convert.ToString(value, CultureInfo.InvariantCulture)
	};

	/// <summary>
	/// Converts the specified value to a URI.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A URI that is equivalent to the specified value.</returns>
	public static Uri? ToUri(object? value) => value switch {
		string uri => Uri.TryCreate(uri, UriKind.Absolute, out var result) ? result : null,
		Uri uri => uri,
		PSObject psObject => ToUri(psObject.BaseObject),
		_ => null
	};
}
