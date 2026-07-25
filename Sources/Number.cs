namespace Mc2it.Agicap;

/// <summary>
/// Provides helper methods to convert numeric values.
/// </summary>
public static class Number {

	/// <summary>
	/// Converts the specified value to a 32-bit signed integer.
	/// </summary>
	/// <param name="value">The value to convert.</param>
	/// <returns>A 32-bit signed integer that is equivalent to the specified value, or <see langword="null"/> if the conversion is not supported.</returns>
	public static int? AsInt32(object? value) => value switch {
		byte uint8 => uint8,
		short int16 => int16,
		int int32 => int32,
		long int64 => int64 >= int.MinValue && int64 <= int.MaxValue ? (int) int64 : null,
		_ => null
	};
}
