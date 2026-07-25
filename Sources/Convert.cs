namespace Mc2it.Agicap;

using System.Collections;

/// <summary>
/// Provides helper methods to convert values.
/// </summary>
internal static class Convert {

	/// <summary>
	/// Converts the specified value to a decimal floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <param name="defaultValue">The default value to return when the conversion is not supported.</param>
	/// <returns>A decimal floating-point number that is equivalent to the specified value.</returns>
	public static decimal ToDecimal(object? value, decimal defaultValue = 0) => value switch {
		decimal number => number,
		float f32 => f32 >= (float) decimal.MinValue && f32 <= (float) decimal.MaxValue ? (decimal) f32 : defaultValue,
		double f64 => f64 >= (double) decimal.MinValue && f64 <= (double) decimal.MaxValue ? (decimal) f64 : defaultValue,
		sbyte int8 => int8,
		short int16 => int16,
		int int32 => int32,
		long int64 => int64,
		byte uint8 => uint8,
		ushort uint16 => uint16,
		uint uint32 => uint32,
		ulong uint64 => uint64,
		_ => defaultValue
	};

	/// <summary>
	/// Converts the specified value to a dictionary.
	/// </summary>
	/// <typeparam name="T">The type of values in the dictionary.</typeparam>
	/// <param name="value">The value to convert.</param>
	/// <returns>A dictionary that is equivalent to the specified value.</returns>
	public static IDictionary<string, T> ToDictionary<T>(object? value) => value switch {
		Hashtable hashtable => hashtable.Cast<DictionaryEntry>().ToDictionary(entry => entry.Key.ToString() ?? "", entry => entry.Value is T value ? value : default!),
		PSObject psObject => psObject.Properties.ToDictionary(property => property.Name, property => property.Value is T value ? value : default!),
		_ => []
	};

	/// <summary>
	/// Converts the specified value to a enumerated value.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <param name="defaultValue">The default value to return when the conversion is not supported.</param>
	/// <returns>An enumerated value that is equivalent to the specified value.</returns>
	public static T ToEnum<T>(object? value, T defaultValue = default) where T: struct, Enum => value switch {
		string name => Enum.TryParse<T>(name, ignoreCase: true, out var result) ? result : defaultValue,
		_ => defaultValue
	};

	/// <summary>
	/// Converts the specified value to a double-precision floating-point number.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <param name="defaultValue">The default value to return when the conversion is not supported.</param>
	/// <returns>A double-precision floating-point number that is equivalent to the specified value.</returns>
	public static double ToDouble(object? value, double defaultValue = 0) => value switch {
		decimal number => decimal.ToDouble(number),
		float f32 => f32,
		double f64 => f64,
		sbyte int8 => int8,
		short int16 => int16,
		int int32 => int32,
		long int64 => int64,
		byte uint8 => uint8,
		ushort uint16 => uint16,
		uint uint32 => uint32,
		ulong uint64 => uint64,
		_ => defaultValue
	};

	/// <summary>
	/// Converts the specified value to a 32-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <param name="defaultValue">The default value to return when the conversion is not supported.</param>
	/// <returns>A 32-bit signed integer that is equivalent to the specified value.</returns>
	public static int ToInt32(object? value, int defaultValue = 0) => value switch {
		decimal number => decimal.IsInteger(number) && number >= int.MinValue && number <= int.MaxValue ? (int) number : defaultValue,
		float f32 => float.IsInteger(f32) && f32 >= int.MinValue && f32 <= int.MaxValue ? (int) f32 : defaultValue,
		double f64 => double.IsInteger(f64) && f64 >= int.MinValue && f64 <= int.MaxValue ? (int) f64 : defaultValue,
		sbyte int8 => int8,
		short int16 => int16,
		int int32 => int32,
		long int64 => int64 >= int.MinValue && int64 <= int.MaxValue ? (int) int64 : defaultValue,
		byte uint8 => uint8,
		ushort uint16 => uint16,
		uint uint32 => uint32 <= int.MaxValue ? (int) uint32 : defaultValue,
		ulong uint64 => uint64 <= int.MaxValue ? (int) uint64 : defaultValue,
		_ => defaultValue
	};

	/// <summary>
	/// Converts the specified value to a 64-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <param name="defaultValue">The default value to return when the conversion is not supported.</param>
	/// <returns>A 64-bit signed integer that is equivalent to the specified value.</returns>
	public static long ToInt64(object? value, long defaultValue = 0) => value switch {
		decimal number => decimal.IsInteger(number) && number >= long.MinValue && number <= long.MaxValue ? (long) number : defaultValue,
		float f32 => float.IsInteger(f32) && f32 >= long.MinValue && f32 <= long.MaxValue ? (long) f32 : defaultValue,
		double f64 => double.IsInteger(f64) && f64 >= long.MinValue && f64 <= long.MaxValue ? (long) f64 : defaultValue,
		sbyte int8 => int8,
		short int16 => int16,
		int int32 => int32,
		long int64 => int64,
		byte uint8 => uint8,
		ushort uint16 => uint16,
		uint uint32 => uint32,
		ulong uint64 => uint64 <= long.MaxValue ? (long) uint64 : defaultValue,
		_ => defaultValue
	};
}
